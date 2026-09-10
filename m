Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80566566C6E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063942; cv=none; b=bXs31P+PQgqVQcSuxXwWyXuaDDG3GIoeJb2c/4Dt2rijp/SEMoAhTp+ru0kFEiQvWG9rtz2ibBMVCGNRxzDIK/ahD5rlQnbQ4Q16rnEhKPL+mL5IB5K4Vw2+a6sin/0sJQbgJ6q82ydl43O0dBVVQCndS6uldYubJtS414ffLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063942; c=relaxed/simple;
	bh=qx9Mw3PfK7rlDh7xIFZIJoUOcH+1GvfH2UmDTXwqKU0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srFQs9wjBSxtWKh9HjqNBzEuDtkuABteuVwvic50WqwDhKT84t9fgczf/hmHK56arFEYAm41Ry5inVeeO7E7N2yTo74wWHZycnvw/dtnLxLoUaG72IgtJGidnTm3vrqfYrJ3xTOoJ3Pe4poH7Y7LMiPIOFW3z9DvM7v5RsfEduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGlEFhK+; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGlEFhK+"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c80b099b4eso83638e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789063939; x=1789668739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aYkMg5h+F2dk1Rzb/72AToD9q6b8Rg1WoxsWh4jxdSQ=;
        b=JGlEFhK+TG02phUvaa7xtqEOs7UPn0JqnxyRkqyRN5xGc4d+n+3Lz3rlgxn7+2S/zW
         s8P2AlUj//djeVSNk0mHIHDEWo0fPx+BCEsBFMaCX7q6e7gq+L85NLo7ZDyqpUrhcjA9
         IKfD7k0MrGKJJw3oWHcPjH2b15dkbeKZpJ4fY3TUiDWs0BpQsPs5JJo4a0Mg5u8koRzP
         wqT+D4AutJAgO68gjrnwFxwOvPtk3DF2hY7vnlMw6T9/6kKz3gUIxx3Q794GOw77dcA3
         4Afa7nWNmn1bR50Bjphacdlsi/BW6EJ1sNeF9fgay9bV7h5HVSPgN/+J+RbxL19VVZH4
         tzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063939; x=1789668739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aYkMg5h+F2dk1Rzb/72AToD9q6b8Rg1WoxsWh4jxdSQ=;
        b=LO6uVigxzCN2f6rt3zKk82K6yaNWGUqNaXPgse9eys3g4SM+tP0puo5Vr0fWZxnsW1
         8VFmce68JOX80t89tZFvisfq4/UXVXM5Ga2wMAfstTHb8a23XY3TAefdxL9nLqOxRXO/
         MKrKHdKQnaxlrY2o88OikIopghTDPB9ib1vk3Wj8g3JZK0dsceOpRCzb5hQheE1ULu06
         CtheIyl4QyuOpNwhGhKgy0p/HIm+kM2eOfdzM7LXLDM4O9mtqSHPPlF8fE/4cLO021Pg
         VqMd6lBlerH0Be8W96CqUhuqlBL3Hpc61Jj89R6yliaB6KoteU9PyLu/vqZAgkT5Vq5n
         8E/A==
X-Gm-Message-State: AFuF++kxo//cDhWnSU8JJTUPx4oqWhrFctwMOEGmyA+/3vF7ZceOozCY
	4f7eOG/MVPvsQ8uFSXwz8cICFv8pNOhWlFoYn5CsOIFvCBdc5Dsa9tF4nXarcyLR
X-Gm-Gg: AYBFou22DGxhkQfwVQg2vL96KZzPnOHFZ02Nz35qGCFAqIYeUK5W34niboG8AYk+4xH
	EGPb9AC/BvRYqUcn4GIxZ1P48SWPCpzQ8Ik1BkUpda1gluSp3YnSEFwl0S+qo509/wOUx/a+ql4
	Wb7q81L4W5dPmCJq4S5CDDBOmINkX+AbQlDzeCcwsFjH8XlU/kA0hQJCyvbZWnERTqdJGf3EWBL
	d3aHbBzR2b1z0D/S77t7HazQVSsjiyGSlGiUDEC8xPHhsaOMv0ogPOqhBGe1ouwxuqpQ/aoogZ5
	sy6sagXblEk9OrYBIqgnH5jOwPptvqqSgDT8Y5fEA5LGVqbb1YIt6ByvNGsApNwp6FWPl6bXn2/
	nXQnbZYK55JQsgpBPhFAbrAxSmfgYTDMfKWFFIt6Xa1FzjYKf/LeqbxUoogp8FFyFL0Q3Mar+Jc
	yxzK4Cq5O2s/wS1+RwKwJm3KryjrK0nUxvMXPUATf1l6+6tn0aq7DoNpUZn6Z3Ms1/RLL3aBhEY
	UzwwvD6ZF2vM97Yne2a/BJarYSOe4gzhHNMtZx1BAgkrqf5nmrpTq+Qscj/ypFCXQ==
