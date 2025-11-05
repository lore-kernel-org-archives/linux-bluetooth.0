Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF926E6F9
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362301; cv=none; b=oGVVT8RzHYX8ZdB7Icz0VfUsCYSQA/8HFTYuF/Jt4/qY/RaUu31KvosmpBfN4CSMg42NXVlmeAKhRJLjEUfKXkUJTdd0yXL2hUrs9IZPJfTF2hss4i1B9ttAIxMQUs/dRUFymrIMaTUjYlCQElfj/Ps38TkXXybIC84YzuEEViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362301; c=relaxed/simple;
	bh=XcDxqy/aUizJE8+F80+Mv/sbwrS7SoctvwqJfQW5ZG4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=omLGhLuUXMFi08FShD65sD93rxzEWE8jyUA2QZ6mdnkT4dLwDTZzt+URbYKjTBCF3xK+tkoTHVUULwY925bCf1/t+F8NcDJP61HKrYYv8SXNB7b1sOOCvThkMbcrTln/Qh+e56lwDf59zsEuSE0a/WR+4z9Q14mH4upkwpZTItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ylmm19TW; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ylmm19TW"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d967b66fedso45576137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362297; x=1762967097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5HEXz/78/pF7P02q0MUtF0ORCdWmIG1OsosHfrjQBI=;
        b=Ylmm19TWmzQ9DBrs1CTNhNtCxgWW05JM1xMEupM7RfeLBKJn/gQMmGJUR1BpCVPo8z
         cwjjiuhE7a14/wbbkV3WGHafnEtS7etoeXrCKr64KsceXwM/W7C3xGwMVy0Yh+L64tM9
         aIkg0456QEmAjimgj9DgNs0IjL4FqHJXH/rvLlWrFzF/2nJrvvdoWFhzofbkEmeXJm30
         7Zp/PSg/tmHJAv1qbLTcUJeJOp5kpjYV75RVYpCbeztJG8iFp05QQHkxOktRH+Cw+B7O
         QWL9eqFvF0Sh6cVJAIEex+ARIKyU0ZuLvIJdG7Hauy/xATwbzW1Xx8jERAPTzwxgnOK+
         m78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362297; x=1762967097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5HEXz/78/pF7P02q0MUtF0ORCdWmIG1OsosHfrjQBI=;
        b=a1aa63HXbbDVKhHTyMb7gO6djnPNv5uhIjEEc3aW65KJnlgjb9H/LDGc8TH/+xiBEa
         9IUPQvI9Rz+FI2SEFLKcvAZMs1vO600QsRLzXrmwAbttZArocMRY4wPP71hsYEvka6yG
         f16K5i/uyLh6nmJDcEkjkHwlB0GrNFbz2Gq3M4uAu5JqXvKaRb5MK7tycp4prSxJLGJo
         FX4KgO3Vhh/+wuOrRv2/oHzc69ga+oR1Ch2tRJ4HjlDhP1hbCbUi6fkc4GogDT4hDKOM
         XJhH1FsZ77QgogAsabnq9CPeb1ZJhfV5owIDwV6FvOFnQX8rirFIFPmhiVJcJzgC0E33
         R7Sg==
X-Gm-Message-State: AOJu0YzNecXGHZ18h7s1Y/3h6iffM9nJ13LZ7LuNZQRSR52yxXw1Vv2a
	PVsWDSivLSG6/c1MqnX/Kmh4oW1P6v/KJQMRejuyWBFdRBG/5vndSzWhk4Aee2LxJp4=
X-Gm-Gg: ASbGnculS0EapXdNBsOeMbxfdoqt0gfwe/LyFbr8mcDsDDd6o1psFY7v0nIjCJmcBZu
	uMOEmn+RiFKk8HWoyCMGb7qrVdSmeve4DHrlpgOpDVrCJmtYTM35Q/425O74ZwTgtECQ5PKZw5Q
	mIhjmfOWnA7DzrqXd4CDW7Jmby8kQvwrTT6IJL05i3s/68cv0d8BQ5SKcJLPWfvfWrmd17IZZSz
	J7vJ3cVpUL+C0meXFvwZ5xDRfUs5YukWXfPUmCGNew0/SuLq5s95zTYjHdN7kZ5UTOhWYppKDoJ
	B77SjvcBZW0bf4ebGFJdx+Kcu+4wrkk6NEKoWOUH2sdFfzz3n58M1giJDJSgB/VOvnfcgjWWwxX
	A4JN3qAYwQPlqMJqSUuR9vrm5/4TKLX9Q1tNajS+sKG4U2yow073R6zB8sz04OzGeQiYQ54stDr
	PeGck=
