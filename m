Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E446F2F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763303; cv=none; b=K+fih/ak0FAYssY3xk4Id6K8j2uRQ4Fqp0fQmuGxtBat/E7SCalXIBA1+kGHmPAJnFS30DTWGAoN7POoN37aPknEuVAYfn4Jj/AtSMnzdQc2Xsf2nHrZB1Ky1LPktfacpbDOxf5wU2hsLd6lUkkN1HQOlj0KNngwhWEuBXAgk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763303; c=relaxed/simple;
	bh=fb7jwHbD677k4r3rvO8ob67nTLFq8FEcQ33AYjPJ02Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zmp3MgOqXfGmc3DqLCC2Qg+8fkznabd4hzE3eYhJX1P87OiF0HUN3wJHBrrMpsQKUMuOrgiFiYtSsV0iQhW6LdA0NLM6v4VCcuZ02KrFJUJ46k+qZaQpipN1bdcAZPeF7O1sujVuL37BE7l5CjN/sbthYxr3GhoJqSVyklZY/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rCmm1blC; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rCmm1blC"
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 269B83F1CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 03:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732763293;
	bh=hh3plfOOHgj+Vrrt6DJRbXu7daZvdrxRuUjcKWQCRaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=rCmm1blCgqqslvyF3AVTN5jNLJFEob7daXPkTFogEc2XK8EkXbZL0voU8jaws2z/m
	 mlTkNVT3nZ3tb5RZA09ptvWiwCtxJdj8aE0gB9tSpzeHRa6o2q86kfbF6GbBG2HqaX
	 LsA5EGA36SdhF1THGFfmezKuEZ95/N4vubbNmaHmKNCnM5jHXP9fUUJp9sdWvhXyIm
	 +oDFeL51CXTLpewMll2qnNwW5Rs1cy7gBZhIr7QhQP8esUOfkoYT+P0D8mIlrZoo4W
	 nlX5ifLsYf1+3OM1oHyTOD0QRBcrmO86+LfejmivQQPQIIJe9sTZr1qs9iEnk6u/4N
	 kmxbU/HHhuiIg==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-725126e7da0so442287b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 19:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763291; x=1733368091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh3plfOOHgj+Vrrt6DJRbXu7daZvdrxRuUjcKWQCRaU=;
        b=Yg9Jr/d3EdangXsPURP8tQp///24aW6h2YZDTbDCPAN8vkZWkdx1lH9sZn/u0GTcyf
         2PM9j99+o5adyZAPm1Og88ntOXt6zel0qWhcpJTnhGvcSq/dq4AOlTmCxWx0eA3J6k0/
         INSp3N+HqwPKmGIbaQeQFN2goU77v+n2RgiSh3yWmzfY7gG5vO8YHZ0Octnf88+iUZIq
         aOPPlC9zYHz2Ml6ekh1fI8h3vav+mtN3IHl2Ifqr0/LZts9zutEG9Z8Bpy4OqlmRaBw6
         nFKZuZEqwkFE5zyaPgmRAlGd2HRLdhIJYyIRVnsGtBVRuoK2Ob52kxUjgSD/YAtefKPR
         6Osg==
X-Forwarded-Encrypted: i=1; AJvYcCWM2Rfj0v/leHfEJXv1gixHYS6KYwWk5rbTTllaMj43iEFZaP42lPbJndXrqFU8gkA3Vurx3uezCqQb51yYI2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdcCDYNpdnl5pnkwUDtD47bTEdAK6CjQwvGpfTXCkWZ7s+UD1
	uLH5RIfJltdQHW7ShZ7tloT78JYnKGiyiMZ1xvP+Dl1ylr9shNvDBPDhQ5B4RRIKlb9JbnHPtpe
	041ENwzkFK5b9giAPEj1BMxRCJ96+pHO/1O6CiZgH75jgBaTFy5cDC1PCdfLmpio49xUn0phELJ
	nbEdQWkw==
X-Gm-Gg: ASbGncsxN7bQ/4gm+/0Bf6xjO8sWDPznLzaXVfalBQpCxuW2I8MiiOuLMVmhQb5uQZb
	GpN5p6T3AuxTzD/yIhS1Xguw1RPx4S8HGu4QShW9GkKkA3flr/HyUR0c3NQrDSrSCm4KMpr9he2
	P0vq1Q8u73cj5Vhz6d46K3RF5FnFSRmyWQ5rzyAX/2Vydith+rTITP2wtVZTwGKDwifd4rj98Ff
	b/0IXJ1jipISlXwzRuDl7MdtdRvlwYdP+wfKV+WimkXzQ+d+DZkjydwIfAH7vDCNSbXoY0SnQdY
	hU95jAEeoN+vn1w25sjJzG3IKXKu9aAfSgWCVNHyLUexD6xw8L0J
X-Received: by 2002:a05:6a00:1390:b0:725:1d37:ebff with SMTP id d2e1a72fcca58-72530141196mr7108416b3a.22.1732763291473;
        Wed, 27 Nov 2024 19:08:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPP15aoGK8MXiLZNsBlnTwzjjA5FX64jlc3vWaIRjez0atSF0AcLEu2GUfnCjj92mBxogIaw==
X-Received: by 2002:a05:6a00:1390:b0:725:1d37:ebff with SMTP id d2e1a72fcca58-72530141196mr7108394b3a.22.1732763291104;
        Wed, 27 Nov 2024 19:08:11 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176150dsm357506b3a.23.2024.11.27.19.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 19:08:10 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anthony.wong@canonical.com,
	kuan-ying.lee@canonical.com
Subject: [PATCH] Bluetooth: btusb: avoid NULL pointer defereference in skb_dequeue()
Date: Thu, 28 Nov 2024 11:08:07 +0800
Message-ID: <20241128030807.270581-1-en-wei.wu@canonical.com>
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
success. It currently returns the value from hci_devcd_init() (0 on success),
but callers expect > 0 to indicate successful dump handling. This causes
hci_recv_frame() to free the skb while it's still queued for dump
processing, leading to the NULL pointer dereference when hci_devcd_rx()
tries to dequeue it.

Fix this by:

1. Extracting dump packet detection into new is_dump_pkt_qca() function
2. Making handle_dump_pkt_qca() return 0 on success and negative errno
   on failure, consistent with other kernel interfaces

This prevents premature skb freeing by ensuring proper handling of dump packets.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 75 ++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..8926f8f60e5c 100644
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
@@ -3052,17 +3030,58 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
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

