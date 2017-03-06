Return-Path: <zhaoyichen@google.com>
MIME-Version: 1.0
In-Reply-To: <1488825102-29594-3-git-send-email-Dean_Jenkins@mentor.com>
References: <1488825102-29594-1-git-send-email-Dean_Jenkins@mentor.com> <1488825102-29594-3-git-send-email-Dean_Jenkins@mentor.com>
From: Yichen Zhao <zhaoyichen@google.com>
Date: Mon, 6 Mar 2017 13:59:10 -0800
Message-ID: <CAKXz-fQydoRSCXSsni-ToLc8HzuveBBupa00zCTMKfac9_Oq4Q@mail.gmail.com>
Subject: Re: [PATCH V1 2/2] Bluetooth: Avoid bt_accept_unlink() double unlinking
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F . Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Dean:

Thank you for reviving this issue. You are definitely more thorough than I had
been; I had never noticed the locking weakness in bt_accept_enqueue.

I just want to point out that there still remains another critical race
condition between bt_accept_dequeue and bt_accept_unlink, even with your patch
applied.

The race condition exists between the following two lines:
1. af_bluetooth.c:186 (bt_accept_dequeue+7):
   list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
   This line runs with lock_sock(parent) held.
2. af_bluetooth.c:172 (bt_accept_unlink+4):
   list_del_init(&bt_sk(sk)->accept_q);
   This line runs with lock_sock(sk) held. sk is a socket on
   bt_sk(parent)->accept_q.

Since the two lines hold separate locks, they may run concurrently, operating
on shared data (bt_sk(parent)->accept_q). This is a problem since
list_for_each_entry_safe is not thread-safe; the "_safe" suffix only refers to
safety against deletion of elements from the list being enumerated, in the
same thread.

For example:
Assume the there are two l2cap sockets, parent and sk. parent is being used in
a call to bt_accept_dequeue, and sk is being used in a call to
l2cap_sock_teardown_cb. Assume the following initial condition
(parent->accept_q contains a single element, sk):
  parent_accept_q.next = sk_accept_q
  sk_accept_q.prev = parent_accept_q
  sk_accept_q.next = parent_accept_q
  parent_accept_q.prev = sk_accept_q
Let "F: " denote list_for_each_entry_safe, "D: " denote list_del_init (macros
partially inlined), under the following interleaving list_for_each_entry_safe
would loop indefinitely over sk, at least until something in its loop body
causes a panic:
F: // Loop init
   s = list_first_entry(&bt_sk(parent)->accept_q, typeof(sock), accept_q)
     = sk
D: __list_del_entry(&bt_sk(sk)->accept_q);
   // parent_accept_q.prev = parent_accept_q;
   // parent_accept_q.next = parent_accept_q;
   // sk_accept_q.next = LIST_POISON1;
   // sk_accept_q.prev = LIST_POISON2;
D: INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
   // sk_accept_q.next = sk_accept_q;
   // sk_accept_q.prev = sk_accept_q;
F: // Loop init.
   n = list_next_entry(s, member)
     = sk
F: // Loop body runs.
F: // Loop condition.
   (&s->member != (&bt_sk(parent)->accept_q))
   = TRUE
F: // Loop next.
   s = n
     = sk
F: // Loop next.
   n = list_next_entry(n, member)
     = sk
F: // Loop body runs.
... loops indefinitely ...

While the above interleaving may seem unlikely, I did encountered this race
condition soon after attempting something similar to your patch (logging and
ignoring duplicate calls to bt_accept_unlink). bt_accept_dequeue looped
indefinitely over the unlinked sk, eventually causing a panic or freeze:
Session #1:
...
[ 3413.878132] Bluetooth: socket ffff880077798400 double unlink in state 9
... repeated 45 times ...
[ 3413.880784] Bluetooth: socket ffff880077798400 double unlink in state 9
[ 3413.881174] Bluetooth: socket ffff880077798400 double unlink in state 9
[ 3413.881513] Bluetooth: socket ffff880077798400 double unlink in state 9
[ 3413.881811] Bluetooth: socket ffff880077798400 double unlink in state 9
[ 3439.848799] BUG: soft lockup - CPU#1 stuck for 22s! [krfcommd:457]
...
[ 3439.849179] Call Trace:
[ 3439.849186]  [<ffffffff8164ed0f>] release_sock+0x1f/0x170
[ 3439.849202]  [<ffffffffc05d9e96>] bt_accept_dequeue+0xb6/0x180 [bluetooth]
[ 3439.849222]  [<ffffffffc060e9b5>] l2cap_sock_accept+0x125/0x220 [bluetooth]
[ 3439.849227]  [<ffffffff810a19f0>] ? wake_up_state+0x20/0x20
[ 3439.849232]  [<ffffffff8164982e>] kernel_accept+0x4e/0xa0
[ 3439.849239]  [<ffffffffc05537cd>] rfcomm_run+0x1ad/0x890 [rfcomm]
[ 3439.849245]  [<ffffffffc0553620>] ? rfcomm_process_rx+0x8a0/0x8a0 [rfcomm]
[ 3439.849249]  [<ffffffff810913f9>] kthread+0xc9/0xe0
[ 3439.849254]  [<ffffffff81091330>] ? kthread_create_on_node+0x1c0/0x1c0
[ 3439.849259]  [<ffffffff8176f918>] ret_from_fork+0x58/0x90
[ 3439.849263]  [<ffffffff81091330>] ? kthread_create_on_node+0x1c0/0x1c0
... repeated 12 times ...
(system freezes)

Session #2:
[ 3413.292556] Bluetooth: socket ffff880075ac1000 double unlink in state 9
[ 3558.346184] Bluetooth: socket ffff88006bcbd800 double unlink in state 9
[ 3560.013840] Bluetooth: socket ffff88006bcbc000 double unlink in state 9
[ 3560.882789] Bluetooth: socket ffff88006bcbac00 double unlink in state 9
[ 3627.800489] Bluetooth: socket ffff88006bd17400 double unlink in state 9
... repeated 25 times ...
[ 3627.801687] Bluetooth: socket ffff88006bd17400 double unlink in state 9
[ 3627.801754] general protection fault: 0000 [#1] SMP
(panics)
(My original fix attempt did not perform sock_hold(sk), thus sk was eventually
freed.)

This was the reason for my original patch to perform a conditional parent lock
in l2cap_sock_teardown_cb instead of fixing bt_accept_unlink.

Regards,
Yichen Zhao

PS: I agree that fixing parent locking in l2cap_sock_teardown_cb was not the
best solution; an ideal fix would live in bt_accept_unlink to avoid missing
any other current or future race conditions. However, simply performing a
parent lock in bt_accept_unlink would cause a deadlock, since its locking
order (sk, parent) would be the reverse of bt_accept_dequeue (parent, sk). I
did not figure out a good way to perform parent locking in bt_accept_unlink
without causing a deadlock.
