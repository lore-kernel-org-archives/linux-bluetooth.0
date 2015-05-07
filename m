Return-Path: <cyrus@holtmann.org>
Message-ID: <554B8439.9020409@mentor.com>
Date: Thu, 7 May 2015 16:26:49 +0100
From: Dean Jenkins <Dean_Jenkins@mentor.com>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "Frkuska,
 Joshua" <Joshua_Frkuska@mentor.com>
Subject: [RFC] Bluetooth ERTM L2CAP deadlocks (hung tasks) due to l2cap_sock_shutdown()
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Gustavo and Johan,

Please see the end of the E-mail for a workaround, do you agree with the 
workaround, any comments ?

Description of L2CAP ERTM deadlock
======================

Using kernel 3.8 on an ARM i.MX6 based platform, we have identified some 
deadlock situations involving L2CAP ERTM. We believe kernel v4.0.1 can 
deadlock as well (not tested it) as the affected code is similar to 
kernel 3.8.

With a L2CAP ERTM channel connected, and l2cap_sock_shutdown() is 
called, then __l2cap_wait_ack() is called which is supposed to wait for 
all sent I frames to be acknowledged.

l2cap_sock_shutdown() takes all 3 locks namely:

mutex_lock(&conn->chan_lock);
l2cap_chan_lock(chan);
lock_sock(sk);

__l2cap_wait_ack() is implemented as follows:

int __l2cap_wait_ack(struct sock *sk)
{
     struct l2cap_chan *chan = l2cap_pi(sk)->chan;
     DECLARE_WAITQUEUE(wait, current);
     int err = 0;
     int timeo = HZ/5;

     add_wait_queue(sk_sleep(sk), &wait);
     set_current_state(TASK_INTERRUPTIBLE);
     while (chan->unacked_frames > 0 && chan->conn) {
         if (!timeo)
             timeo = HZ/5;

         if (signal_pending(current)) {
             err = sock_intr_errno(timeo);
             break;
         }

         release_sock(sk);
         timeo = schedule_timeout(timeo);
         lock_sock(sk);
         set_current_state(TASK_INTERRUPTIBLE);

         err = sock_error(sk);
         if (err)
             break;
     }
     set_current_state(TASK_RUNNING);
     remove_wait_queue(sk_sleep(sk), &wait);
     return err;
}

Analysis shows that the while loop checks chan->unacked_frames > 0 and 
chan->conn is !NULL. So when both are true the loop waits (sleeps) for 
200ms using schedule_timeout() and then rechecks the while loop 
conditions before waiting again.

Unfortunately, during this waiting (sleeping) period the following locks 
are still held:
mutex_lock(&conn->chan_lock);
l2cap_chan_lock(chan);

These held locks prevent l2cap_recv_frame() from processing the received 
ACKs for the sent I frames in ERTM. This means chan->unacked_frames > 0 
remains true.

chan->conn cannot be set to NULL by the channel being closed by other 
means as the held locks prevent the state being updated.

Therefore a deadlock occurs because __l2cap_wait_ack() gets stuck in an 
infinite loop which periodically waits (sleeps). The kernel's hung task 
detector is not able to detect this "hung" thread because the thread 
periodically runs. This means l2cap_sock_shutdown() does not return. 
With debug, we have proven that the infinite loop occurs.

Here is an example hung task log and LOCKDEP output of a L2CAP ERTM 
deadlock scenario: (we do have some other different traces as well so 
more than 1 failure scenario exists)

