Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743628;
	b=RNHKHP5uPjA5fPtx5bS1joXzva0eiq5zelrTOIagcuCkajyiVEgl57Zzr9vxyTem5LtL
	 0x1S1wAYzN6Bahgs0DXroPVfLH1uBLrilKt5svGJaGtfQUF5gzx6qPCeFGUGnxnv6PAI8
	 MJBy65iElawLzlJxWBh45EY9lTTDvqTZZRA+8D5qvL1Go+bsu2y9037dWh9Zh0iVMPg2n
	 fSMBCOg4nCbOJZSKUOMGp2w1EgIX/IKChhk+Gi01ctW1jtuO62aKUSHYYhDET7ScEmABx
	 kFvZ6FTDjVKZ7gKzUfG8AFRsDStxYsdezbUQYb1B6J+9953hjeUlDcuaqfNzB+vzsMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UWkGir4qU1HOXBM7UDVrmvnooNoUjfmfTGYPX9mWWvE=;
	b=shCYjiV2RcvLJNHF/ABkt0SPFwWr9qZDJvLuzCfT6n6mAd5JJ09klaOCNwbVBQfTrdSf
	 fUXFqXUqyZBgNM1PcFr6ik8+KNERXxfnLQtIV8ETbD3ElTjgoAPDXN2b+PSYM/8rZ+1Qf
	 76FWi1dEaRMAiLgBjKYTweRE42H48rGC6Jb+EdSWo+vxjFSMt2qsWC9eUsC8eHdzcLz8U
	 7jaPhWOam64gOQPV7qp+rzxgSeHicUe2Y92eard7op6TQdnko7JHJnvnEACHouOtWGr3R
	 Vp0qhFWSN4s32NdqbfTs+X+2qwEmX38m1RxXROR7cB+lyxHpYPJ/9MUSx/IaujvsnKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VO+dgxIU;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FD606A33E
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 11:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325FD606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VO+dgxIU
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso3029192c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 03:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794743627; x=1795348427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UWkGir4qU1HOXBM7UDVrmvnooNoUjfmfTGYPX9mWWvE=;
        b=VO+dgxIUum2TwF1DQuOZn5OCDMRCH0TY8ifUfWx6Sx67aY5+ZsAGrlVeNJ/ABdEtxo
         hxoi+e+LKb4AkMCq6G2J2L91YfDtq6WMOV3JwkI0FmCNRjVU+5XlP4diOamSZF6ZqaaM
         e2YVJ9dtw4mk7YvLFHClS/S7TiSCZT+D0nzmNKlTFIbtU7lNMF8EhEKH243Ys455w6xG
         156q0wYjd4A8X2O1Iu0nOLP0Cbsez65FyS8qftwRoDyt7gixJrCG91yKI2Sh8ZFWAdvM
         Q0MMaT1Q6ZVIVyqO6nYgzlwybHe+kL8RGypnhVv9h4CQhug8jobOwRAP9azSsk4PEg/9
         Iw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794743627; x=1795348427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWkGir4qU1HOXBM7UDVrmvnooNoUjfmfTGYPX9mWWvE=;
        b=Lb94vBnZoYDfnoH4bYmOwmOkh0Gmp2bXffD4hZCNsWy+NFCWIxUe84BDfb29rvaiB8
         fxKxN/RSi9FeMSvWViu80Iybfnq4WA2asqi4RTgOt9eiAow52Q8ToUmJdQHH+DeSz3xZ
         NULU2sV/8siXmf/7cR1WFl9P5PvckA3XD2ZCG9iYrOisuebvHrxJ1W+7gsXhvg63ELA5
         hGheFnQw4NjpuOaE4DBYFcnGJV1EueSyugdiyms34qeQ27bRRYZU4sF/EoDWF0UBeuAu
         RLsCJbqUDjexYrf1K3+3aDCp+uNbkdEV1550eP6SDNrvc6hIshH99iJzlceJo3clyl1d
         KviA==
X-Gm-Message-State: APuU4Z/GIhWPGJoH1e4R9Uod4jZPZrs2ZxznAUec1/I3il1Csqk5fjZO
	LDKCsBs5lCtPqb/vlcdPrKG3YM8exgDg4pJWIOabiPzmMRIXK1peR8Fp
X-Gm-Gg: AYBFou34Srq3KOxoPQRb4WbRUm7I2L/q+hml/B1yePY6SB0mFY13cuSO5N4nCMHH3zU
	wYyuXXA8MpysPMCcx3FcjU7uFkmjFfyDNyY7PYPbovIvP2UGQaaFlxeRXuBO7V0y39s3EY7d2ov
	tFRllMhk0VBcurFiYHjOW8QgspmRL++qwLVGfurwrqaHCDzr16H/4Gh5VGuRpAoT44p1OLhRylk
	mdPNz5e+mTYVNqBOEMNLp4Dmp4CNmk8iMb9B0NGtlNSnDb+caTIYiAQvFWipN7ykps0yLs3dWhG
	oHaFkIcfgz68xgBh4t7jA19Y0HQFBXcnRNgsHs20kU0j6o/gO+T/+Zi4fz3NELIYqU/2/NEcVXW
	WZP9H61KxayOr8LDiq325uptjYVn8yCy+y+dsZ28+4XYJIfkDYVvqrbJUGCgCu3r4k8TdD2BaW0
	wXh6X3zKe9m4bPOYvw0oD8H9sXfOCH/yuf7e+fXk0iGJ0AhygoA3/2pTxF+iXoQnLoSOovn9Jum
	0c/juNY0bAk4Y0n4qNAfO02tjoSECVcz/jDsjW7Hx4MV38CINoVEZF4/vmi1S+OxcETc9bWvaH9
	IpPE+PlTk0wdjeX62nY6jttuf8Qs
