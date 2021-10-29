Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2F9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 06:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DED60FF2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 06:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJ2GQT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 02:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJ2GQS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 02:16:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD28C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 23:13:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so9805508pjl.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 23:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVbBNlcH8Du6P6FZ6xZpuNsX+i4q1Tn0d6nGipaE1mk=;
        b=q0mOS8bwUWNb21UYRKsP0SENOqwZNCuTgLIAdx2J68Kia6hXCuhzjLR8FxZ1a20AIM
         L4Xwb98HuHAucmKjD/DByyNYMkQRgVQGBSZUJteHc2u2TyIUfB2cwxd4j48zUlMWI2jN
         ucD9VEgLBItWtgoXqiw2rr62UfUB5qlsIM8SE14wz4NYbXazbStcY6aIAsGk8oxJD5Rr
         DeKMp1ZZWdILXwaT43MKnVH5XAxbvgOHx2h61wKMJBI9hkITqvnZK6JmtOL+i8h9TGIL
         uzdvyYeeaDxbiM8ufMNkDLIobgPcbuzDOXkL2uq0oA/FQPwCB14Si39bwD3QQkWiOuTB
         c11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVbBNlcH8Du6P6FZ6xZpuNsX+i4q1Tn0d6nGipaE1mk=;
        b=CfJvCv5Tmmg0l8ROWdA+ILPlCBKg1w37LHMdbKLbiJJ+mrdmlTu9sqvPj+NT+n0pgl
         aEokjQewJT1Ml1soYjvcB5RPM7uklTFXrYBIOsofSJx2aUKUBP6ULhGkQ+c4VpEgQbsb
         4dzYprwa5uzKTLsA7r+1uks9/+oA0G5fVU7jGAHbQN3LBG5r+PU0KxEnXUejifGhAyJU
         LLm5Wijt51QkPM00gMwBepTCNEDrWkQ0V65Dcb68lIKzyRBSw3BfozEeDCUYwmGGQlBW
         JsekA3POjPSPbfrSf0mAEmpu9G0TyWHmea7ZwQEmYN9fqTyZRh0byfYWSbUbVmWjAhS2
         mfTQ==
X-Gm-Message-State: AOAM533BLzfGHiVzoADp/kHWfKfY9IBH5BHbwGMnVgZHL3QmnyPt+xI8
        ds8r34xl+zwXTZkREip4h2v6fZgZPxNo3A==
X-Google-Smtp-Source: ABdhPJz3WhG3+iWL4aZfM9qSzO72g4uhZovLZtjtih8BkFuQedzLPXkLxFkPKB9uXt5Ox8FAc22crA==
X-Received: by 2002:a17:902:c102:b0:13f:5507:bdc9 with SMTP id 2-20020a170902c10200b0013f5507bdc9mr8031762pli.8.1635488029456;
        Thu, 28 Oct 2021 23:13:49 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:11f1:754d:5bb:5f40])
        by smtp.gmail.com with ESMTPSA id h10sm6012991pfc.104.2021.10.28.23.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 23:13:48 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH] Bluetooth: vhci: Add new packet type for VHCI
Date:   Thu, 28 Oct 2021 23:13:45 -0700
Message-Id: <20211029061345.676005-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Current implementation uses the Vendor packet type (0xff) with opcode
parameter. But there is no way to expand the opcode and no available bits
to use. Also it cannot be changed due to the backward compatibility
with older kernel.

So, this patch adds new packet type dedicated for VHCI(0xfe) to support
configuring the VHCI device with quarks and flags while creating the
VHCI driver.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 161 ++++++++++++++++++++++++++++++-----
 include/net/bluetooth/hci.h  |   1 +
 2 files changed, 140 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 49ac884d996e..4ae1e861b3a8 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -30,6 +30,20 @@
 
 static bool amp;
 
+struct vhci_ext_create_device_req {
+	__u8	dev_type;
+	__u32	flags;
+} __packed;
+
+#define VHCI_FLAG_QUIRK_RAW_DEVICE		0x01
+#define VHCI_FLAG_QUIRK_EXTERNAL_CONFIG		0x02
+#define VHCI_FLAG_QUIRKS_INVALID_BDADDR		0x04
+
+struct vhci_ext_create_device_resp {
+	__u8	dev_type;
+	__u16	index;
+} __packed;
+
 struct vhci_data {
 	struct hci_dev *hdev;
 
@@ -278,6 +292,38 @@ static int vhci_setup(struct hci_dev *hdev)
 	return 0;
 }
 
