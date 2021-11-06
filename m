Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFE9611C4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 00:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhKFADi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 20:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhKFADh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 20:03:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F4C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 17:00:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id u141so2273620pfc.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY4sbIZEPuz33YjEn5LivdgtiMDAeTexXpQzTRhX7q8=;
        b=WtQRomyciaGIVznE2zyoZu8rIEcmJzZkViSO+AoVXvzqOeSgqOl3oORq17g/hXV5nl
         zn/VOVYBZU1enoD7RsY2nZ+R9p/hfclzL8K2uGLbzFGBpPtnarodPVf6FwsuxF9J4LLY
         gmsbYj6PgV9vAz51pjK1CeM3F/0eU+W2Djo1HLXGV3sA190rKz5ISLqNGx+1+4T69TrR
         I9M3SESi7jpGwGziSrL91L/7ATzyYYlMcmUDONVv6mSIJboMYkmg3HoizwOdGcUaY0qK
         Yb+6hsqP0v33UDONUToDeJM8EHMjjyDyh6g8Vpxk4NPqBJBs78d0TJsl8l2m9CdXnA8N
         HoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY4sbIZEPuz33YjEn5LivdgtiMDAeTexXpQzTRhX7q8=;
        b=WXvZPYZ9NJnkVU/vYjMTJVNnVRs/Sr/K3++EvjmeoQfXvfFszNqM5lTGkE7tj2E9VK
         lBB6qdbXA7zfEAj9BiBxgQPqUtuwNyz7oJdDi645JhUpa9e4ub7OYE8Q4LgeRD3qKlKq
         NQIiQX4CtiWydc0LGhFuTpMPkbslqTHOoNrPRhShkkUbV24CJ9xYPDITCb4A/oJ8VMhL
         B48dnq/8Ngat9qUqHOic/QTZkXylEhe2QtExkgWn+GRi/yoSJRpuYAMsONnRaqsFWxHY
         6uCMXmpKC2+QXFvfir/rqfdNI1/hBIk16crO4pr9mkRVg4VusDoiJ5IRXdAFXwLEekQI
         zksg==
X-Gm-Message-State: AOAM532hknv/rSMZaB973pK9Y0IVCyPakZ2gmw00dOV2Qk5e1tRhEfgu
        sv++koOn2onUT8wQxPqWhHT+sZFRBjM=
X-Google-Smtp-Source: ABdhPJw5rIzxj7y5OZ2Miky3Vk23kQ+HWQwsPJhIu6Geky2qBAUZ8oP01ph7QVQv30C+hzh+VLnZ6A==
X-Received: by 2002:a63:6205:: with SMTP id w5mr34385238pgb.105.1636156854325;
        Fri, 05 Nov 2021 17:00:54 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:2c64:4412:9f30:374c])
        by smtp.gmail.com with ESMTPSA id o1sm10368171pjs.30.2021.11.05.17.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 17:00:51 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH V4] Bluetooth: vhci: Add support creating extended device mode
Date:   Fri,  5 Nov 2021 17:00:48 -0700
Message-Id: <20211106000048.9515-1-hj.tedd.an@gmail.com>
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
 drivers/bluetooth/hci_vhci.c | 155 +++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 49ac884d996e..22955b0620a0 100644
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
+	__u8	flag[0];
+};
+
+#define VHCI_EXT_FLAG_ENABLE_AOSP		0x01
+#define VHCI_EXT_FLAG_QUIRK_RAW_DEVICE		0x02
+#define VHCI_EXT_FLAG_QUIARK_EXTERNAL_CONFIG	0x03
+#define VHCI_EXT_FLAG_QUIRK_INVALID_BDADDR	0x04
+
 struct vhci_data {
 	struct hci_dev *hdev;
 
@@ -375,6 +393,123 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
 	return err;
 }
 
+static int __vhci_create_extended_device(struct vhci_data *data,
+							struct sk_buff *skb)
+{
+	struct hci_dev *hdev;
+	struct sk_buff *resp;
+	struct vhci_ext_config *config;
+	int i;
+	__u8 flag;
+
+	if (data->hdev)
+		return -EBADFD;
+
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
+	resp = bt_skb_alloc(4, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		kfree_skb(resp);
+		return -ENOMEM;
+	}
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
+		flag = config->flag[i];
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
+			kfree_skb(resp);
+			return -EINVAL;
+		}
+	}
+
+	if (hci_register_dev(hdev) < 0) {
+		BT_ERR("Can't register HCI device");
+		hci_free_dev(hdev);
+		data->hdev = NULL;
+		kfree_skb(resp);
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
+	hci_skb_pkt_type(resp) = HCI_VENDOR_PKT;
+
+	skb_put_u8(resp, 0xff);
+	skb_put_u8(resp, 0x03);
+	put_unaligned_le16(hdev->id, skb_put(resp, 2));
+	skb_queue_tail(&data->readq, resp);
+
+	wake_up_interruptible(&data->read_wait);
+	return 0;
+}
+
+static int vhci_create_extended_device(struct vhci_data *data,
+							struct sk_buff *skb)
+{
+	int err;
+	mutex_lock(&data->open_mutex);
+	err = __vhci_create_extended_device(data, skb);
+	mutex_unlock(&data->open_mutex);
+
+	return err;
+}
+
 static inline ssize_t vhci_get_user(struct vhci_data *data,
 				    struct iov_iter *from)
 {
@@ -419,14 +554,22 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
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

