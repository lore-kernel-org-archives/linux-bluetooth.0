Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v2 0/1] Fixing EADDRINUSE in SCO sockets
Date: Mon, 16 Apr 2012 09:58:27 +0200
Message-Id: <1334563108-8526-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves the EADDRINUSE check in SCO sockets from bind() to
listen(), as described in the commit message.

Note that the address matching to detect collisions is very
conservative: BDADDR_ANY will match any other address. This seems to
make sense but differs from the original approach in bind().

This second version includes the review from Johan: the helper function
has been renamed and bool is used instead of int.

Another approach, as proposed by Luiz, would be to use a helper function
that, instead of returning a bool, returns the socket that is using the
matching address. This might be useful in the future, but I personally
don't think it is very likely.

The code could be as follows:

static struct sock *__sco_get_sock_by_addr(int state, bdaddr_t *ba)
{
	struct sock *sk = NULL, *sk1 = NULL;
	struct hlist_node *node;

	sk_for_each(sk, node, &sco_sk_list.head) {
		if (sk->sk_state != state)
			continue;

		/* Exact match. */
		if (!bacmp(&bt_sk(sk)->src, src))
			break;

		/* Closest match */
		if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
			sk1 = sk;

		/* Match any if given src is BDADDR_ANY */
		if (!bacmp(src, BDADDR_ANY))
			sk1 = sk;
	}

	return node ? sk : sk1;
}

This function would be quite similar from sco_get_sock_listen() with the
exception of the last BDADDR_ANY match, and the lock handling.

Cheers,
Mikel

Mikel Astiz (1):
  Bluetooth: Fix EADDRINUSE check in SCO sockets

 net/bluetooth/sco.c |   49 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 30 insertions(+), 19 deletions(-)

-- 
1.7.7.6

