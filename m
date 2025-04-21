Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FC1DFE00
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240456; cv=none; b=hGkK3GltUleOAqQr3eggk64S6ByaMzgvKitG40KuNjOTjSFSh0BxMKiWhaW96ivTjIqScHj5AR2uFyq1QZntVLrUJhgLyitxe4TMVoJtvDU2x+4nxLUN3To7qiJddbZqWbgwz7vd06TMiySL43BLnPr57cPygjEXELjbOtf7H4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240456; c=relaxed/simple;
	bh=U6HdusizQQ44WP/OcKAx6zUmmKr7k0YwKNHZu1i2KaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhEJk7ejXDkaluWhEmsBWjcxa3GV4//woLjpmnZaXW3uuxWvbxZq7i9l2DFOw/oRHxzXM09WZSZj8mu0h1tG9h83pI7rVtUV2PbCV/kczT3H6GboOKNHI3Mf5viKmY2wM2C4liAg5WSva025mEIPiqKQiXpSqMkz/bitPFnEWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=auL+r6RC; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="auL+r6RC"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 81C4940057
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1745240451;
	bh=xt2B9ADJDt0Wyq0DI03C72a3TKtZqtXqFgRaWL3xAMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=auL+r6RCuX0GsJufbzlp/TnJeRqU2wFQSmrbDWd0JUC94XRTStrp4LZa5qRAh9D5S
	 fpggaAcLk7Bgbv3Dp/GUWohR59NnBIXDHv4HiLjdxAsN69LlzBTQZ0epWsTRsBsgiQ
	 AMkPBjmWADNmIGIGaCwyLO9Ze1IXM2q17hYpRJ3aGM1EIBHunCSk7SDFGV9GXsgmI9
	 eWgEXRkbK7/QTH8BsZxnINkCBmQQZacwgaMUmgV/gABnRiZlVM4U5yuGRJE5lZhGVW
	 uoufctTb9KqTCm9s64FlBPiq6EAGh0DPxXn4Erj4to+Z4a74OMNilP6fsWUCim/OHW
	 FnVirKwu3YyAQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-227e2faab6dso35205415ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745240450; x=1745845250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xt2B9ADJDt0Wyq0DI03C72a3TKtZqtXqFgRaWL3xAMI=;
        b=Ces4WHSfyK69jF9glsodnhIuqCGobBBqs7DWN1DeXDAZJMkDvRvIPwUR6PlwWovu9l
         D1HytvPmLjiK8KrbalVkEgGN3V7/YQoTFyivqZ55UqGaPdrKXhadvvOLokq0rX2TvIWz
         PV6BGNjQpeTbDmGIFpqEgDcPjuvzfdj4OwIDs7eKZeU0wTf2keRqiCtXVdpwBdEkj63j
         tDnwRJdxThx+DxeeowPKKnx2pW3o1Zss3dKiCSx02pljr8YhwgeHNkCUJLSQYrOAWNnI
         WH21bE3omoy5yvyB30kq1iFPub6CbOrAK321PpKN19rL5zanCfSViHQeuT7Ezu7M7TGB
         zVUw==
X-Forwarded-Encrypted: i=1; AJvYcCUVDTXkUmg+yHQ6PUuKtHM2hsstoifGxJtDEiCnXSdyybBJEko75Ylh9fGPhI3a2S1c/VMALs0lpjrJlYYFPFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywobrqc8jcWd2BtIOfNGv1lzhNW8ljL6zzIV5NkekQR8e2IkR1m
	phABwwiKipZuBmtwqsYCv7kdrGo3RkmMVXavhMeoDaYt8Xn/q5vel4mE9JezRMJK3MNcxBLQsQt
	/QzUSBc5CzcYPY2fARm4AGp0vTXq/FbK3HKI1rFugOnuHY/4aeXtGmjGeExfKoh1wSvEfjK9MmZ
	bdEIsIwg==
X-Gm-Gg: ASbGncsIVnU9g3C7lUk4Kw4MGS+Qh3WvNjEg/NerucB1h3dRAsMvUcH1Lj78DQ7uxmF
	GwKdxi5251BAvlNW8Jz0U6eSpNOQCZoWc1Xm5bRPnZjZICOnR7Q8EzuJD0KBUsIj7DuiIR7G3eQ
	nIE8O/EOJ01TLsmbHixxp9nuA9po7AjrRTMs7/3G3PHGNhwN4KJ09VZ4oaUSyDP0CxYZ/n6iFJy
	XAQFyXkFelTUMOTiHlYE+on/tZBgPr6IQFM/4HwkX10sboU0JujMwGR5eldTBzkQBxQJlPgz3/5
	eq9eYX/yCRU3dPuAAWkljBFm5Vgm0y8CC9VuQFqRE1MyhBs+2fNwVXIU0+vH7jMYv6Y=
X-Received: by 2002:a17:902:f611:b0:220:d909:1734 with SMTP id d9443c01a7336-22c5359c1fdmr169217875ad.14.1745240449757;
        Mon, 21 Apr 2025 06:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC3QVfR3rmUZ11eoJYGY0QEOqAKR0jKz3lbZlewuMME5I1asWEVrEnNWc0ZMiKJm9A0yP6IA==
