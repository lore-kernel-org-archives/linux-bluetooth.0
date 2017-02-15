Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: L2CAP l2cap_sock_teardown_cb() race condition with RFCOMM
 rfcomm_accept_connection()
To: Yichen Zhao <zhaoyichen@google.com>, Marcel Holtmann <marcel@holtmann.org>
References: <45EE47FA-D319-4091-941A-C4005E32B572@holtmann.org>
 <1463173230-16159-1-git-send-email-zhaoyichen@google.com>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Message-ID: <2704ecde-aaea-9743-d5b7-ad57afec73a7@mentor.com>
Date: Wed, 15 Feb 2017 11:14:37 +0100
MIME-Version: 1.0
In-Reply-To: <1463173230-16159-1-git-send-email-zhaoyichen@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

My E-mail below is based on Yichen Zhao's 2016 E-mail from the mailing 
list thread
http://www.spinics.net/lists/linux-bluetooth/msg67218.html

On 13/05/16 23:00, Yichen Zhao wrote:
>> so I am not big fan of the conditional locking in case of parent is set or not. Do you have a test case that reproduces the mentioned race. It would love to have that in tools/l2cap-tester or similar.
> So far I could only reproduce the bug by repeatedly performing RFCOMM connections and resets. I'll try to implement something in rfcomm-tester or l2cap-tester.
>
> Since this is a race condition, I'm not confident that I can help you reproduce the bug reliably on a different test setup. I'd appreciate it very much if you can offer any tips on triggering a race condition faster in a test case.

We see a similar crash in a highly modified 3.14 kernel on ARM but I 
think this failure is still possible in bluetooth-next based on kernel 
4.10-rc2.

I think the failure scenario is as follows:

RFCOMM is processing the rfcomm_accept_connection() whilst L2CAP is 
tearing down the L2CAP channel in l2cap_sock_teardown_cb().

This means there are 2 threads racing with each other; there is the 
RFCOMM krfcommd kernel thread and the userland system call thread 
demanding L2CAP is torn down via l2cap_chan_del() (I think).

The real-world failure is seen in userland abruptly terminating 
Bluetooth connections such as switching to a pairing mode. Note that our 
system does not use Bluez userland.

>> Maybe the code needs some restructuring to avoid the conditional locking.
> I agree that my patch is not very elegant, and I'd love any way to improve it.
> I have some ideas, but I'm not familiar enough with kernel development to know whether other solutions are safe to implement, such as:
>
> * Removing bt_accept_unlink from l2cap_teardown_cb, and relying on bt_accept_dequeue to unlink the socket when it's enumerated. Is it safe to leave a zapped sock in accept_q?
> * Perform "unlock sock; lock parent; lock sock" before calling bt_accept_unlink in teardown_cb. This is still conditional locking, but around a smaller block of code. Is it safe to unlock a zapped sock?
> * Use RCU for handling accept_q. Is this appropriate?
>
> Please let me know what you think.

Our analysis suggests that there is a locking weakness here in 
net/bluetooth/af_bluetooth.c:

 From bluetooth-next based on kernel 4.10-rc2

> struct sock *bt_accept_dequeue(struct sock *parent, struct socket 
> *newsock)
> {
>     struct bt_sock *s, *n;
>     struct sock *sk;
>
>     BT_DBG("parent %p", parent);
>
>     list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
>         sk = (struct sock *)s;

There is a risk that the sk socket gets modified here by another thread 
or via pre-emption because there is no protection of sk with respect to 
list operations on the parent. Any locking of the parent is done outside 
of bt_accept_dequeue().

In other words, sk can be removed from the list by another thread which 
could mean that sk has been freed. Therefore, performing a lock on sk 
that has been freed is invalid and dangerous.

We suspect that bt_accept_unlink(sk) gets called by the other thread 
which will remove sk from the list and set bt_sk(sk)->parent = NULL; 
also potentially sk is freed as well.

>         lock_sock(sk);

Taking the sk lock here can be too late as sk may already have been 
removed from the list.

>
>         /* FIXME: Is this check still needed */
>         if (sk->sk_state == BT_CLOSED) {
>             bt_accept_unlink(sk);

NULL pointer dereference occurs in "2nd call" to bt_accept_unlink(sk) 
because bt_sk(sk)->parent is NULL and crashes the bt_accept_unlink(sk) line:
bt_sk(sk)->parent->sk_ack_backlog--;

>             release_sock(sk);
>             continue;
>         }
>
>         if (sk->sk_state == BT_CONNECTED || !newsock ||
>             test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags)) {
>             bt_accept_unlink(sk);
>             if (newsock)
>                 sock_graft(sk, newsock);
>
>             release_sock(sk);
>             return sk;
>         }
>
>         release_sock(sk);
>     }
>
>     return NULL;
> }

