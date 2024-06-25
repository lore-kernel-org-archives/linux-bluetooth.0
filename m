Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D679146A67;
	Tue, 25 Jun 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310830; cv=none; b=iK0Xx6xEbN0qpHo9vYJJ5uakhMtxeqgSQR8GJdqhtgutbkWmXA1dq/b5XyNyMNrwPNtdF43fMkH4lxrM1fUUihS4vA8J2KhfRuzP5qWtU2QSBzL/yq49RSRXxiebgSdY7LqHd7fjAwJJH71cI0rDXBpAjo7jV+GcCPNuNl+XRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310830; c=relaxed/simple;
	bh=mrkCbUN4T0q6BoY0m/gooEG5R4amkIb+uH8GJY8h6fQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SpXBliQ/569xYTkUqs2RNrCVb/xbffFlqCZrx/FHcXQqYMCAWw9LWpGQy/KHXzwR+rUMnJgE35z5cdLRS+XwJg/KjvSAcmTz9rq9DeHRO9r8ufuCZcUFwhoA8zwW9ji8cuztMKjndGCzXxjQCwE1VKcEqVmirgoHQn1G5ucpV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zqNYzLUW; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zqNYzLUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719310519; bh=NZOSPeiPAVveuWbrnAInxDlcsoHJ6JgaucOMtYnKhwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zqNYzLUWj88NKtIKPLkX0Nn3dCD1RObpt623bS4HnUgR+lLG5anw3fBbcglABS6RB
	 9g/a4rBlf1vLpg/D/Z+t5G3uib2jIe7po55uHgfOoKqt0Xv+feLvPXvuA9+GWinG3Q
	 zGzy3G4KhLGUXK1f1JO6+aT4/qNYm7Rxr/Lo7jZQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 30EA185C; Tue, 25 Jun 2024 18:12:14 +0800
X-QQ-mid: xmsmtpt1719310334tv296kjyp
Message-ID: <tencent_CFD37DA36B4965E3A7C45E7770776C86DB05@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWf8BIMzYOceNsyYxmg35httaPj3YYnwhHxtvnQssNEIax9AzBl3i
	 43lZ3m5xTxQQ20u2+uvs+jEHKbqQrtTGvEob8aycLQrF+xKJPSq1nCEkNzD9rqxIMujpEBm5/Zb3
	 SWi0kiBnC5mTGjrp+Q3GvMCX7eZ/IhmO1kOk/P8zu9bgjcnTFDczGiEzQjht2pdOPjqralUE+N0B
	 dZ4ho/u3iylVHlMxoF6Uvq8QU/DxnPBnVOeJ6onPpzkW1TJj3J3IE0/0tPOuWxvgNiztavUH2FiS
	 fMGeIYVz7upsm86hgDDNapcQn3RR85ipvBUTsDvd+JyyFQzj9qP8MJkMBwjJoRwDIEpV1s7oldiL
	 c4TEeuGjrm/8BUrk7mm2zkR4hYpPPibvAgP0aW02NnNjxgzoeQwHOUZNdBcPQiZ/knxlxacljlcj
	 eVwUx4NAjgj86d6r74lEQLECHkCFYMzHFr+jQ1SPmc4KdYHa+SMHAyCmU7hUOTFHxwfRdEgE2JVq
	 P31DCe+BePQUW6yu4l9jpl6DyRwg5P2iMANnSjok34w84l/RaLp/Ee4yYpc3QCVgjmfkEfuIR5M5
	 V5BEofSxgDplfEWQuQ9nRIHcjoDt/0gOliRBE0842Ki9lMfIpQrFg9Jvr4gkPPyXvpDHNFKw4XtP
	 NNX9lyL3FMHG7079UCdFGA44DlnBIzWuXKjKnyh4jMAJDvYXOSUMSpWmleo27WmrUH0zuY5RM/aO
	 BDcR0K8SIypwhhd5ay63y9ROqqirTongh2qPjrd8Tmimwj4OoPvHT1m7ozSxb2YAdctSw/TDSeOZ
	 p+rhIAQvCJExBW0OdRdJHoaTAVJtKU531rkNrxS/u57hZpPgI0zqXWYPnGBJM1JaDXt7xFKeaHyb
	 1jGZUho3+1VtMtfvhqeSHvfaqaAEduT/UGIqYTly1rVyLFZK2Mryqlin76NylQVpg7GzNbRaVovQ
	 22LGyacIq4hDQ4fslQdw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: luiz.dentz@gmail.com
Cc: eadavis@qq.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V3] Bluetooth/l2cap: sync sock recv cb and release
Date: Tue, 25 Jun 2024 18:12:15 +0800
X-OQ-MSGID: <20240625101214.598651-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZL5xiNDzDa3JJiwx2D-qpmA8Y3RBVWLetZ0fd4jURpN7g@mail.gmail.com>
References: <CABBYNZL5xiNDzDa3JJiwx2D-qpmA8Y3RBVWLetZ0fd4jURpN7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The problem occurs between the system call to close the sock and hci_rx_work,
where the former releases the sock and the latter accesses it without lock protection.

           CPU0                       CPU1
           ----                       ----
           sock_close                 hci_rx_work
	   l2cap_sock_release         hci_acldata_packet
	   l2cap_sock_kill            l2cap_recv_frame
	   sk_free                    l2cap_conless_channel
	                              l2cap_sock_recv_cb

If hci_rx_work processes the data that needs to be received before the sock is
closed, then everything is normal; Otherwise, the work thread may access the
released sock when receiving data.

Add a chan lock in the l2cap_conless_channel of the sock to achieve sync
between the sock release and recv cb.

Sock is dead, so set chan data to NULL, avoid others use invalid sock pointer.

Reported-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/l2cap_core.c |  3 +++
 net/bluetooth/l2cap_sock.c | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aed025734d04..35a9534eb62d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6771,10 +6771,13 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	bacpy(&bt_cb(skb)->l2cap.bdaddr, &hcon->dst);
 	bt_cb(skb)->l2cap.psm = psm;
 
+	l2cap_chan_lock(chan);
 	if (!chan->ops->recv(chan, skb)) {
+		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
 	}
+	l2cap_chan_unlock(chan);
 
 drop:
 	l2cap_chan_put(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6db60946c627..25091fb992a7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1239,6 +1239,10 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
+	 * sock pointer.
+	 */
+	l2cap_pi(sk)->chan->data = NULL;
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1481,11 +1485,16 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
+	if (!chan->data)
+		return -ENXIO;
+
+	sk = chan->data;
 	lock_sock(sk);
+	pi = l2cap_pi(sk);
 
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
-- 
2.43.0

