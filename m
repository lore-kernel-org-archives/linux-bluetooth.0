Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97766C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 03:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7C56112D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhKIDQd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Nov 2021 22:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbhKIDQd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Nov 2021 22:16:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C867C061570
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Nov 2021 19:13:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b13so18373714plg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Nov 2021 19:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUuJFJ2hSAxTW+fGBPAYkkGsvphsBrBvwfnmxmIkLhM=;
        b=bSrlBXej2snI+mjFJz9JLbRex/nbXAFUF228Ur00qy1uJ1lLANli8MXHafBBMwIV5E
         bxJYYT8AKLn4W+91s43q2dgsVcD85Be64iATuqBc3BiDbJgbOw/q4/Pdpl6OnBNn4Ttg
         CLBbYhIKP6VoEAH7kDAYlqsL8K++c2BfUEgbQ6uK5+m2/T3qt59IY8Xmg9NQ1g2cfQcw
         i1lIGE6HySgYfF4OH+A0SQQDqK/E3yXIlL3jm5+oxUZn0gm1Sm5OeTBrkE1Cz71w8/fS
         KlnFX3f+b2xyHV6f82qd6jOJeEFgjAIgfKjzhfecsgw7jzLHig2PnIS3gyXXb1Iv83GB
         G1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUuJFJ2hSAxTW+fGBPAYkkGsvphsBrBvwfnmxmIkLhM=;
        b=MhqLxQEh/njSSCwOZk0pH+J2PdlgFUljKRpoc+6JFip8ASyKHPsZmHDc12zFFMZhSu
         iHKdhXvTTEkXIKDNf8lyDSgX+j99FeGLcD7klmai6dj8VI+uYpHfBWTdedDdu7vbCTMX
         03DXwqlr1lxI2wUcSJFWxEmMe3VgiRzvNUmBBxvZ76KTBJ+JYSEeo1tobMYecPXHeifl
         dxxwagxYwjRMTptxD0lCp3pTI4ksX7ROYn+ltvlbH/pyxvMlfkVEr4c0wv/BP9M895Ft
         3ThOeSZ9A4vJ6+TfICqzkQ4hFxMTc/q1cFZ15INABXRd/r+ZtIxxPS64ns7IXoX7dKcm
         Rt0A==
X-Gm-Message-State: AOAM530JBBaXwiRPIrsQrN9CqC5qWr/6mGNhhi7f33/4o+gAYx3KgEdY
        xZuhm4miejVu+pft/YmGktSAmrpkL6I=
X-Google-Smtp-Source: ABdhPJz0rIl1U5eaOa7SdwyST//atTpL90pt7peoxD1Yv5vTelEBHgIxsAzi8kJwgiv2wEIBuTJbaw==
X-Received: by 2002:a17:903:1111:b0:13f:d1d7:fb67 with SMTP id n17-20020a170903111100b0013fd1d7fb67mr4093781plh.85.1636427627493;
        Mon, 08 Nov 2021 19:13:47 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:5b7c:ac95:861:aaca])
        by smtp.gmail.com with ESMTPSA id n13sm3770518pfj.188.2021.11.08.19.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 19:13:46 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH V5] Bluetooth: vhci: Add support creating extended device mode
Date:   Mon,  8 Nov 2021 19:13:43 -0800
Message-Id: <20211109031343.87728-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds new opcode(0x03) for HCI Vendor packet to support
creating extended device mode. In order to avoid the conflict with the
legacy opcode, it has to be 0x03 only and all other bits must be set to
zero.

Then, it is followed by the extended configuration data that contains
the device type and the flags to be used.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 200 ++++++++++++++++++++++++++++-------
 1 file changed, 162 insertions(+), 38 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 49ac884d996e..4c0cfb29c0e8 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -30,6 +30,24 @@
 
 static bool amp;
 
+/* This is the struct for extended device configuration.
+ * The opcode 0x03 is used for creating an extended device and followed by
+ * the configuration data below.
+ * dev_type is Primay or AMP.
+ * flag_len is the length of flag array
+ * flag array contains the flag to use/set while creating the device.
+ */
+struct vhci_ext_config {
+	__u8	dev_type;
+	__u8	flag_len;
+	__u8	flags[0];
+};
+
+#define VHCI_EXT_FLAG_ENABLE_AOSP		0x01
+#define VHCI_EXT_FLAG_QUIRK_RAW_DEVICE		0x02
+#define VHCI_EXT_FLAG_QUIARK_EXTERNAL_CONFIG	0x03
+#define VHCI_EXT_FLAG_QUIRK_INVALID_BDADDR	0x04
+
 struct vhci_data {
 	struct hci_dev *hdev;
 
@@ -278,11 +296,52 @@ static int vhci_setup(struct hci_dev *hdev)
 	return 0;
 }
 