X-Received: by 2002:a05:6122:1827:b0:5c8:228:5ea6 with SMTP id 71dfb90a1353d-5c8462b3115mr1169999e0c.5.1789063939119;
        Thu, 10 Sep 2026 11:12:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84714c380sm120262e0c.15.2026.09.10.11.12.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:12:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync
Date: Thu, 10 Sep 2026 14:12:06 -0400
Message-ID: <20260910181206.1558734-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910181206.1558734-1-luiz.dentz@gmail.com>
References: <20260910181206.1558734-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A BIS connection is matched to its parent socket by looking for a
socket in BT_LISTEN state with the same BIG handle:

  iso_conn_ready()
    if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags))
            parent = iso_get_sock(hdev, &hcon->src, &hcon->dst,
                                  BT_LISTEN, iso_match_big_hcon, hcon);

The socket was only moved to BT_LISTEN after iso_conn_big_sync()
returned, while the LE BIG Create Sync command has already been queued
by then. If the BIG sync is established before the state is updated,
which is easy to hit with an emulated controller as the command may
complete in a few hundred microseconds, no parent is found and the BIS
connections are never notified to the listening socket.

The user space is then left waiting for connections that never arrive,
e.g. bluetoothd never completes a MediaTransport1.Acquire of a
Broadcast Sink transport.

Move the socket to BT_LISTEN before requesting the BIG sync, so the
state is visible by the time the command is queued, and restore the
previous state if the request could not be started. Since the socket is
briefly visible as a listening socket, child sockets may have been
queued in the meantime, so drain the accept queue before restoring the
state: the cleanup paths of BT_CONNECT2/BT_CONNECTED don't do it and the
children would be left with a dangling parent pointer.

Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 52 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 4de332b8901f..eb99653f33f9 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -819,19 +819,24 @@ static void iso_sock_destruct(struct sock *sk)
 	skb_queue_purge(&sk->sk_error_queue);
 }
 
-static void iso_sock_cleanup_listen(struct sock *parent)
+/* Close not yet accepted channels */
+static void iso_sock_flush_accept_q(struct sock *parent)
 {
 	struct sock *sk;
 
-	BT_DBG("parent %p", parent);
-
-	/* Close not yet accepted channels */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		iso_sock_close(sk);
 		iso_sock_kill(sk);
 		/* Drop the reference handed back by bt_accept_dequeue(). */
 		sock_put(sk);
 	}
+}
+
+static void iso_sock_cleanup_listen(struct sock *parent)
+{
+	BT_DBG("parent %p", parent);
+
+	iso_sock_flush_accept_q(parent);
 
 	/* If listening socket has a hcon, properly disconnect it */
 	if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon) {
@@ -1737,6 +1742,13 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
 			if (test_bit(BT_SK_PA_SYNC, &pi->flags)) {
+				/* Move to BT_LISTEN before requesting the BIG
+				 * sync: the BIS connections are matched to a
+				 * parent socket in BT_LISTEN state, and they
+				 * may be notified before the request returns.
+				 */
+				sk->sk_state = BT_LISTEN;
+
 				release_sock(sk);
 				err = iso_conn_big_sync(sk);
 				lock_sock(sk);
@@ -1745,12 +1757,20 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 				 * connection may have been torn down
 				 * meanwhile and iso_chan_del() may have
 				 * already moved the socket to BT_CLOSED.
-				 * Only move on to BT_LISTEN if the BIG sync
-				 * was actually started and nothing else has
-				 * changed the state.
+				 * Only move back if the BIG sync could not be
+				 * started and nothing else has changed the
+				 * state.
 				 */
-				if (!err && sk->sk_state == BT_CONNECT2)
-					sk->sk_state = BT_LISTEN;
+				if (err && sk->sk_state == BT_LISTEN) {
+					/* Discard any child socket that may
+					 * have been queued while the socket
+					 * was in BT_LISTEN, as the cleanup of
+					 * BT_CONNECT2 doesn't drain the
+					 * accept queue.
+					 */
+					iso_sock_flush_accept_q(sk);
+					sk->sk_state = BT_CONNECT2;
+				}
 			} else {
 				iso_conn_defer_accept(pi->conn->hcon);
 				sk->sk_state = BT_CONFIG;
@@ -1760,12 +1780,22 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			break;
 		case BT_CONNECTED:
 			if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+				/* As above, the BIS connections may be
+				 * notified before the request returns.
+				 */
+				sk->sk_state = BT_LISTEN;
+
 				release_sock(sk);
 				err = iso_conn_big_sync(sk);
 				lock_sock(sk);
 
-				if (!err && sk->sk_state == BT_CONNECTED)
-					sk->sk_state = BT_LISTEN;
+				if (err && sk->sk_state == BT_LISTEN) {
+					/* As above, don't leave any child
+					 * socket behind in the accept queue.
+					 */
+					iso_sock_flush_accept_q(sk);
+					sk->sk_state = BT_CONNECTED;
+				}
 				early_ret = true;
 			}
 
-- 
2.55.0