X-Google-Smtp-Source: AGHT+IGJFvuh/JlZezY1SMxySc0nZOaXNl3MppS7U7p7npe3G6cudbtnUq08TkWZQavQKCQC4roWvg==
X-Received: by 2002:a05:6102:d91:b0:5db:edd7:ffc with SMTP id ada2fe7eead31-5dd893043d7mr1305314137.30.1762362297328;
        Wed, 05 Nov 2025 09:04:57 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dd9f665523sm100099137.6.2025.11.05.09.04.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:04:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: hci_uart: Refactor h4_recv_buf code into h4_recv_skb
Date: Wed,  5 Nov 2025 12:04:44 -0500
Message-ID: <20251105170445.518320-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This refactors h4_recv_buf into h4_recv_skb so it can be used by
btusb to implement Bulk Serialization Mode.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_h4.c   | 45 +++++++++++++++++++++++++-----------
 drivers/bluetooth/hci_uart.h |  4 ++++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index ec017df8572c..366a66b79e78 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -112,8 +112,9 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
-	h4->rx_skb = h4_recv_buf(hu, h4->rx_skb, data, count,
-				 h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
+	h4->rx_skb = h4_recv_skb(hu->hdev, &hu->alignment, &hu->padding,
+				 h4->rx_skb, data, count, h4_recv_pkts,
+				 ARRAY_SIZE(h4_recv_pkts));
 	if (IS_ERR(h4->rx_skb)) {
 		int err = PTR_ERR(h4->rx_skb);
 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
@@ -151,12 +152,12 @@ int __exit h4_deinit(void)
 	return hci_uart_unregister_proto(&h4p);
 }
 
-struct sk_buff *h4_recv_buf(struct hci_uart *hu, struct sk_buff *skb,
-			    const unsigned char *buffer, int count,
-			    const struct h4_recv_pkt *pkts, int pkts_count)
+struct sk_buff *h4_recv_skb(struct hci_dev *hdev, u8 *alignment, u8 *padding,
+			    struct sk_buff *skb, const unsigned char *buffer,
+			    int count, const struct h4_recv_pkt *pkts,
+			    int pkts_count)
 {
-	u8 alignment = hu->alignment ? hu->alignment : 1;
-	struct hci_dev *hdev = hu->hdev;
+	u8 align = alignment && *alignment ? *alignment : 1;
 
 	/* Check for error from previous call */
 	if (IS_ERR(skb))
@@ -166,10 +167,13 @@ struct sk_buff *h4_recv_buf(struct hci_uart *hu, struct sk_buff *skb,
 		int i, len;
 
 		/* remove padding bytes from buffer */
-		for (; hu->padding && count > 0; hu->padding--) {
-			count--;
-			buffer++;
+		if (padding) {
+			for (; (*padding) && count > 0; (*padding)--) {
+				count--;
+				buffer++;
+			}
 		}
+
 		if (!count)
 			break;
 
@@ -252,16 +256,20 @@ struct sk_buff *h4_recv_buf(struct hci_uart *hu, struct sk_buff *skb,
 			}
 
 			if (!dlen) {
-				hu->padding = (skb->len + 1) % alignment;
-				hu->padding = (alignment - hu->padding) % alignment;
+				if (padding) {
+					*padding = (skb->len + 1) % align;
+					*padding = (align - *padding) % align;
+				}
 
 				/* No more data, complete frame */
 				(&pkts[i])->recv(hdev, skb);
 				skb = NULL;
 			}
 		} else {
-			hu->padding = (skb->len + 1) % alignment;
-			hu->padding = (alignment - hu->padding) % alignment;
+			if (padding) {
+				*padding = (skb->len + 1) % align;
+				*padding = (align - *padding) % align;
+			}
 
 			/* Complete frame */
 			(&pkts[i])->recv(hdev, skb);
@@ -271,4 +279,13 @@ struct sk_buff *h4_recv_buf(struct hci_uart *hu, struct sk_buff *skb,
 
 	return skb;
 }
+EXPORT_SYMBOL_GPL(h4_recv_skb);
+
+struct sk_buff *h4_recv_buf(struct hci_uart *hu, struct sk_buff *skb,
+			    const unsigned char *buffer, int count,
+			    const struct h4_recv_pkt *pkts, int pkts_count)
+{
+	return h4_recv_skb(hu->hdev, &hu->alignment, &hu->padding, skb, buffer,
+			   count, pkts, pkts_count);
+}
 EXPORT_SYMBOL_GPL(h4_recv_buf);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 48ac7ca9334e..501b70889567 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -165,6 +165,10 @@ int h4_deinit(void);
 struct sk_buff *h4_recv_buf(struct hci_uart *hu, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count);
+struct sk_buff *h4_recv_skb(struct hci_dev *hdev, u8 *alignment, u8 *padding,
+			    struct sk_buff *skb, const unsigned char *buffer,
+			    int count, const struct h4_recv_pkt *pkts,
+			    int pkts_count);
 #endif
 
 #ifdef CONFIG_BT_HCIUART_BCSP
-- 
2.51.0

