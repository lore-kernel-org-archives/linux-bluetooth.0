Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8D2D5940;
	Wed,  1 Jul 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920819; cv=pass; b=VI/oznI2jSf+8mnxjPeFFR2Nthri1NgnuRX4aTrN/vqVcowRjQJO7/CVZlOVNMNtMrxeikBlKhYF+1vcl30XdK0hj3qdUvybjXKfWSU1uUGKTpudREYaHNui/6tqOMQT6D84kKgVSXbPMXTBev8ouXg+OAu5umDrC3sKA2fwoQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920819; c=relaxed/simple;
	bh=TJ5tE0vSlj45M9dEKmCz0DymCehhYxYhl8MFDr/T3Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwolEjilqyvDlgy3E/yaEGAWK1vemTf7I+C0y6ihVC5RKZEgXbbjB1kEMXCozDkWh3zfXekqdwSQS3fFqfPKbzYxeLSDoTBcY4Ucf9fPlc0ANqXlAJNbzidQb+NVgs2KSKIbL/EvWhRQi/iD1ItrEriaJgm1Cwn83StSEpeAH80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HSf2Zl2j; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HSf2Zl2j"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gr4Bb3pk6zyQt;
	Wed, 01 Jul 2026 18:46:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782920808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EbC8XfBRTVGSnr6/urzKgaF2h9N+46AS4EdMNL6KXVk=;
	b=HSf2Zl2jjrjpjehd1GLk7DbJUB/HsRa3BnOVABkkC6aAl+JCVUaz+peB01D5oGhCUO4wVh
	JYj9anBiign/nAjUQhAa2jTiM7NBHkn7BOCo/Hp7ajCPyf/Z4PI5beqNUEH6xc+3NRigZA
	5ORlg5yuPP2JMvSm1a5+k//GWNMtsQE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782920808;
	b=o2+M6UDEI+xsx7DLFL5IM908jOqeJBE9ctTOx1JeOKyQ0i4V+MvKSW2fslWoUEyw0Zc1pr
	s0/0zgmZ0nSSgSu2r5IAMjW2FzjvNQ3QiPEHgkeI1zNrUxMvK0B8FpXa57Mz9g/xvYtMqJ
	g70e1mEADIkaUWNm0CsCzaeOctcQKtE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782920808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EbC8XfBRTVGSnr6/urzKgaF2h9N+46AS4EdMNL6KXVk=;
	b=OXK3CxnH+xByryDNlbmYIXOq00b+ueoLfh0wnagrNjftv/q+3GBaUD/e/h0+aE8nrMF6ag
	mrKNgcBUPshVEubc5XFAv7JIeqWnDF4DorZefje1TCPUQliGwroNtbo4myOF35QNnNXh22
	si5U9HegHNU0wh6nUKjBG3BHrLVoOYY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	devnexen@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: ISO: fix malformed ISO_END/CONT handling
Date: Wed,  1 Jul 2026 18:46:38 +0300
Message-ID: <da68c9b8242e9fbf482b1512e9d612768f2cc7e8.1782920668.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core specification (Part C vol 4 sec 5.4.5) does not exclude empty
ISO_CONT, ISO_END packets.  We currently reject them if they are last.

If controller sends malformed sequence

    ISO_START -> rx_len = 4, ISO_CONT skb->len 4, ISO_START

that ends payload in ISO_CONT, we leak conn->rx_skb. If controller sends
too long ISO_END, we panic on skb_put. If controller sends too short
ISO_END we accept it.

Fix by marking unfinished ISO_START via conn->rx_skb != NULL.  Check
skb->len properly before skb_put.  Combine the ISO_CONT/END code paths
as they require the same initial checks. Reject too short ISO_END
packets.

Fixes: 6aba94a49bc9 ("Bluetooth: ISO: drop ISO_END frames received without prior ISO_START")
Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cd7c7c9ea4fc..2e95a153912c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2540,7 +2540,7 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 	switch (pb) {
 	case ISO_START:
 	case ISO_SINGLE:
-		if (conn->rx_len) {
+		if (conn->rx_skb || conn->rx_len) {
 			BT_ERR("Unexpected start frame (len %d)", skb->len);
 			kfree_skb(conn->rx_skb);
 			conn->rx_skb = NULL;
@@ -2621,12 +2621,14 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_CONT:
-		BT_DBG("Cont: frag len %d (expecting %d)", skb->len,
+	case ISO_END:
+		BT_DBG("%s: frag len %d (expecting %d)",
+		       (pb == ISO_END) ? "End" : "Cont", skb->len,
 		       conn->rx_len);
 
-		if (!conn->rx_len) {
-			BT_ERR("Unexpected continuation frame (len %d)",
-			       skb->len);
+		if (!conn->rx_skb) {
+			BT_ERR("Unexpected ISO %s frame (len %d)",
+			       (pb == ISO_END) ? "End" : "Cont", skb->len);
 			goto drop;
 		}
 
@@ -2642,17 +2644,9 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-		break;
 
-	case ISO_END:
-		if (!conn->rx_len) {
-			BT_ERR("Unexpected end frame (len %d)", skb->len);
-			goto drop;
-		}
-
-		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
-					  skb->len);
-		conn->rx_len -= skb->len;
+		if (pb == ISO_CONT)
+			break;
 
 		if (!conn->rx_len) {
 			struct sk_buff *rx_skb = conn->rx_skb;
@@ -2663,6 +2657,13 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 			 */
 			conn->rx_skb = NULL;
 			iso_recv_frame(conn, rx_skb);
+		} else {
+			BT_ERR("ISO fragment incomplete (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
 		}
 		break;
 	}
-- 
2.54.0

