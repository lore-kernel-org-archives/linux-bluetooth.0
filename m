Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V1 0/1] hci_ldisc: Use rwlocking to avoid closing proto
 races
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1493998026-14355-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Fri, 5 May 2017 17:55:09 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <FD48FC66-E3FE-46F0-9872-4ECB8C3946DB@holtmann.org>
References: <1493998026-14355-1-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> This is my 3rd patchset in my series of resolving a design flaw in
> hci_uart_tty_close() related to the proper closure of the Data Link protocol
> layer which can result in a kernel crash.
> 
> This patchset contains a single patch that adds rwlocking around the "proto"
> function pointers. This provides a full fix to prevent a potential kernel crash
> triggered by hu->proto->close() running before or during the execution of a
> non-close "proto" function pointer.
> 
> 
> Previous Discussions
> ====================
> 
> Please refer to the discussion on my 2nd patchset V1 that can be found here:
> https://www.spinics.net/lists/linux-bluetooth/msg70370.html
> You accepted the 3 patches of my patchset of commits namely:
>  Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()
>  Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
>  Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()
> 
> drivers/bluetooth/hci_ldisc.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
> 
> Please refer to the discussion on my 1st patchset V3 that can be found here:
> https://www.spinics.net/lists/linux-bluetooth/msg70315.html
> You accepted the 3 patches of my patchset of commits namely:
>  Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
>  Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
>  Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
> 
> drivers/bluetooth/hci_ldisc.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Please refer to the discussion on my 1st patchset V2 that can be found here:
> https://www.spinics.net/lists/linux-bluetooth/msg70183.html
> 
> Please refer to the discussion on my 1st RFC patchset V1 that can be found here:
> https://www.spinics.net/lists/linux-bluetooth/msg70077.html
> 
> 
> Analysis
> ========
> 
> There are multiple threads that use "proto" function pointers that potentially
> can be running concurrently with the thread of hci_uart_tty_close().
> 
> The threads include (not a complete list):
> 
> a) hci_uart_write_work() [hci_ldisc.c]
>   which is executed by the work queue hu->write_work which creates the
>   callstack:
>   hci_uart_write_work()
>   hci_uart_dequeue()
>   hu->proto->dequeue()
> 
> b) hci_tx_work() [hci_core.c]
>   which is executed by the work queue hdev->tx_work which creates the
>   callstack:
>   hci_tx_work()
>   hci_send_frame()
>   hdev->send()
>   hci_uart_send_frame()
>   hu->proto->enqueue()
>   then calls
>   hci_uart_tx_wakeup()
>   schedule_work(&hu->write_work)
>   triggering a)
> 
> c) hci_cmd_work() [hci_core.c]
>   which is executed by the work queue hdev->cmd_work which creates the
>   callstack:
>   hci_cmd_work()
>   hci_send_frame()
>   hdev->send()
>   hci_uart_send_frame()
>   hu->proto->enqueue()
>   then calls
>   hci_uart_tx_wakeup()
>   schedule_work(&hu->write_work)
>   triggering a)
> 
> d) hci_dev_close() [hci_core.c]
>   creates the callstack:
>   hci_dev_close()
>   hci_dev_do_close()
>   hdev->flush()
>   hci_uart_flush()
>   hu->proto->flush()
> 
> e) When BCSP is used and a retransmission is needed:
>   bcsp_timed_event() [hci_bcsp.c]
>   creates the callstack:
>   bcsp_timed_event()
>   hci_uart_tx_wakeup()
>   schedule_work(&hu->write_work)
>   triggering a)
> 
> 
> hci_ldisc.c: hci_uart_tty_close() currently has the construction:
> 
> 	cancel_work_sync(&hu->write_work);
> 
> 	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> 		if (hdev) {
> 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
> 				hci_unregister_dev(hdev);
> 			hci_free_dev(hdev);
> 		}
> 		hu->proto->close(hu);
> 	}
> 
> At first glance, the cancel_work_sync(&hu->write_work) would seem to inhibit
> hci_uart_write_work() from running. Actually, the call to cancel_work_sync()
> can be ineffective because:
> 
> a) hci_unregister_dev() calls hci_dev_do_close() and if HCI_UP flag is in the
>   set state then it is possible for hci_dev_do_close() to send a HCI command.
>   Such as sending a HCI RESET command which causes hci_send_frame() to schedule
>   hci_uart_write_work() after the cancel_work_sync() has executed.
> 
> b) In the case of BCSP retransmissions, the callstack in e) runs periodically
>   every 250ms. This can occur before and after the cancel_work_sync() executed.
> 
> 
> The call to hu->proto->close(hu) is partially protected by the flag
> HCI_UART_PROTO_READY but there is a small race condition. A race condition
> exists because hci_uart_tty_close() can clear HCI_UART_PROTO_READY just after
> the concurrent thread(s) detected the flag as set. The race potentially allows
> the concurrent thread(s) to run a "proto" function pointer after or during
> hci_uart_tty_close() is calling hu->proto->close(hu) which could trigger a
> kernel crash.
> 
> Bear in mind that on systems with low resources, such as embedded systems, that
> threads can get delayed by interrupts and pre-emption. This means that a
> concurrent thread might sleep after it checks the HCI_UART_PROTO_READY flag.
> Therefore, just using the flag HCI_UART_PROTO_READY is not 100% safe from
> introducing race conditions.
> 
> Note that the elapsed run-time for hci_unregister_dev() is dependent on a
> number of scenarios. This means hci_unregister_dev() can quickly return or take
> up to 10 seconds (guess) to return. This means that the elapsed time between
> clearing HCI_UART_PROTO_READY and executing hu->proto->close(hu) is variable
> and therefore there is a variable risk in triggering the kernel crash.
> 
> 
> Solution implemented by this patchset
> =====================================
> 
> Modify hci_ldisc.c: hci_uart_tty_close() to use a rwlock solution:
> 
> 	cancel_work_sync(&hu->write_work);
> 
> 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> 		write_lock_irqsave(&hu->proto_lock, flags);
> 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> 		write_unlock_irqrestore(&hu->proto_lock, flags);
> 
> 		if (hdev) {
> 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
> 				hci_unregister_dev(hdev);
> 			hci_free_dev(hdev);
> 		}
> 		hu->proto->close(hu);
> 	}
> 
> The call to write_lock_irqsave(&hu->proto_lock, flags) will block when a
> concurrent thread has called read_lock(&hu->proto_lock). This ensures that
> the flag HCI_UART_PROTO_READY is only cleared when no "proto" function pointers
> are running in the concurrent threads. Therefore, it is not possible for
> any "proto" function pointers to be running immediately before, during or after
> hu->proto->close(hu) is called. This means the race condition is avoided.
> 
> Note that this solution will inhibit the Data Link layer protocol from
> independently retransmitting because hu->proto->enqueue() cannot be called after
> HCI_UART_PROTO_READY has been put into the clear state.
> 
> 
> Test results from running the patchset
> ======================================
> 
> A x86 64-bit test kernel was created based on kernel v4.11.0 plus the 7 patches:
> 
> 3rd Patchset
>  Bluetooth: hci_ldisc: Use rwlocking to avoid closing proto races
> 2nd Patchset 
>  Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()
>  Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
>  Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()
> 1st Patchset 
>  Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
>  Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
>  Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
> 
> The test used btattach with BCSP which fails to establish a link because BCSP
> is not fully implemented in the kernel. However, this is ideal in forcing
> BCSP retransmissions. btattach was killed after 5 seconds of running to force
> hci_uart_tty_close() to execute.
> 
> Here is a snippet of a dmesg log with dynamic debug enabled:
> [ 1039.415914] hci_uart_tty_close: tty ffff9861c691d800
> [ 1039.415917] hci_uart_close: hdev ffff98625b422000
> [ 1039.415920] hci_uart_flush: hdev ffff98625b422000 tty ffff9861c691d800
> [ 1039.415922] bcsp_flush: hu ffff9861c27bd480
> [ 1039.415928] hci_unregister_dev: ffff98625b422000 name hci1 bus 3
> [ 1039.418767] bcsp_timed_event: hu ffff9861c27bd480 retransmitting 2 pkts
> [ 1039.674810] Bluetooth: hci1 command 0x1001 tx timeout
> [ 1039.674827] hci_cmd_work: hci1 cmd_cnt 1 cmd queued 1
> [ 1039.674832] hci_send_frame: hci1 type 1 len 3
> [ 1039.674836] hci_uart_send_frame: hci1: type 1 len 3
> [ 1039.674838] Bluetooth: hci1 sending frame failed (-49)
> [ 1041.722773] Bluetooth: hci1 command 0x1009 tx timeout
> [ 1041.722811] hci_cmd_work: hci1 cmd_cnt 1 cmd queued 0
> [ 1045.818847] hci_uart_close: hdev ffff98625b422000
> [ 1045.818850] hci_uart_flush: hdev ffff98625b422000 tty ffff9861c691d800
> [ 1045.818868] hci_dev_do_close: hci1 ffff98625b422000
> [ 1045.819031] hci_conn_params_clear_all: All LE connection parameters were removed
> [ 1045.819036] bcsp_close: hu ffff9861c27bd480
> 
> The following can be observed from the results:
> 
> 1. hci_unregister_dev() ran which means HCI_UART_PROTO_READY has been cleared.
> 
> 2. bcsp_timed_event() runs after HCI_UART_PROTO_READY has been cleared and
>   so hci_uart_tx_wakeup() no longer appears in the log. This inhibits further
>   BCSP retransmission attempts.
> 
> 3. Bluetooth: hci1 command 0x1001 tx timeout
>   This occurs because BCSP was unable to successfully transfer the HCI
>   command. BCSP fails because the data plane to and from the UART driver is no
>   longer working.
> 
> 4. Bluetooth: hci1 sending frame failed (-49)
>   This occurs because HCI_UART_PROTO_READY has been cleared which inhibits
>   a new HCI command being sent from hci_cmd_work().
> 
> 5. Bluetooth: hci1 command 0x1009 tx timeout
>   BCSP never took the HCI command but the HCI core still performs the HCI
>   command timeout. This means the thread gets blocked for 2 seconds for doing
>   nothing.
> 
> 6. hci_uart_close() runs twice which seems to be unnecessary. This causes
>   hci_uart_flush() to run twice but notice the 2nd execution of
>   hci_uart_flush() does not run bcsp_flush() because hdev->flush gets set to
>   NULL in hci_uart_close(). This suggests a workaround was done in the past
>   to prevent a kernel crash.
> 
> 
> Outline of potential further work
> =================================
> 
> With this patchset, the design flaw in hci_uart_tty_close() is further exposed.
> 
> It can be seen that hci_uart_tty_close() is systematically preventing
> communications with the Bluetooth Radio Module. But hci_uart_tty_close() calls
> hci_unregister_dev() which calls hci_dev_do_close(). If the flag HCI_UP is in
> the set state then hci_dev_do_close() assumes that good communications with the
> Bluetooth Radio Module are still possible. Therefore, there is a conflict in the
> design because the design should not be closing the link and trying to use the
> link to send HCI commands at the same time. This can trigger the protocol error
> handling procedures to occur which are unsuccessful.
> 
> In addition, it is suspected that before hci_uart_tty_close() runs, the TTY
> layer has cut the data plane between the Data Link protocol and the UART driver.
> This means that if hci_uart_tty_close() is rearranged to allow
> HCI_UART_PROTO_READY to be cleared after hci_unregister_dev() runs then any HCI
> command will still fail to reach the Bluetooth Radio Module.
> 
> There are other issues in hci_ldisc.c: hci_uart_tty_close()
> 
> 	/* Detach from the tty */
> 	tty->disc_data = NULL;
> 
> 	if (!hu)
> 		return;
> 
> 	hdev = hu->hdev;
> 	if (hdev)
> 		hci_uart_close(hdev);
> 
> It can be seen that tty->disc_data is set to NULL. This causes some of the HCI
> UART LDISC functions to not perform any operation such as the functions:
> 
> hci_uart_tty_wakeup()
> hci_uart_tty_receive()
> hci_uart_tty_ioctl()
> 
> Doing "tty->disc_data = NULL" sabotages the communications with the Bluetooth
> Radio Module. Therefore, this statement needs to be moved to after the
> communications are going to be cleanly closed such as after hci_unregister_dev()
> has completed.
> 
> Calling hci_uart_close(hdev) is likely to interfere with the communications with
> the Bluetooth Radio Module. Therefore, this statement needs to be moved to after
> the communications are going to be cleanly closed such as after
> hci_unregister_dev() has completed.
> 
> 
> Potential solution to the design flaw
> =====================================
> 
> Suspect that a solution would be to get hci_uart_tty_close() to run
> hci_unregister_dev() before tearing down the resources needed by the
> Data Link protocol layer.
> 
> 
> The patch was rebased onto the bluetooth-next master branch HEAD commit:
> 2da711a Bluetooth: Skip vendor diagnostic configuration for HCI User Channel
> 
> Dean Jenkins (1):
>  Bluetooth: hci_ldisc: Use rwlocking to avoid closing proto races
> 
> drivers/bluetooth/hci_ldisc.c | 40 +++++++++++++++++++++++++++++++++++-----
> drivers/bluetooth/hci_uart.h  |  1 +
> 2 files changed, 36 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

