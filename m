Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925C18C0C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733106660; cv=none; b=nn+pw1MYb/1mtJLY3IREh7lc5FQuqwGQ1zPVGsBb6e7UIxkw9U1aIyWOBrCGss3SHL+mwzMIoZ9lhvCHYoFiRrTy5P5NtWetxINKFplwH36GlUynPg48UV+WcIugs60AKmrGefn08iYpQHAiVkg5gBTPmt818gFFfta3EyEefik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733106660; c=relaxed/simple;
	bh=Zdq1ZwogLgVqgL+z9O7uP9pI89UJVYGAX8lIGuQkfMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2aNvwMzP6+E5J3Z2kKIRjOgdJzyfY9X+yjr/qADgu1uZXOS2PNniO1yqnqSnU2prwdubJmejgKqJ3KTK2eyA0KsPDOXf366iU1kOfumn1ks52NJL3PdHiTCuqn253dIgZ50pltD7J0/VrykWL5RxOhI8fhmYyzTq4jDTEuygdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nDeWwUTs; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nDeWwUTs"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4558B3F5B6
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733106649;
	bh=+jndlWKS4Xdsna9rr9EhkPhfFpnli2KtOvGE3QLRJWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=nDeWwUTsvwHbxuKc4ysqsppMe3WFvgjp5NsRbGy3+hhXawYNzzk3kMbHFYWNJyNyx
	 BCs1vT1V3pBL/THfSlkYcydHxQENE0MSC3OngyUEs82w8Aq4vJiZmnRptDgehG+58O
	 M/DdlSO58el5/WFc3wgoY64C6FKxEasAD5tzpvLOya0Rh/mnPWzZX5JEbgvVJmwDju
	 TdxPmEE6CMFp3w0fh/rxxHjrr4QPccwP1lE2cOzJ88ZzNdZYjjSWYUMGYudWih75Ba
	 RywUF1hTn1+FY4Q98cqPGUdJIeIC2wFH5jj4JudoHGICuOzdo6HErZWVC1O1Oe0BdL
	 674m3xU4wF6Hg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so3406583a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Dec 2024 18:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733106647; x=1733711447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jndlWKS4Xdsna9rr9EhkPhfFpnli2KtOvGE3QLRJWI=;
        b=LMzQa5hemikTZkPeOZ859IglgoopWgfimNsevr3wQUDdafo4JtqVXn/qhw7Ep1dLRh
         Z6OVE1zlPI0qHH8bs1g/CraWwqQKxf/fJS9bHlux0qvg3eD8HZkHVOx3/TAWvZpfhV6c
         JlkuqHAIJvechToASB7GCWv/lULUKYWSAnp4HreELVKmqD0+toBxTMLBExqsxdhf+tsI
         DMh42041QvGKvxLMVT8CCKpxRY5JFrhJtXBxLdtEgv5JnxuUhDNA4NlzgVavTr3HreWK
         sAGn8F5NEWgdY495Y7an8Adtfd9qoYMazceTubwgDDRdCF4qeUM61wwz2HUYOSjsvuT4
         YG2g==
X-Forwarded-Encrypted: i=1; AJvYcCUe+ErGOQKb1sfrsgHIFfyZGCjm3qJwWRrnsp0b22ASXgcOT4apH3DN1BWw3x98KM8/Jtg+dDr6nZs9H1obl6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpQFeWVEDrmR8bSYR6FNK1qBHX/7iYObnoUPErjW1A+oL6OiA
	RzgCnpqKymr779+2RJ/w9BVX9KG5YQ8gDjdN3+IC/JfluPsuHXZmFzMH62ckd4LVzKGF3UPmQ4L
	aCbpWHxmlapcSoUM4SrD5lJLOzey9+2QTeO+st+HvbGtpKyFnOx4Vr4XYydDMSgRYp6Tar9zCQw
	ArhGjg50SAVdVakA==
