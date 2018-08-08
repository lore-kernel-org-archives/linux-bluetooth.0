Return-Path: <khlebnikov@yandex-team.ru>
To: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [BUG] sleep in atomic in bt/rfcomm
Message-ID: <4fed5a55-29d2-0b02-edd9-186765968ac9@yandex-team.ru>
Date: Wed, 8 Aug 2018 12:35:18 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

[906107.213068] BUG: sleeping function called from invalid context at net/core/sock.c:2764
[906107.213073] in_atomic(): 1, irqs_disabled(): 0, pid: 2032, name: krfcommd
[906107.213077] CPU: 3 PID: 2032 Comm: krfcommd Tainted: G        W       4.14.52-17 #1
[906107.213078] Hardware name: LENOVO 20FCS1DW00/20FCS1DW00, BIOS N1FET43W (1.17 ) 08/02/2016
[906107.213078] Call Trace:
[906107.213088]  dump_stack+0x5c/0x7e
[906107.213093]  ___might_sleep+0xec/0x110
[906107.213097]  lock_sock_nested+0x1c/0x70
[906107.213114]  bt_accept_enqueue+0x29/0x90 [bluetooth]
[906107.213122]  rfcomm_connect_ind+0x23e/0x2b4 [rfcomm]
[906107.213127]  rfcomm_run+0x149b/0x18d0 [rfcomm]
[906107.213131]  ? do_wait_intr_irq+0x90/0x90
[906107.213134]  kthread+0x10a/0x140
[906107.213138]  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
[906107.213142]  ? kthread_create_on_node+0x40/0x40
[906107.213145]  ? SyS_exit+0x13/0x20
[906107.213149]  ret_from_fork+0x35/0x40

rfcomm_connect_ind() under bh-safe bh_lock_sock(parent) allocates new socket and
calls bt_accept_enqueue(parent, sk) for it which calls sleeping lock_sock(sk)

whole bt_accept_enqueue() looks highly dubious

void bt_accept_enqueue(struct sock *parent, struct sock *sk)
{
	BT_DBG("parent %p, sk %p", parent, sk);

	sock_hold(sk);
	lock_sock(sk);
	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
	bt_sk(sk)->parent = parent;
	release_sock(sk);
	parent->sk_ack_backlog++;
}