[  360.497912] INFO: task kworker/u:0H:7 blocked for more than 180 seconds.
[  360.497931] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  360.497944] kworker/u:0H    D 8046bb28     0     7      2 0x00000000
[  360.498051] Backtrace:
[  360.498145] [<8046b624>] (__schedule+0x0/0x790) from [<8046be3c>] 
(schedule+0x88/0x8c)
[  360.498231] [<8046bdb4>] (schedule+0x0/0x8c) from [<8046c1c8>] 
(schedule_preempt_disabled+0x18/0x24)
[  360.498318] [<8046c1b0>] (schedule_preempt_disabled+0x0/0x24) from 
[<80469b70>] (mutex_lock_nested+0x250/0x3e8)
[  360.498495] [<80469920>] (mutex_lock_nested+0x0/0x3e8) from 
[<7f44d2a8>] (l2cap_get_chan_by_scid+0x24/0x54 [bluetooth])
[  360.498696] [<7f44d284>] (l2cap_get_chan_by_scid+0x0/0x54 
[bluetooth]) from [<7f453f68>] (l2cap_recv_frame+0x1918/0x1cc8 [bluetooth])
[  360.498779]  r6:0000006b r5:9773ef00 r4:96bfdc00 r3:0000003f
[  360.498919] [<7f452650>] (l2cap_recv_frame+0x0/0x1cc8 [bluetooth]) 
from [<7f454e3c>] (l2cap_recv_acldata+0xc0/0x1f8 [bluetooth])
[  360.499088] [<7f454d7c>] (l2cap_recv_acldata+0x0/0x1f8 [bluetooth]) 
from [<7f437c74>] (hci_rx_work+0x1b4/0x2ec [bluetooth])
[  360.499176]  r6:9759a000 r5:9759a77c r4:9773ef00 r3:00000000
[  360.499259] [<7f437ac0>] (hci_rx_work+0x0/0x2ec [bluetooth]) from 
[<8003ee1c>] (process_one_work+0x344/0x540)
[  360.499352] [<8003ead8>] (process_one_work+0x0/0x540) from 
[<8003f2e4>] (worker_thread+0x298/0x3ec)
[  360.499449] [<8003f04c>] (worker_thread+0x0/0x3ec) from [<80044a40>] 
(kthread+0xb4/0xc0)
[  360.499543] [<8004498c>] (kthread+0x0/0xc0) from [<8000da30>] 
(ret_from_fork+0x14/0x24)
[  360.499622]  r7:00000000 r6:00000000 r5:8004498c r4:a40a3e34
[  360.499880]
Showing all locks held in the system:
[  360.499909] 3 locks held by kworker/u:0H/7:
[  360.499921]  #0:  (hdev->name){++++..}, at: [<8003ed28>] 
process_one_work+0x250/0x540
[  360.499968]  #1:  ((&hdev->rx_work)){+.+...}, at: [<8003ed28>] 
process_one_work+0x250/0x540
[  360.500009]  #2:  (&conn->chan_lock){+.+...}, at: [<7f44d2a8>] 
l2cap_get_chan_by_scid+0x24/0x54 [bluetooth]
<snip>
[  360.500256] 3 locks held by kworker/1:2/64:
[  360.500266]  #0:  (events){.+.+..}, at: [<8003ed28>] 
process_one_work+0x250/0x540
[  360.500307]  #1: ((&(&chan->retrans_timer)->work)){+.+...}, at: 
[<8003ed28>] process_one_work+0x250/0x540
[  360.500346]  #2:  (&chan->lock){+.+...}, at: [<7f450414>] 
l2cap_retrans_timeout+0x24/0x58 [bluetooth]
<snip>
[  360.502066] 2 locks held by <userland BT daemon>/1433:
[  360.502076]  #0:  (&conn->chan_lock){+.+...}, at: [<7f455378>] 
l2cap_sock_shutdown+0x34/0x130 [bluetooth]
[  360.502179]  #1:  (&chan->lock){+.+...}, at: [<7f455388>] 
l2cap_sock_shutdown+0x44/0x130 [bluetooth]
<snip>

It can be seen that l2cap_get_chan_by_scid() is blocked so that the ACK 
cannot be processed and l2cap_retrans_timeout() has timed out in an 
attempt to retransmit the I frame but is also blocked. The Bluetooth 
stack is now paralysed.

This scenario will fail every time. The locking seems to be flawed in 
l2cap_sock_shutdown() for L2CAP ERTM. Did it ever work ?


Workaround
========

Here is our workaround patch (based on kernel 3.8) which releases all 
the locks before waiting (sleeping):

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a53f47a..bf49066 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1766,7 +1766,13 @@ int __l2cap_wait_ack(struct sock *sk)
                 }

                 release_sock(sk);
+               l2cap_chan_unlock(chan);
+               if (chan->conn)
+ mutex_unlock(&chan->conn->chan_lock);
                 timeo = schedule_timeout(timeo);
+               if (chan->conn)
+ mutex_lock(&chan->conn->chan_lock);
+               l2cap_chan_lock(chan);
                 lock_sock(sk);
                 set_current_state(TASK_INTERRUPTIBLE);

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 657b3a4..bd0d1ae 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -867,8 +867,10 @@ static int l2cap_sock_shutdown(struct socket *sock, 
int how)
         lock_sock(sk);

         if (!sk->sk_shutdown) {
-               if (chan->mode == L2CAP_MODE_ERTM)
+               if (chan->mode == L2CAP_MODE_ERTM) {
                         err = __l2cap_wait_ack(sk);
+                       conn = chan->conn;
+               }

                 sk->sk_shutdown = SHUTDOWN_MASK;

If you think this is the right approach then we will formally create a 
patch and send it to the mailing list for review.

Our initial tests show that the deadlock no longer occurs with the patch 
applied, but we are worried about side effects.

We have some doubts:

a) What are the locks protecting ? Do all 3 locks need to be taken ?

b) Can a better architectural solution be created that avoids the locks ?

Perhaps arm the channel to disconnect, then after all ACKs have been 
received, call a callback to wake up l2cap_sock_shutdown ?

c) What stops new I frames being sent during the waiting period so 
chan->unacked_frames increases ?

Thanks for your time.

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.
