Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 0/8] Avoid L2CAP ERTM shutdown hung tasks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Thu, 9 Jul 2015 10:42:24 +0200
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Joshua_Frkuska@mentor.com
Message-Id: <8070DCD7-709D-4B34-BD44-12D68DD71E21@holtmann.org>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> Details of the issue are described in the thread
> [RFC] Bluetooth ERTM L2CAP deadlocks (hung tasks) due to l2cap_sock_shutdown()
> and kernel.org Bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=99301
> 
> Summary
> =======
> 
> a) __l2cap_wait_ack() gets stuck in an infinite loop whilst waiting for
>   I frame acknowledgements (ACK is S or I frame from the remote device).
>   The infinite loop occurs because the waiting loop's condition never becomes
>   false. __l2cap_wait_ack() periodically sleeps for upto 200ms as
>   timeo = schedule_timeout(timeo); may return early with no signal event,
>   so is unclear why it wakes-up early.
> 
> b) The L2CAP threads for processing received frames and error recovery
>   timers become blocked on a mutex held by l2cap_sock_shutdown() which
>   prevents updating of the loop condition in __l2cap_wait_ack().
> 
> Therefore a deadlock occurs with mutex_lock(&conn->chan_lock).
> 
> This deadlock was observed by us on kernels 3.8 upto bluetooth-next on x86 and
> ARM based platforms including the Raspberry Pi kernel 3.18.14+
> 
> The testcase is simple to reproduce the hung tasks, please wait upto 10 minutes
> to observe the hung tasks:
> 
> On a laptop or other suitable device use the command:
> l2test -i hci0 -X ertm -d
> This command listens for connections with optional L2CAP ERTM supported and
> dumps out the received data.
> 
> On the unit under test use the command:
> l2test -s -b 1024 -B /dev/urandom -X ertm -P 4113 <lap_BT_ADDR>
> This command sends 1024 bytes to the laptop via PSM 4113 used by l2test over
> an ERTM channel. The command line shows:
> 
> l2test -s -b 1024 -B /dev/urandom -X ertm -P 4113 5C:F3:70:68:BA:DD
> l2test[10366]: Connected to 5C:F3:70:68:BA:DD (bredr, psm 4113, scid 64)
> l2test[10366]: Local device 5C:F3:70:68:BA:DA (bredr, psm 4113, scid 64)
> l2test[10366]: Options [imtu 672, omtu 672, flush_to 65535, mode 3, handle 11, class 0x000000, priority 0, rcvbuf 163840]
> l2test[10366]: Sending ...
> l2test[10366]: Closing channel ... 
> 
> Note that the channel fails to close because l2cap_sock_shutdown() is prevented
> from returning due to __l2cap_wait_ack being stuck in an infinite loop.
> 
> Example hung tasks are:
> 
> [  601.116119] INFO: task kworker/0:1:19 blocked for more than 120 seconds.
> [  601.116156]       Not tainted 3.18.11+ #781
> [  601.116169] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  601.116183] kworker/0:1     D c054cbcc     0    19      2 0x00000000
> [  601.116537] Workqueue: events l2cap_retrans_timeout [bluetooth]
> [  601.116685] [<c054cbcc>] (__schedule) from [<c054cfa4>] (schedule+0x40/0x8c)
> [  601.116727] [<c054cfa4>] (schedule) from [<c054d3c8>] (schedule_preempt_disabled+0x30/0x40)
> [  601.116812] [<c054d3c8>] (schedule_preempt_disabled) from [<c054ee14>] (__mutex_lock_slowpath+0xb8/0x18c)
> [  601.116856] [<c054ee14>] (__mutex_lock_slowpath) from [<c054ef20>] (mutex_lock+0x38/0x3c)
> [  601.117085] [<c054ef20>] (mutex_lock) from [<bf05173c>] (l2cap_retrans_timeout+0x24/0x5c [bluetooth])
> [  601.117371] [<bf05173c>] (l2cap_retrans_timeout [bluetooth]) from [<c003aa68>] (process_one_work+0x13c/0x444)
> [  601.117410] [<c003aa68>] (process_one_work) from [<c003b954>] (worker_thread+0x190/0x580)
> [  601.117445] [<c003b954>] (worker_thread) from [<c003fdb4>] (kthread+0xd8/0xf4)
> [  601.117488] [<c003fdb4>] (kthread) from [<c000e8c8>] (ret_from_fork+0x14/0x20)
> [  601.117569] INFO: task kworker/u3:2:327 blocked for more than 120 seconds.
> [  601.117588]       Not tainted 3.18.11+ #781
> [  601.117601] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  601.117614] kworker/u3:2    D c054cbcc     0   327      2 0x00000000
> [  601.117806] Workqueue: hci0 hci_rx_work [bluetooth]
> [  601.117941] [<c054cbcc>] (__schedule) from [<c054cfa4>] (schedule+0x40/0x8c)
> [  601.117981] [<c054cfa4>] (schedule) from [<c054d3c8>] (schedule_preempt_disabled+0x30/0x40)
> [  601.118056] [<c054d3c8>] (schedule_preempt_disabled) from [<c054ee14>] (__mutex_lock_slowpath+0xb8/0x18c)
> [  601.118092] [<c054ee14>] (__mutex_lock_slowpath) from [<c054ef20>] (mutex_lock+0x38/0x3c)
> [  601.118307] [<c054ef20>] (mutex_lock) from [<bf04d2c8>] (l2cap_get_chan_by_scid+0x28/0x98 [bluetooth])
> [  601.118696] [<bf04d2c8>] (l2cap_get_chan_by_scid [bluetooth]) from [<bf054590>] (l2cap_recv_frame+0xa4/0x2cec [bluetooth])
> [  601.119146] [<bf054590>] (l2cap_recv_frame [bluetooth]) from [<bf058194>] (l2cap_recv_acldata+0x214/0x22c [bluetooth])
> [  601.119559] [<bf058194>] (l2cap_recv_acldata [bluetooth]) from [<bf02bf88>] (hci_rx_work+0x180/0x288 [bluetooth])
> [  601.119801] [<bf02bf88>] (hci_rx_work [bluetooth]) from [<c003aa68>] (process_one_work+0x13c/0x444)
> [  601.119839] [<c003aa68>] (process_one_work) from [<c003b954>] (worker_thread+0x190/0x580)
> [  601.119883] [<c003b954>] (worker_thread) from [<c003fdb4>] (kthread+0xd8/0xf4)
> [  601.119919] [<c003fdb4>] (kthread) from [<c000e8c8>] (ret_from_fork+0x14/0x20)
> 
> This is not an exhaustive list, there are other hung task flavours.
> 
> Solution
> ========
> 
> The solution is to reorganise l2cap_sock_shutdown() to reveal the purpose of
> the function. The function shuts down the L2CAP channel but in the case when the
> channel type is ERTM, __l2cap_wait_ack() is called to wait for acknowledgements
> before the channel is shutdown.
> 
> There is some concurrency protection by using a lock on sk to prevent
> multiple instances of l2cap_sock_shutdown() from running.
> 
> SHUTDOWN_MASK is used to inhibit new I frames and other PDUs from being
> queued. Setting this flag was moved to before calling __l2cap_wait_ack() so that
> the loop would not be waiting indefinitely for ACKs. There is some risk here
> of not sending all pending data, however, an arbitrary cut-off point is needed
> otherwise the shutdown could be held off during periods of heavy traffic. This
> may need improving to inhibit only new I frames.
> 
> Extra protection to the sk and chan structures was added to prevent those
> structures being freed whilst the locks were not held. This is defensive and
> perhaps unnecessary.
> 
> __l2cap_wait_ack() was modified to be only called when necessary and the
> while loop was replaced by a do while loop because there must be at least 1
> waiting period. References to chan->conn were replaced by chan->state so that
> the mutex locks could be removed. Also waiting for ACKs is only valid whilst the
> connection is in the BT_CONNECTED state.
> 
> The scope of chan locking was reduced so that processing of received frames
> and error handling routines could operate whilst waiting for ACKs.
> 
> Additionally, for __l2cap_wait_ack() a 10 second maximum wait limit was
> implemented to prevent __l2cap_wait_ack() getting stuck in an infinite loop.
> If no expected ACKs arrive then the channel is disconnected and the error
> code -ENOLINK is returned to indicate that not all data was ACK'ed.
> 
> Testing
> =======
> 
> This has been tested in kernels 3.8 and 3.14 on an ARM based board for a
> commercial product. Results show that the hung tasks no longer occur.
> 
> Note that the failure scenario was Media player media browsing. Waiting for
> ACK's is unimportant in this scenario because it does not matter whether
> a media browsing request such as "get item" was successfully transferred at the
> point of shutting down the channel.
> 
> These v2 patches have not been tested on a bluetooth-next based build. However,
> sjanc on the Bluetooth IRC channel tested the v1 patches using the PTS testcases
> and found no regressions. If v2 were to be tested, then similar results to v1
> should be seen.
> 
> v2 changes
> ==========
> 
> 0007-Bluetooth-__l2cap_wait_ack-use-msecs_to_jiffies.patch was introduced
> to tidy-up the original code's use of HZ. Now msecs_to_jiffies() is used
> instead of HZ. This was done in response to review comments.
> 
> 0008-Bluetooth-__l2cap_wait_ack-add-defensive-timeout.patch was introduced
> to replace the v1 0007 patch. The solution now uses a 10 second jiffy based
> timeout mechanism instead of a loop counter limit. The new solution is more
> accurate and easier to maintain than the loop counter limit.
> 
> Risks
> =====
> 
> The mutex lock mutex_lock(&conn->chan_lock) has been removed whilst
> l2cap_chan_close() runs in l2cap_sock_shutdown(). l2cap_chan_lock(chan) is
> protecting l2cap_chan_close() against concurrent procedural handling events for
> the channel at the L2CAP level.
> 
> Analysis indicates chan->conn is used as an indication that the underlying ACL
> connection is still up. l2cap_chan_del() sets chan->conn = NULL and all calls to
> l2cap_chan_del() seem to be done with the l2cap_chan_lock(chan) held. Therefore,
> it should not be possible for chan->conn to become unexpectedly NULL during the
> execution of l2cap_chan_close(). The locking seems to be sufficient.
> 
> Patchset
> ========
> 
> Patches are based on bluetooth-next:
> 
> Dean Jenkins (8):
>  Bluetooth: L2CAP ERTM shutdown protect sk and chan
>  Bluetooth: Make __l2cap_wait_ack more efficient
>  Bluetooth: Unwind l2cap_sock_shutdown()
>  Bluetooth: l2cap_sock_shutdown() remove mutex_lock calls
>  Bluetooth: l2cap_sock_shutdown() reduce scope of chan locking
>  Bluetooth: Add BT_DBG to l2cap_sock_shutdown()
>  Bluetooth: __l2cap_wait_ack() use msecs_to_jiffies()
>  Bluetooth: __l2cap_wait_ack() add defensive timeout
> 
> include/net/bluetooth/l2cap.h |  2 ++
> net/bluetooth/l2cap_sock.c    | 74 +++++++++++++++++++++++++++----------------
> 2 files changed, 49 insertions(+), 27 deletions(-)

all 8 patches have been applied to bluetooth-next tree.

Regards

Marcel

