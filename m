Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10E265614
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240458; cv=none; b=D0MRsNzM/X+wuu6IRNn38vXjzfeqEXUS5rZVGYBxYNgmF5rf9+kgr8QlwuRnRF3/UhiOEqfjxgn3V/gxCe4MLeIIahHJNIAvzsAmkkYzq2c5aclp5Qy5ZzGFc/J0rsHpnK/K2cyaOA5Z8PoiNQnYeEElk4VxyCpLkV0DkVirK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240458; c=relaxed/simple;
	bh=9hRXhrihjn18W3zn0P0CYHwMaPvLAs9GPunraMEkmzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXfwf48vtmeq3KJ2oK0QhxPut30I1pxB/DWeFIKWqaOv4AiwhmIi0FDwLxXmj1Hu153Vd9JBWKqmIg0RxE1Xen1op7hOEp/G0i3Ymi+Nz7wmjrrNmJCcZVeEq9OwE3vKwH3sGkGB8D+RbyQJuKHoeALBP/sQADsGoZZ+MnstiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wbAQ5Rys; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wbAQ5Rys"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C11741A0B
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1745240448;
	bh=lCbWLPkwcd11IY2it1ILkiB9uXJ6gJVyVyXKn+uwbeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=wbAQ5RysR2EpgPSzwKphF1bdjEpZ3gZW5YT0gcfmkKVaNtXySOvrV8qEoiPWWwvny
	 YoFC4dT55Jve38hpPMrcDTfcx7kTzBY0JyI5eUZan4XlGLpIs2ldhsQ6cfcnPrNCKH
	 KvvfZ0/UKi5TP7CIIPNkOZmGSaJgAlXypuiHXkhBCsWKEyZrKuw9w4gpSo1zYeOE60
	 NTTls7zvk7dhxcvccsie/G3gWQNeXkMc8FdeB9eezF4J1pEtXbZqz5Q7+CgEplf9IR
	 zEPL38BRBdEByM1BSlHYSiWcLe3ljSEFT/VEiJ1pyD2VfFcszW+W3xfI7oi1zURgr7
	 /A5Ws2Tci+5KQ==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242f3fd213so36591215ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 06:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745240447; x=1745845247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCbWLPkwcd11IY2it1ILkiB9uXJ6gJVyVyXKn+uwbeQ=;
        b=J/9vL53mb2zRHS0tkWgKQeP0A7tNU6/jx2/y4u0p15hL7fWQgE69ftuHNxlDrRfyN0
         MCAhaDlVBH4LoID9pPpe6BlGsYKhcqPvATykJQR1zDE5r0hn4tEGLDWJnEbExz1POPtz
         4XcbDh95L1yxyjthogrkaNSub+WtMqs482JJyd3L2vKyCn6AJoAl2RNjR0ViWIOBoLJn
         NYVInOD+TAKH9vOJmTqgHaMiEzbsMc0QXAma3q5yd+4DfO0N5fbNKnmKIxklOJH/23wz
         QEdmEsodRQbh4/thLSGz5II3EryCiEIpK/jSLqrc8f5jz+YGb0Hyg8WVpXKephT7o3bn
         D7bg==
X-Forwarded-Encrypted: i=1; AJvYcCXJpjK04dme48QJbAmZwdnbgSxPntAsD1wTlc9wFtataj/cQAFlZ5h8FG6gO2FFs8aUkuIdf4UP+SNfVMW+9J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVXxoqm3QtP5gBMz7dtMRn+PrziJyM+iae4SAnnf+nFUXrz/4
	87/onyyV93nBHO+dAvg6pqXfbgWkg8oPjU4XtpigFCy/mElJZwbIbf56axqKP7p7BlBcU+TtZxm
	Zblx9Ac0y3QkjgBB6AlxZI+HQFNbEbO6ipy0E7q6JDquY1z1uvm9SOo1s4FiGEH0LqTkqXT+4vc
	4H+ZY0VA==
X-Gm-Gg: ASbGncsVPZE8wIgFTyKSPGpQBk4zo8wdUmWbFi9oCkT0t+az6oihgPfhrROV8OEirw1
	JFFBSwyzVijTNjcFWp0oaHoAFDXq3DQIg7/rPcaVK+yFaqLWhktFa/xkFCt+YfYkwHEWzVQxpqI
	jxQSJyFsoTF+Bsf+b3+TLDiJv6g7H8nyBLuXXrMKGQqZPJuO6cqbvnmGchlFAY3vMdx91r1yGJA
	t9v0FqLg0teOpSlVM84hBi9E1L02JRLNIT5aBpbUPvXHeg7/S/y7+3pnajlPQW4ZtsCD1EVb4Z9
	xCN9xsICaj8BWcCm+7cMXSfhKhmJJ3bhdAr78rYjuaFWPLMAUNCHSm7csRfi0VATo00=
X-Received: by 2002:a17:902:ce8c:b0:21f:4b01:b978 with SMTP id d9443c01a7336-22c53607c5bmr176836135ad.36.1745240447002;
        Mon, 21 Apr 2025 06:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdvFShV2nlhmQMMXImwULfB87YqyI/wlSbYfoHVWRayGTitUVffbOk2LHSHkXPW+oCg0Oz3A==
