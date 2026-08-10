Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E363612E0;
	Mon, 10 Aug 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348694; cv=none; b=qxhhYZHlWYRGkdOV6/jLdr7CxA/zCTLBDMveZPrRgONMSuOPGG13wEzPZ25YM9LfehmHe/T0iCymEEWgFabxP3ZoRpXqdjM8UyTJ+hCgOCSEjvqDKvuOK+M+Osj7oR2xQMUE82Tu5yKnd1omnAJ+IQXY+tAfQX3qy5dt0sDo7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348694; c=relaxed/simple;
	bh=wN68hQ+j7ntl5D+ryPK1a0DL4TF7vbmS/caeqOekrhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GpFWnsCH+HSr+6xaZTjkxosTDR4bvlfaCAR1hN2VD401eTnOx9EVWwtOnNH1+0pAvELjG3i6rSvEGAnatM9jZvOe8+Ien+jn4zOiU7JZiOkFfftU15CzqoWA5JTS2wgzj4iF0Kvb7uuEtlnwmJb6R8xMeJdLA+Oylna53izuNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K3RFTFSG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K3RFTFSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zR
	saLpDdX/5XhWmg/j05YH+UAfVnDSIOHICZS5FX3k4=; b=K3RFTFSGHn/o8DFWW/
	r2eaZXWpjpf7BHn//gAKGmVfOSSKt3Xkn/FIXCE1073J03SAi9l3Qo11eZrN3H3S
	D+8btJ6unRYqcobBsCeYuEp03lezMG0y7uT5yCdDjkMtqQBLl/EuBoZk7WsaXnvJ
	PXuJAQChibAf6BRo0V4TH7yT0=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3X0t5hHlqVG5nAw--.47784S2;
	Mon, 10 Aug 2026 15:57:46 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Tim Bird <tim.bird@sony.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH v4] Bluetooth: HIDP: add missing length check for incoming frames
Date: Mon, 10 Aug 2026 15:57:37 +0800
Message-Id: <20260810075740.33419-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X0t5hHlqVG5nAw--.47784S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF48Cw1xtr17Xw1xuFWxWFg_yoW5Gw4DpF
	17WrWv9r48GF1Iy393Jaykury3t3WkG34fKrZ7twn5Xry3AF15JFs7AFyjva1qqrZ5Za4a
	9FW8Xa9rWwsYqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimsU_UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRo4cmp5hHpMJwAA3b

In hidp_recv_ctrl_frame() and hidp_recv_intr_frame(), skb->data[0] is
read without verifying that skb->len >= 1.  A zero-length L2CAP PDU
delivered via the HIDP control or interrupt channel causes an
out-of-bounds read.

Use skb_pull_data(skb, 1) which combines the length check and pull
in one operation, matching the existing pattern in hidp_input_report()
and the fix in commit 6770d3a8acdf ("Bluetooth: bnep: reject short
frames before parsing") which addressed the same class of bug in BNEP.

Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---

Notes:
    v3 -> v4: Free skb when skb_pull_data() rejects a short frame.

 net/bluetooth/hidp/core.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0e24c5e2955e..e29fe66f01d4 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -560,16 +560,18 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 static void hidp_recv_ctrl_frame(struct hidp_session *session,
 					struct sk_buff *skb)
 {
-	unsigned char hdr, type, param;
+	unsigned char *hdr;
+	unsigned char type, param;
 	int free_skb = 1;
 
 	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto failed;
 
-	type = hdr & HIDP_HEADER_TRANS_MASK;
-	param = hdr & HIDP_HEADER_PARAM_MASK;
+	type = *hdr & HIDP_HEADER_TRANS_MASK;
+	param = *hdr & HIDP_HEADER_PARAM_MASK;
 
 	switch (type) {
 	case HIDP_TRANS_HANDSHAKE:
@@ -590,6 +592,7 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 		break;
 	}
 
+failed:
 	if (free_skb)
 		kfree_skb(skb);
 }
@@ -597,14 +600,15 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 static void hidp_recv_intr_frame(struct hidp_session *session,
 				struct sk_buff *skb)
 {
-	unsigned char hdr;
+	unsigned char *hdr;
 
 	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto failed;
 
-	if (hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
+	if (*hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		hidp_set_timer(session);
 
 		if (session->input)
@@ -616,9 +620,10 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 			BT_DBG("report len %d", skb->len);
 		}
 	} else {
-		BT_DBG("Unsupported protocol header 0x%02x", hdr);
+		BT_DBG("Unsupported protocol header 0x%02x", *hdr);
 	}
 
+failed:
 	kfree_skb(skb);
 }
 
-- 
2.34.1