We think the other thread is running l2cap_sock_teardown_cb() as pointed 
out by Yichen Zhao (thanks for the hint).

We made the assumption that l2cap_sock_teardown_cb is acting on the same 
sk socket as sk in bt_accept_dequeue().

In net/bluetooth/l2cap_sock.c from bluetooth-next based on kernel 4.10-rc2

> static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
> {
>     struct sock *sk = chan->data;
>     struct sock *parent;
>
>     BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
>
>     /* This callback can be called both for server (BT_LISTEN)
>      * sockets as well as "normal" ones. To avoid lockdep warnings
>      * with child socket locking (through l2cap_sock_cleanup_listen)
>      * we need separation into separate nesting levels. The simplest
>      * way to accomplish this is to inherit the nesting level used
>      * for the channel.
>      */
>     lock_sock_nested(sk, atomic_read(&chan->nesting));

Taking a lock on sk does not prevent the failure because 
bt_accept_dequeue() can run until it waits for the lock.
This is likely to synchronise and serialise the 2 threads which results 
in bt_accept_unlink(sk) being called twice for the same sk.

>
>     parent = bt_sk(sk)->parent;

Here parent is taken from the sk socket.
If parent is not NULL, the sk is still in the parent list of 
bt_accept_dequeue().

>
>     sock_set_flag(sk, SOCK_ZAPPED);
>
>     switch (chan->state) {
>     case BT_OPEN:
>     case BT_BOUND:
>     case BT_CLOSED:
>         break;
>     case BT_LISTEN:
>         l2cap_sock_cleanup_listen(sk);
>         sk->sk_state = BT_CLOSED;
>         chan->state = BT_CLOSED;
>
>         break;
>     default:
>         sk->sk_state = BT_CLOSED;
>         chan->state = BT_CLOSED;
>
>         sk->sk_err = err;
>
>         if (parent) {
>             bt_accept_unlink(sk);

This call to bt_accept_unlink() removes sk from the list, sets 
bt_sk(sk)->parent to NULL and potentially frees sk.

We think this can trigger this crash in RFCOMM:

rfcomm_run() calls
rfcomm_accept_connection() calls
kernel_accept() calls
l2cap_sock_accept() calls
bt_accept_dequeue() which runs concurrently with l2cap_sock_teardown_cb()
bt_accept_unlink() is called from l2cap_sock_teardown_cb()
bt_accept_unlink() is called from bt_accept_dequeue() causing a NULL 
pointer dereference crash

>  parent->sk_data_ready(parent);
>         } else {
>             sk->sk_state_change(sk);
>         }
>
>         break;
>     }
>
>     release_sock(sk);
> }

I am not familiar with rfcomm-tester or l2cap-tester so I don't know 
whether these tools are capable of reproducing this failure case.

Yichen Zhao's patch shown in 
http://www.spinics.net/lists/linux-bluetooth/msg67189.html would seem to 
be a solution to this crash. We have not yet tested the patch but the 
principle looks right to me.

I agree that conditional locking looks strange but if parent is not NULL 
then bt_accept_unlink() must not be called without the parent lock being 
held.

Do you have any thoughts on the issue ?

Thanks,

Regards,
Dean

-- 

Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.

www.mentor.com/embedded