+static void vhci_create_debugfs(struct hci_dev *hdev)
+{
+	struct vhci_data *data = hci_get_drvdata(hdev);
+
+	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
+			    &force_suspend_fops);
+
+	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
+			    &force_wakeup_fops);
+
+	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
+		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
+				    &msft_opcode_fops);
+
+	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
+		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
+				    &aosp_capable_fops);
+}
+
+static void vhci_setup_hdev(struct hci_dev *hdev)
+{
+	hdev->open  = vhci_open_dev;
+	hdev->close = vhci_close_dev;
+	hdev->flush = vhci_flush;
+	hdev->send  = vhci_send_frame;
+	hdev->get_data_path_id = vhci_get_data_path_id;
+	hdev->get_codec_config_data = vhci_get_codec_config_data;
+	hdev->wakeup = vhci_wakeup;
+	hdev->setup = vhci_setup;
+	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+}
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -313,15 +359,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->dev_type = dev_type;
 	hci_set_drvdata(hdev, data);
 
-	hdev->open  = vhci_open_dev;
-	hdev->close = vhci_close_dev;
-	hdev->flush = vhci_flush;
-	hdev->send  = vhci_send_frame;
-	hdev->get_data_path_id = vhci_get_data_path_id;
-	hdev->get_codec_config_data = vhci_get_codec_config_data;
-	hdev->wakeup = vhci_wakeup;
-	hdev->setup = vhci_setup;
-	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+	vhci_setup_hdev(hdev);
 
 	/* bit 6 is for external configuration */
 	if (opcode & 0x40)
@@ -339,19 +377,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		return -EBUSY;
 	}
 
-	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
-			    &force_suspend_fops);
-
-	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
-			    &force_wakeup_fops);
-
-	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
-		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
-				    &msft_opcode_fops);
-
-	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
-		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
-				    &aosp_capable_fops);
+	vhci_create_debugfs(hdev);
 
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
@@ -364,6 +390,67 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	return 0;
 }
 
+static int __vhci_ext_create_device(struct vhci_data *data, __u8 dev_type,
+								__u32 flags)
+{
+	struct hci_dev *hdev;
+	struct sk_buff *skb;
+	struct vhci_ext_create_device_resp *resp;
+
+	if (data->hdev)
+		return -EBADFD;
+
+	if (dev_type != HCI_PRIMARY && dev_type != HCI_AMP)
+		return -EINVAL;
+
+	skb = bt_skb_alloc(sizeof(*resp) + 1, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		kfree_skb(skb);
+		return -ENOMEM;
+	}
+
+	data->hdev = hdev;
+
+	hdev->bus = HCI_VIRTUAL;
+	hdev->dev_type = dev_type;
+	hci_set_drvdata(hdev, data);
+
+	vhci_setup_hdev(hdev);
+
+	/* Check quirks and set it for hdev */
+	if (flags & VHCI_FLAG_QUIRK_EXTERNAL_CONFIG)
+		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
+
+	if (flags & VHCI_FLAG_QUIRK_RAW_DEVICE)
+		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+
+	if (flags & VHCI_FLAG_QUIRKS_INVALID_BDADDR)
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+
+	if (hci_register_dev(hdev) < 0) {
+		BT_ERR("Can't register HCI device");
+		hci_free_dev(hdev);
+		data->hdev = NULL;
+		kfree_skb(skb);
+		return -EBUSY;
+	}
+
+	vhci_create_debugfs(hdev);
+
+	hci_skb_pkt_type(skb) = HCI_VHCI_PKT;
+	skb_put_u8(skb, HCI_VHCI_PKT);
+	skb_put_u8(skb, dev_type);
+	put_unaligned_le16(hdev->id, skb_put(skb, 2));
+	skb_queue_tail(&data->readq, skb);
+
+	wake_up_interruptible(&data->read_wait);
+	return 0;
+}
+
 static int vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	int err;
@@ -375,6 +462,18 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
 	return err;
 }
 
+static int vhci_ext_create_device(struct vhci_data *data, __u8 dev_type,
+								__u32 flags)
+{
+	int err;
+
+	mutex_lock(&data->open_mutex);
+	err = __vhci_ext_create_device(data, dev_type, flags);
+	mutex_unlock(&data->open_mutex);
+
+	return err;
+}
+
 static inline ssize_t vhci_get_user(struct vhci_data *data,
 				    struct iov_iter *from)
 {
@@ -429,6 +528,24 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		ret = vhci_create_device(data, opcode);
 		break;
 
+	/* This packet type is for VHCI specific command */
+	case HCI_VHCI_PKT:
+		cancel_delayed_work_sync(&data->open_timeout);
+		struct vhci_ext_create_device_req *req;
+
+		if (skb->len != sizeof(*req)) {
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+
+		req = (void *)skb->data;
+		skb_pull(skb, sizeof(*req));
+
+		ret = vhci_ext_create_device(data, req->dev_type, req->flags);
+
+		kfree_skb(skb);
+		break;
+
 	default:
 		kfree_skb(skb);
 		return -EINVAL;
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 63065bc01b76..35d720f9e17a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -355,6 +355,7 @@ enum {
 #define HCI_EVENT_PKT		0x04
 #define HCI_ISODATA_PKT		0x05
 #define HCI_DIAG_PKT		0xf0
+#define HCI_VHCI_PKT		0xfe
 #define HCI_VENDOR_PKT		0xff
 
 /* HCI packet types */
-- 
2.25.1