+static int vhci_register_hdev(struct hci_dev *hdev, __u8 opcode)
+{
+	struct vhci_data *data = hci_get_drvdata(hdev);
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(4, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	if (hci_register_dev(hdev) < 0) {
+		BT_ERR("Can't register HCI device");
+		kfree_skb(skb);
+		return -EBUSY;
+	}
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
+
+	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
+
+	skb_put_u8(skb, 0xff);
+	skb_put_u8(skb, opcode);
+	put_unaligned_le16(hdev->id, skb_put(skb, 2));
+	skb_queue_tail(&data->readq, skb);
+
+	wake_up_interruptible(&data->read_wait);
+
+	return 0;
+}
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
-	struct sk_buff *skb;
 	__u8 dev_type;
+	int ret;
 
 	if (data->hdev)
 		return -EBADFD;
@@ -297,15 +356,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (opcode & 0x3c)
 		return -EINVAL;
 
-	skb = bt_skb_alloc(4, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
 	hdev = hci_alloc_dev();
-	if (!hdev) {
-		kfree_skb(skb);
+	if (!hdev)
 		return -ENOMEM;
-	}
 
 	data->hdev = hdev;
 
@@ -331,45 +384,108 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (opcode & 0x80)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
-	if (hci_register_dev(hdev) < 0) {
-		BT_ERR("Can't register HCI device");
+	/* Legacy method returns opcode instead of dev type */
+	ret = vhci_register_hdev(hdev, opcode);
+	if (ret < 0) {
 		hci_free_dev(hdev);
 		data->hdev = NULL;
-		kfree_skb(skb);
-		return -EBUSY;
 	}
 
-	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
-			    &force_suspend_fops);
+	return ret;
+}
 
-	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
-			    &force_wakeup_fops);
+static int vhci_create_device(struct vhci_data *data, __u8 opcode)
+{
+	int err;
 
-	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
-		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
-				    &msft_opcode_fops);
+	mutex_lock(&data->open_mutex);
+	err = __vhci_create_device(data, opcode);
+	mutex_unlock(&data->open_mutex);
 
-	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
-		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
-				    &aosp_capable_fops);
+	return err;
+}
 
-	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
+static int __vhci_create_extended_device(struct vhci_data *data,
+							struct sk_buff *skb)
+{
+	struct hci_dev *hdev;
+	struct vhci_ext_config *config;
+	int i, ret;
+	__u8 flag;
 
-	skb_put_u8(skb, 0xff);
-	skb_put_u8(skb, opcode);
-	put_unaligned_le16(hdev->id, skb_put(skb, 2));
-	skb_queue_tail(&data->readq, skb);
+	if (data->hdev)
+		return -EBADFD;
 
-	wake_up_interruptible(&data->read_wait);
-	return 0;
+	/* Make sure the skb has a minimum valid length */
+	if (skb->len < sizeof(*config))
+		return -EINVAL;
+
+	config = (void *)(skb->data);
+	if (skb->len < sizeof(*config) + config->flag_len)
+		return -EINVAL;
+
+	if (config->dev_type != HCI_PRIMARY && config->dev_type != HCI_AMP)
+		return -EINVAL;
+
+	hdev = hci_alloc_dev();
+	if (!hdev)
+		return -ENOMEM;
+
+	data->hdev = hdev;
+
+	hdev->bus = HCI_VIRTUAL;
+	hdev->dev_type = config->dev_type;
+	hci_set_drvdata(hdev, data);
+
+	hdev->open  = vhci_open_dev;
+	hdev->close = vhci_close_dev;
+	hdev->flush = vhci_flush;
+	hdev->send  = vhci_send_frame;
+	hdev->get_data_path_id = vhci_get_data_path_id;
+	hdev->get_codec_config_data = vhci_get_codec_config_data;
+	hdev->wakeup = vhci_wakeup;
+	hdev->setup = vhci_setup;
+	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+
+	for (i = 0; i < config->flag_len; i++) {
+		flag = config->flags[i];
+		switch (flag) {
+		case VHCI_EXT_FLAG_ENABLE_AOSP:
+			data->aosp_capable = 1;
+			break;
+		case VHCI_EXT_FLAG_QUIRK_RAW_DEVICE:
+			set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+			break;
+		case VHCI_EXT_FLAG_QUIARK_EXTERNAL_CONFIG:
+			set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
+			break;
+		case VHCI_EXT_FLAG_QUIRK_INVALID_BDADDR:
+			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+			break;
+		default:
+			BT_ERR("Invalid flag");
+			hci_free_dev(hdev);
+			data->hdev = NULL;
+			return -EINVAL;
+		}
+	}
+
+	/* Extended method returns the fixed extension opcode 0x03 */
+	ret = vhci_register_hdev(hdev, 0x03);
+	if (ret < 0) {
+		hci_free_dev(hdev);
+		data->hdev = NULL;
+	}
+
+	return ret;
 }
 
-static int vhci_create_device(struct vhci_data *data, __u8 opcode)
+static int vhci_create_extended_device(struct vhci_data *data,
+							struct sk_buff *skb)
 {
 	int err;
-
 	mutex_lock(&data->open_mutex);
-	err = __vhci_create_device(data, opcode);
+	err = __vhci_create_extended_device(data, skb);
 	mutex_unlock(&data->open_mutex);
 
 	return err;
@@ -419,14 +535,22 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		opcode = *((__u8 *) skb->data);
 		skb_pull(skb, 1);
 
-		if (skb->len > 0) {
-			kfree_skb(skb);
-			return -EINVAL;
+		/* The dev_type 3 is used as an escape opcode for extension
+		 * handling. If dev_type is set to 3 all other bits must be
+		 * set to zero.
+		 */
+		if (opcode == 0x03) {
+			if (skb->len < 1)
+				ret = -EINVAL;
+			else
+				ret = vhci_create_extended_device(data, skb);
+		} else {
+			if (skb->len > 0)
+				ret = -EINVAL;
+			else
+				ret = vhci_create_device(data, opcode);
 		}
-
 		kfree_skb(skb);
-
-		ret = vhci_create_device(data, opcode);
 		break;
 
 	default:
-- 
2.25.1

