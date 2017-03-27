Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH V2 0/2] Avoid bt_accept_unlink() double unlinking
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1489145686-23077-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Mon, 27 Mar 2017 16:14:23 +0200
Cc: Yichen Zhao <zhaoyichen@google.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <096CA1FA-5C69-459A-8FA9-62EC6CF90A69@holtmann.org>
References: <1489145686-23077-1-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> This is a patchset to manage a race condition between bt_accept_dequeue() and
> bt_accept_unlink() that leads to double unlinking resulting in a NULL pointer
> dereference crash.
> 
> This issue has been highlighted in the following mailing list threads:
> 
> http://www.spinics.net/lists/linux-bluetooth/msg67218.html
> "[PATCH] Bluetooth: Fix l2cap_sock_teardown_cb race condition with
> bt_accept_dequeue" by Yichen Zhao
> 
> My old V1 patchset
> https://www.spinics.net/lists/linux-bluetooth/msg69647.html
> "L2CAP l2cap_sock_teardown_cb() race condition with RFCOMM
> rfcomm_accept_connection()" by Dean Jenkins
> 
> Follow-up by Yichen Zhao on my V1 patch 2/2
> https://www.spinics.net/lists/linux-bluetooth/msg69839.html
> 
> 
> Reproduction of crash
> ---------------------
> 
> On our commercial highly modified ARM kernel 3.14 a rare crash was seen:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000013c
> pgd = 80004000
> [0000013c] *pgd=00000000
> Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> CPU: 1 PID: 1085 Comm: krfcommd Not tainted 3.14.51-03614-g82f0eab #1
> [17685.267230] task: aaa5d080 ti: aabd0000 task.ti: aabd0000
> PC is at bt_accept_unlink+0x34/0x78 [bluetooth]
> LR is at bt_accept_dequeue+0x4c/0xe0 [bluetooth]
> pc : [<7f37d1d0>]    lr : [<7f37d260>]    psr: 600d0013
> sp : aabd1e20  ip : aabd1e30  fp : aabd1e2c
> r10: b316f3bc  r9 : aab39e00  r8 : af4135c0
> r7 : aab39fc0  r6 : 9f81a600  r5 : b4786bc0  r4 : b4786a00
> r3 : 0000013c  r2 : b4786bc0  r1 : b4786bc0  r0 : b4786a00
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 388e404a  DAC: 00000015
> Process krfcommd (pid: 1085, stack limit = 0xaabd0238)
> Backtrace: 
> [<7f37d19c>] (bt_accept_unlink [bluetooth]) from [<7f37d260>] (bt_accept_dequeue+0x4c/0xe0 [bluetooth])
> [<7f37d214>] (bt_accept_dequeue [bluetooth]) from [<7f39ed64>] (l2cap_sock_accept+0x9c/0x14c [bluetooth])
> [<7f39ecc8>] (l2cap_sock_accept [bluetooth]) from [<80441a90>] (kernel_accept+0x54/0x94)
> [<80441a3c>] (kernel_accept) from [<7f3d0934>] (rfcomm_run+0x1d8/0x1088 [rfcomm])
> [<7f3d075c>] (rfcomm_run [rfcomm]) from [<8004209c>] (kthread+0xec/0x100)
> [<80041fb0>] (kthread) from [<8000e1d0>] (ret_from_fork+0x14/0x24)
> Code: e58031c0 e58031c4 e59031c8 e2833f4f (e1d320b0) 
> Kernel panic - not syncing: Fatal exception
> 
> bt_accept_dequeue() is the victim of another thread calling bt_accept_unlink()
> which causes an attempt to double unlink the same sk and this crashes.
> 
> The probability of failure can be increased by a adding a 1 second msleep here:
> 
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index cfb2fab..3d3772a 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -184,6 +184,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
> 	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
> 		sk = (struct sock *)s;
> 
> +		/* increase probability of failure by sleeping */
> +		msleep(1000);
> 		lock_sock(sk);
> 
> 		/* FIXME: Is this check still needed */
> 
> The 1 second sleep is only for test purposes and it can be reduced to say 275ms
> and still trigger the crash. Therefore, the failure is hard to reproduce without
> adding some artificial manipulation of the timing of the threads.
> 
> With the 1 second sleep test code in place, the kernel will crash every-time
> the PTS test suite runs testcase RFCOMM/DEVA-DEVB/RFC/BV-13C
> 
> This testcase performs pairing then requests a RFCOMM connection with the kernel
> and establishes a RFCOMM connection. The test does a remote line status exchange
> then immediately drops the RF connection by doing a HCI RESET command on the
> testing equipment. No DISCs are seen on RFCOMM and no L2CAP channels are
> requested to disconnect. In the kernel under test, this causes the RFCOMM and
> L2CAP layers to proceed to clean up but causes both RFCOMM and L2CAP layers to
> unlink the same sk which causes a NULL pointer crash in bt_accept_unlink().
> 
> For testing, the patches were ported on top of Linux 4.10.1 on a PC with some
> msleep debug added. The PTS testcase was run which showed that the fix worked by
> outputting the following debug in dmesg and no crash occurred:
> 
> bt_accept_dequeue: sk ffff939d7fdac400, already unlinked
> 
> 
> Description of issue
> --------------------
> 
> The issue is that bt_accept_dequeue() is not prevented from running in parallel
> with bt_accept_unlink(). There is sk locking, but this can cause the
> list_for_each_entry_safe sk loop in bt_accept_dequeue() to wait for the sk lock
> to become available. If bt_accept_dequeue() waits and then wakes-up, the sk
> pointer can become stale because bt_accept_unlink() might of been called by the
> parallel thread.
> 
> An alternative solution could be to lock the parent list as attempted by
> Yichen Zhao's patch. However, this parent locking would need to be applied in
> all possible thread combinations of bt_accept_dequeue() and bt_accept_unlink().
> Also the parent locking may be conditional as sk may or may not be in the parent
> list at the time of deciding whether to apply the parent lock and that is
> undesirable as the code becomes complex.
> 
> In addition, Yichen Zhao also pointed out in
> https://www.spinics.net/lists/linux-bluetooth/msg69839.html
> that list_for_each_entry_safe() is not thread safe. Yichen Zhao described that
> they had observed an infinite loop due to list_for_each_entry_safe() being
> intercepted by list_del_init() which caused sk to point to itself so looped
> forever.
> 
> Therefore, avoid the crash by detecting an attempt at unlinking the same sk
> twice and restart the loop (introduced in V2 patch).
> 
> 
> Solution
> --------
> 
> 1. Patch "Bluetooth: Handle bt_accept_enqueue() socket atomically"
> 
> Ensure that the socket is in the parent list with the parent member set. Do
> this by adding sk locking in bt_accept_enqueue(). Therefore, it should not be
> possible to have a socket in the parent list with a NULL parent member.
> 
> 2. Patch "Bluetooth: Avoid bt_accept_unlink() double unlinking"
> 
> Add a defensive test into bt_accept_dequeue() to check that sk has a non-NULL
> parent member otherwise sk has already been unlinked so ignore this now stale
> sk pointer.
> 
> In the V1 version of this patch the loop used "continue" after detecting that sk
> was no longer in the parent list. This potentially might get stuck in an
> infinite loop.
> 
> Therfore, the new V2 version of this patch restarts the loop when the sk is
> detected as not being in the parent list. This should avoid the possible
> infinite loop as described by Yichen Zhao by refreshing the loop variables to
> take the latest values.
> 
> 
> The following patches will apply cleanly to bluetooth-next master branch
> with head commit:
> 
> 8d70eeb Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> 
> 
> Dean Jenkins (2):
>  Bluetooth: Handle bt_accept_enqueue() socket atomically
>  Bluetooth: Avoid bt_accept_unlink() double unlinking
> 
> net/bluetooth/af_bluetooth.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