X-Received: by 2002:a05:701b:2083:10b0:145:287:ce91 with SMTP id a92af1059eb24-1b50314bef1mr8426787c88.14.1794743627152;
        Sun, 15 Nov 2026 03:53:47 -0800 (PST)
Received: from thangnn-ASUS.. ([2a09:bac5:d45c:e6::17:34a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031bc518sm21722845c88.15.2026.11.15.03.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 03:53:45 -0800 (PST)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stig Hornang <stig@hornang.me>,
	syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: L2CAP: don't reserve an ident for L2CAP_LE_CREDITS
Date: Sun, 15 Nov 2026 18:53:41 +0700
Message-ID: <20261115115341.316484-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan_le_send_credits() allocates an ident from conn->tx_ida, sends
L2CAP_LE_CREDITS and then frees the ident unconditionally, since the
command has no response.

But the ident is visible in tx_ida while the command is in flight, and
the remote may answer it with L2CAP_COMMAND_REJ anyway. The RX path then
releases it in l2cap_put_ident() under conn->lock, while the credits path
runs from recvmsg() with only the socket lock held. Whichever ida_free()
comes second hits:

  ida_free called for id=3 which is not allocated.
  WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594
  Call trace:
   ida_free+0x24c/0x2d4 lib/idr.c:594
   l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
   l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
   l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c
   l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317

Worse, if the ident is reallocated for a real request in between, the
credits path frees that request's ident instead.

tx_ida only exists to track requests awaiting a response, so a command
without one has no business in it. Give L2CAP_LE_CREDITS a plain cyclic
ident instead, which never needs releasing. The ident is still never 0
and never exhausts the range, which is what commit 6e1930ece855
("Bluetooth: L2CAP: fix tx ident leak for commands without a response")
set out to fix.

Fixes: 6e1930ece855 ("Bluetooth: L2CAP: fix tx ident leak for commands without a response")
Reported-by: syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9dc8780713b11155dd74
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU (x86_64, KASAN + lockdep) with the syzbot C reproducer,
15 runs per kernel:
  base (origin/master 23c62304dde2): 31x "ida_free called for id=N ..."
  patched:                           0 warnings, 1200 LE credits sent,
                                     none with ident 0 (ident wraps fine)

 net/bluetooth/l2cap_core.c | 44 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7dcb0586a10b..0b861ced5703 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1028,21 +1028,36 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 				 initiator);
 }
 
-static int l2cap_get_ident(struct l2cap_conn *conn)
+static u8 l2cap_ident_max(struct l2cap_conn *conn)
 {
-	u8 max;
-	int ident;
-
 	/* LE link does not support tools like l2ping so use the full range */
 	if (conn->hcon->type == LE_LINK)
-		max = 255;
+		return 255;
+
 	/* Get next available identificator.
 	 *    1 - 128 are used by kernel.
 	 *  129 - 199 are reserved.
 	 *  200 - 254 are used by utilities like l2ping, etc.
 	 */
-	else
-		max = 128;
+	return 128;
+}
+
+/* Ident for a command that has no response: it is not reserved in tx_ida,
+ * so nothing has to release it and it can't be released twice.
+ */
+static u8 l2cap_next_ident(struct l2cap_conn *conn)
+{
+	u8 ident = READ_ONCE(conn->tx_ident) % l2cap_ident_max(conn) + 1;
+
+	WRITE_ONCE(conn->tx_ident, ident);
+
+	return ident;
+}
+
+static int l2cap_get_ident(struct l2cap_conn *conn)
+{
+	u8 max = l2cap_ident_max(conn);
+	int ident;
 
 	/* Allocate ident using min as last used + 1 (cyclic) */
 	ident = ida_alloc_range(&conn->tx_ida, READ_ONCE(conn->tx_ident) + 1,
@@ -7081,7 +7096,6 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_credits pkt;
 	u16 return_credits = l2cap_le_rx_credits(chan);
-	int ident;
 
 	if (chan->mode != L2CAP_MODE_LE_FLOWCTL &&
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
@@ -7099,18 +7113,8 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	pkt.cid     = cpu_to_le16(chan->scid);
 	pkt.credits = cpu_to_le16(return_credits);
 
-	ident = l2cap_get_ident(conn);
-
-	l2cap_send_cmd(conn, ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
-
-	/* L2CAP_LE_CREDITS has no response so the ident is never released by
-	 * l2cap_put_ident() - release it right away, otherwise the tx_ida
-	 * range is exhausted after 254 packets and from then on credits are
-	 * sent with the invalid ident 0, which some remote stacks ignore,
-	 * stalling the channel.
-	 */
-	if (ident > 0)
-		ida_free(&conn->tx_ida, ident);
+	l2cap_send_cmd(conn, l2cap_next_ident(conn), L2CAP_LE_CREDITS,
+		       sizeof(pkt), &pkt);
 }
 
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
-- 
2.43.0