X-Received: by 2002:a17:902:f611:b0:220:d909:1734 with SMTP id d9443c01a7336-22c5359c1fdmr169217335ad.14.1745240449310;
        Mon, 21 Apr 2025 06:00:49 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.cnshub.home ([182.233.178.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bda7b3sm64758665ad.52.2025.04.21.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:00:48 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	chia-lin.kao@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v4 2/2] Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling
Date: Mon, 21 Apr 2025 21:00:38 +0800
Message-ID: <20250421130038.34998-3-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421130038.34998-1-en-wei.wu@canonical.com>
References: <20250421130038.34998-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use skb_pull() and skb_pull_data() to safely parse QCA dump packets.

This avoids direct pointer math on skb->data, which could lead to
invalid access if the packet is shorter than expected.

Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 98 ++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 57 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f905780fcdea..031292ab766f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3017,8 +3017,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int ret = 0;
 	u8 pkt_type;
-	u8 *sk_ptr;
-	unsigned int sk_len;
 	u16 seqno;
 	u32 dump_size;
 
@@ -3027,18 +3025,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	struct usb_device *udev = btdata->udev;
 
 	pkt_type = hci_skb_pkt_type(skb);
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
 
-	if (pkt_type == HCI_ACLDATA_PKT) {
-		sk_ptr += HCI_ACL_HDR_SIZE;
-		sk_len -= HCI_ACL_HDR_SIZE;
-	}
-
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
-
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
 	seqno = le16_to_cpu(dump_hdr->seqno);
 	if (seqno == 0) {
 		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
@@ -3058,16 +3046,15 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 
 		btdata->qca_dump.ram_dump_size = dump_size;
 		btdata->qca_dump.ram_dump_seqno = 0;
-		sk_ptr += offsetof(struct qca_dump_hdr, data0);
-		sk_len -= offsetof(struct qca_dump_hdr, data0);
+
+		skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
 
 		usb_disable_autosuspend(udev);
 		bt_dev_info(hdev, "%s memdump size(%u)\n",
 			    (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
 			    dump_size);
 	} else {
-		sk_ptr += offsetof(struct qca_dump_hdr, data);
-		sk_len -= offsetof(struct qca_dump_hdr, data);
+		skb_pull(skb, offsetof(struct qca_dump_hdr, data));
 	}
 
 	if (!btdata->qca_dump.ram_dump_size) {
@@ -3087,7 +3074,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 		return ret;
 	}
 
-	skb_pull(skb, skb->len - sk_len);
 	hci_devcd_append(hdev, skb);
 	btdata->qca_dump.ram_dump_seqno++;
 	if (seqno == QCA_LAST_SEQUENCE_NUM) {
@@ -3115,67 +3101,65 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 /* Return: true if the ACL packet is a dump packet, false otherwise. */
 static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 *sk_ptr;
-	unsigned int sk_len;
-
 	struct hci_event_hdr *event_hdr;
 	struct hci_acl_hdr *acl_hdr;
 	struct qca_dump_hdr *dump_hdr;
+	void *orig_data;
+	unsigned int orig_len;
 
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	orig_data = skb->data;
+	orig_len = skb->len;
 
-	acl_hdr = hci_acl_hdr(skb);
-	if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
-		return false;
-	sk_ptr += HCI_ACL_HDR_SIZE;
-	sk_len -= HCI_ACL_HDR_SIZE;
-	event_hdr = (struct hci_event_hdr *)sk_ptr;
+	acl_hdr = skb_pull_data(skb, sizeof(*acl_hdr));
+	if (!acl_hdr || (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE))
+		goto restore_return;
 
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return false;
+	event_hdr = skb_pull_data(skb, sizeof(*event_hdr));
+	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+		goto restore_return;
 
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
-
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return false;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
+	if ((skb->len < sizeof(*dump_hdr)) ||
+	   (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
+	   (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		goto restore_return;
 
 	return true;
+
+restore_return:
+	skb->data = orig_data;
+	skb->len = orig_len;
+	return false;
 }
 
 /* Return: true if the event packet is a dump packet, false otherwise. */
 static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 *sk_ptr;
-	unsigned int sk_len;
-
 	struct hci_event_hdr *event_hdr;
 	struct qca_dump_hdr *dump_hdr;
+	void *orig_data;
+	unsigned int orig_len;
 
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	orig_data = skb->data;
+	orig_len = skb->len;
 
-	event_hdr = hci_event_hdr(skb);
+	event_hdr = skb_pull_data(skb, sizeof(*event_hdr));
+	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+		goto restore_return;
 
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return false;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
+	if ((skb->len < sizeof(*dump_hdr)) ||
+	   (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
+	   (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		goto restore_return;
 
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
+	return true;
 
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return false;
+restore_return:
+	skb->data = orig_data;
+	skb->len = orig_len;
+	return false;
 
-	return true;
 }
 
 static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.43.0