X-Received: by 2002:a17:902:ce8c:b0:21f:4b01:b978 with SMTP id d9443c01a7336-22c53607c5bmr176835035ad.36.1745240446043;
        Mon, 21 Apr 2025 06:00:46 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.cnshub.home ([182.233.178.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bda7b3sm64758665ad.52.2025.04.21.06.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:00:45 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	chia-lin.kao@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v4 1/2] Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
Date: Mon, 21 Apr 2025 21:00:37 +0800
Message-ID: <20250421130038.34998-2-en-wei.wu@canonical.com>
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

A NULL pointer dereference can occur in skb_dequeue() when processing a
QCA firmware crash dump on WCN7851 (0489:e0f3).

[ 93.672166] Bluetooth: hci0: ACL memdump size(589824)

[ 93.672475] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 93.672517] Workqueue: hci0 hci_devcd_rx [bluetooth]
[ 93.672598] RIP: 0010:skb_dequeue+0x50/0x80

The issue stems from handle_dump_pkt_qca() returning 0 even when a dump
packet is successfully processed. This is because it incorrectly
forwards the return value of hci_devcd_init() (which returns 0 on
success). As a result, the caller (btusb_recv_acl_qca() or
btusb_recv_evt_qca()) assumes the packet was not handled and passes it
to hci_recv_frame(), leading to premature kfree() of the skb.

Later, hci_devcd_rx() attempts to dequeue the same skb from the dump
queue, resulting in a NULL pointer dereference.

Fix this by:
1. Making handle_dump_pkt_qca() return 0 on success and negative errno
   on failure, consistent with kernel conventions.
2. Splitting dump packet detection into separate functions for ACL
   and event packets for better structure and readability.

This ensures dump packets are properly identified and consumed, avoiding
double handling and preventing NULL pointer access.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 100 +++++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a9b89bcea22..f905780fcdea 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3012,22 +3012,16 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
 		bt_dev_err(hdev, "%s: triggle crash failed (%d)", __func__, err);
 }
 
-/*
- * ==0: not a dump pkt.
- * < 0: fails to handle a dump pkt
- * > 0: otherwise.
- */
+/* Return: 0 on success, negative errno on failure. */
 static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	int ret = 1;
+	int ret = 0;
 	u8 pkt_type;
 	u8 *sk_ptr;
 	unsigned int sk_len;
 	u16 seqno;
 	u32 dump_size;
 
-	struct hci_event_hdr *event_hdr;
-	struct hci_acl_hdr *acl_hdr;
 	struct qca_dump_hdr *dump_hdr;
 	struct btusb_data *btdata = hci_get_drvdata(hdev);
 	struct usb_device *udev = btdata->udev;
@@ -3037,30 +3031,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	sk_len = skb->len;
 
 	if (pkt_type == HCI_ACLDATA_PKT) {
-		acl_hdr = hci_acl_hdr(skb);
-		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
-			return 0;
 		sk_ptr += HCI_ACL_HDR_SIZE;
 		sk_len -= HCI_ACL_HDR_SIZE;
-		event_hdr = (struct hci_event_hdr *)sk_ptr;
-	} else {
-		event_hdr = hci_event_hdr(skb);
 	}
 
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return 0;
-
 	sk_ptr += HCI_EVENT_HDR_SIZE;
 	sk_len -= HCI_EVENT_HDR_SIZE;
 
 	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return 0;
-
-	/*it is dump pkt now*/
 	seqno = le16_to_cpu(dump_hdr->seqno);
 	if (seqno == 0) {
 		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
@@ -3134,17 +3112,83 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	return ret;
 }
 
+/* Return: true if the ACL packet is a dump packet, false otherwise. */
+static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 *sk_ptr;
+	unsigned int sk_len;
+
+	struct hci_event_hdr *event_hdr;
+	struct hci_acl_hdr *acl_hdr;
+	struct qca_dump_hdr *dump_hdr;
+
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	acl_hdr = hci_acl_hdr(skb);
+	if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
+		return false;
+	sk_ptr += HCI_ACL_HDR_SIZE;
+	sk_len -= HCI_ACL_HDR_SIZE;
+	event_hdr = (struct hci_event_hdr *)sk_ptr;
+
+	if ((event_hdr->evt != HCI_VENDOR_PKT)
+		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
+		return false;
+
+	sk_ptr += HCI_EVENT_HDR_SIZE;
+	sk_len -= HCI_EVENT_HDR_SIZE;
+
+	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
+	if ((sk_len < offsetof(struct qca_dump_hdr, data))
+		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
+	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		return false;
+
+	return true;
+}
+
+/* Return: true if the event packet is a dump packet, false otherwise. */
+static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 *sk_ptr;
+	unsigned int sk_len;
+
+	struct hci_event_hdr *event_hdr;
+	struct qca_dump_hdr *dump_hdr;
+
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	event_hdr = hci_event_hdr(skb);
+
+	if ((event_hdr->evt != HCI_VENDOR_PKT)
+		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
+		return false;
+
+	sk_ptr += HCI_EVENT_HDR_SIZE;
+	sk_len -= HCI_EVENT_HDR_SIZE;
+
+	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
+	if ((sk_len < offsetof(struct qca_dump_hdr, data))
+		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
+	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		return false;
+
+	return true;
+}
+
 static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (handle_dump_pkt_qca(hdev, skb))
-		return 0;
+	if (acl_pkt_is_dump_qca(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
 static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (handle_dump_pkt_qca(hdev, skb))
-		return 0;
+	if (evt_pkt_is_dump_qca(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
-- 
2.43.0