X-Gm-Gg: ASbGncuuSflKk5JU9NwLaijamwby6qGEzS35FSaBSBXNJHO1lnRCcouQtSreUJ5py/X
	TjDrhQLUoPSEottu5wYUX/AU0YYPG+qz/wlkg4OuFXJi+iARxHOGALijCpTLY3WPoqj+BWL/YRT
	7z9NnGvfm7vBTNxu35QJO3lfB0JqaV0rQ6fNnJ5HtaVCnDXa+yQBE6C5TUPRAItbgwM9z4BeTE0
	nKXzeazlpT7nRgui353M9dpikO8WBDKzpQGFygEMMf06B0k4dZFZmMfOq90qBpz9IzJ+1GLv2ld
	0w5eC8K8t6t68dyk9/ePqRq8Wfa/Ts37FJnJRv2phX6kHTUTTKw5
X-Received: by 2002:a17:90b:3901:b0:2ee:cddd:2454 with SMTP id 98e67ed59e1d1-2eecddd2aa9mr3115182a91.15.1733106647173;
        Sun, 01 Dec 2024 18:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxhGl95AGvKcN10Yj/5OchnG6inZsxo8Gn1gyPKjD3kWjbNF/yMuICL635d2N3oZktOyD4Cg==
X-Received: by 2002:a17:90b:3901:b0:2ee:cddd:2454 with SMTP id 98e67ed59e1d1-2eecddd2aa9mr3115157a91.15.1733106646862;
        Sun, 01 Dec 2024 18:30:46 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee05324801sm6081821a91.1.2024.12.01.18.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 18:30:46 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	kuan-ying.lee@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v2] Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
Date: Mon,  2 Dec 2024 10:30:41 +0800
Message-ID: <20241202023041.492547-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WCN7851 (0489:e0f3) Bluetooth controller supports firmware crash dump
collection through devcoredump. During this process, the crash dump data
is queued to a dump queue as skb for further processing.

A NULL pointer dereference occurs in skb_dequeue() when processing the
dump queue due to improper return value handling:

[ 93.672166] Bluetooth: hci0: ACL memdump size(589824)

[ 93.672475] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 93.672517] Workqueue: hci0 hci_devcd_rx [bluetooth]
[ 93.672598] RIP: 0010:skb_dequeue+0x50/0x80

The issue stems from handle_dump_pkt_qca() returning the wrong value on
success. It currently returns the value from hci_devcd_init() (0 on 
success), but callers expect > 0 to indicate successful dump handling. 
This causes hci_recv_frame() to free the skb while it's still queued for 
dump processing, leading to the NULL pointer dereference when 
hci_devcd_rx() tries to dequeue it.

Fix this by:

1. Extracting dump packet detection into new is_dump_pkt_qca() function
2. Making handle_dump_pkt_qca() return 0 on success and negative errno
   on failure, consistent with other kernel interfaces

This prevents premature skb freeing by ensuring proper handling of
dump packets.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
changes in v2: 
- Fix typo in the title
- Re-flow a line in the commit message to fit 72 characters
- Add a blank line before btusb_recv_acl_qca()

drivers/bluetooth/btusb.c | 76 ++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..741be218610e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2930,22 +2930,16 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
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
@@ -2955,30 +2949,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3052,17 +3030,59 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	return ret;
 }
 
+/* Return: true if packet is a dump packet, false otherwise. */
+static bool is_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 pkt_type;
+	u8 *sk_ptr;
+	unsigned int sk_len;
+
+	struct hci_event_hdr *event_hdr;
+	struct hci_acl_hdr *acl_hdr;
+	struct qca_dump_hdr *dump_hdr;
+
+	pkt_type = hci_skb_pkt_type(skb);
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	if (pkt_type == HCI_ACLDATA_PKT) {
+		acl_hdr = hci_acl_hdr(skb);
+		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
+			return false;
+		sk_ptr += HCI_ACL_HDR_SIZE;
+		sk_len -= HCI_ACL_HDR_SIZE;
+		event_hdr = (struct hci_event_hdr *)sk_ptr;
+	} else {
+		event_hdr = hci_event_hdr(skb);
+	}
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
+	if (is_dump_pkt_qca(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
 static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (handle_dump_pkt_qca(hdev, skb))
-		return 0;
+	if (is_dump_pkt_qca(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
-- 
2.43.0

