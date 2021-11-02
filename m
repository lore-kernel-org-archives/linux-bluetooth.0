Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 02:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC9D60EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 02:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhKBC7C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 22:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBC7C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 22:59:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BE1C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 19:56:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t7so18849672pgl.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8KkUzWGJNMjXwsmscPFesuut9pEMlMg+ojjJCbDTt8=;
        b=GEygY3/qA2OQESHmpZ5YrOp2h3eZnKVp3VvGDh6bd9lfgUFH+ZKp31ZgFRKC2IIm7h
         O+PvfuPntrLaL+voKbyPEJjLRl2cU4JeHkBk0gsn/51CTUWt7pjesyhpqa8cv2dkx0fH
         u8N/wx5+XuzpXtW2S9u8OSth/dvc7NyGRBWso7bkOG5EbbS8UrRyXRx4UuLEcQMTEcsW
         JgFheQ2Nca1PsbFwnrDJ3hifCwNhcVf6p3k1fkEhKzC9JZ+c/MFpTIryMU3ejA2hRNw9
         DfAPtCZDLpd2txlTiN6fRYqjgNudJjui3K1KmqsdJwKcO/R3VTTBx6yVR1qTpOr8p/Kk
         a+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8KkUzWGJNMjXwsmscPFesuut9pEMlMg+ojjJCbDTt8=;
        b=P82mt0U6oYVQqZdmlLcckeF/2WVoDORb5f36n1h0Z/O+4N0YkrsWvkoas1klLqcfyb
         zqwr5mi/b/YfQb6H8haaAevOaLLTi0nQQPJ7QvPAsdJb/S8Zz3z9pirwDboE6Gmd1MMO
         jhKFJWUwXYWJeIbe1xMgjwzzvSJjdaoBCPPDUCLfxf+LiiwxCInQ4CSP82jH3Xw7GRUE
         Gmnb2h0MxhSZ46H3UgjZoPh2aNH19Upkyy0ApW0O3+JtqgvtCozBNIuJN1DYaH9s3YGw
         Xsr6bG75thg7412MFHC36SY2MGAO94qE5B3FV6XFk0T6969/yEVgTSNzAuXVUICSkgst
         MgcQ==
X-Gm-Message-State: AOAM5314DIzqmheSqb9HK0pt+5duJQx6Zzg3lArVW9dFHLyofvl/gg2W
        1/r2gWhU5XCr97EJ64huKJqRFWdlaEchgA==
X-Google-Smtp-Source: ABdhPJy+xIhPVziCuzlXJpikdCj5qpbakRQ6yREgjuoSEsUp0NCjDvLzCQ4RbUJSRn5MYim7wOu1UA==
X-Received: by 2002:a05:6a00:1a50:b0:481:1589:78a4 with SMTP id h16-20020a056a001a5000b00481158978a4mr7872692pfv.66.1635821787543;
        Mon, 01 Nov 2021 19:56:27 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:71f5:e83:7c22:5bda])
        by smtp.gmail.com with ESMTPSA id w5sm18680171pfu.85.2021.11.01.19.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 19:56:26 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH V2] Bluetooth: vhci: Add support extended opcode for HCI Vendor packet
Date:   Mon,  1 Nov 2021 19:56:23 -0700
Message-Id: <20211102025623.826277-1-hj.tedd.an@gmail.com>
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

THis patch adds new opcode(0x03) for HCI Vendor packet for VHCI for
extended device creation. This new opcode will not conflict with
existing legacy opcode because the legacy expects to set either bit 0 or
bit 1, but not both of bits.

It aslo requires new extra parameters for device type and flags to apply
to the VHCI device.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 65 ++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 49ac884d996e..5fccab136543 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -30,6 +30,16 @@
 
 static bool amp;
 
+#define VHCI_EXT_OPCODE				0x03
+struct vhci_ext_config {
+	__u8  dev_type;
+	__u32 flags;
+} __packed;
+
+#define VHCI_FLAG_QUIRK_RAW_DEVICE		0x01
+#define VHCI_FLAG_QUIRK_EXTERNAL_CONFIG		0x02
+#define VHCI_FLAG_QUIRKS_INVALID_BDADDR		0x04
+
 struct vhci_data {
 	struct hci_dev *hdev;
 
@@ -278,7 +288,8 @@ static int vhci_setup(struct hci_dev *hdev)
 	return 0;
 }
 
-static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
+static int __vhci_create_device(struct vhci_data *data, __u8 opcode,
+				struct vhci_ext_config *ext_config)
 {
 	struct hci_dev *hdev;
 	struct sk_buff *skb;
@@ -287,8 +298,20 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (data->hdev)
 		return -EBADFD;
 
-	/* bits 0-1 are dev_type (Primary or AMP) */
-	dev_type = opcode & 0x03;
+	/* In case of legacy opcode, it doesn't allow to have 0x03 as an opcode,
+	 * So, it is ok to assume that device is in the extended device
+	 * creation mode when the opcode is 0x03. Also, it is required to have
+	 * a ext_config and check it here.
+	 */
+	if (ext_config && opcode != VHCI_EXT_OPCODE)
+		return -EINVAL;
+
+	if (opcode == VHCI_EXT_OPCODE)
+		dev_type = ext_config->dev_type;
+	else {
+		/* bits 0-1 are dev_type (Primary or AMP) */
+		dev_type = opcode & 0x03;
+	}
 
 	if (dev_type != HCI_PRIMARY && dev_type != HCI_AMP)
 		return -EINVAL;
@@ -331,6 +354,16 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (opcode & 0x80)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
+	/* Flags for extended configuration */
+	if (ext_config && opcode == VHCI_EXT_OPCODE) {
+		if (ext_config->flags & VHCI_FLAG_QUIRK_EXTERNAL_CONFIG)
+			set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
+		if (ext_config->flags & VHCI_FLAG_QUIRK_RAW_DEVICE)
+			set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+		if (ext_config->flags & VHCI_FLAG_QUIRKS_INVALID_BDADDR)
+			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
@@ -364,12 +397,13 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	return 0;
 }
 
-static int vhci_create_device(struct vhci_data *data, __u8 opcode)
+static int vhci_create_device(struct vhci_data *data, __u8 opcode,
+			      struct vhci_ext_config *ext_config)
 {
 	int err;
 
 	mutex_lock(&data->open_mutex);
-	err = __vhci_create_device(data, opcode);
+	err = __vhci_create_device(data, opcode, ext_config);
 	mutex_unlock(&data->open_mutex);
 
 	return err;
@@ -379,6 +413,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 				    struct iov_iter *from)
 {
 	size_t len = iov_iter_count(from);
+	struct vhci_ext_config *ext_config;
 	struct sk_buff *skb;
 	__u8 pkt_type, opcode;
 	int ret;
@@ -419,6 +454,21 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		opcode = *((__u8 *) skb->data);
 		skb_pull(skb, 1);
 
+		/* This opcode(0x03) is for extended device creation and it
+		 * requires the extra parameters for extra configuration.
+		 */
+		if (opcode == 0x03) {
+			if (skb->len != sizeof(*ext_config)) {
+				kfree_skb(skb);
+				return -EINVAL;
+			}
+
+			ext_config = (void *) (skb->data);
+			ret = vhci_create_device(data, opcode, ext_config);
+			kfree_skb(skb);
+			goto done;
+		}
+
 		if (skb->len > 0) {
 			kfree_skb(skb);
 			return -EINVAL;
@@ -426,7 +476,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 
 		kfree_skb(skb);
 
-		ret = vhci_create_device(data, opcode);
+		ret = vhci_create_device(data, opcode, NULL);
 		break;
 
 	default:
@@ -434,6 +484,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		return -EINVAL;
 	}
 
+done:
 	return (ret < 0) ? ret : len;
 }
 
@@ -526,7 +577,7 @@ static void vhci_open_timeout(struct work_struct *work)
 	struct vhci_data *data = container_of(work, struct vhci_data,
 					      open_timeout.work);
 
-	vhci_create_device(data, amp ? HCI_AMP : HCI_PRIMARY);
+	vhci_create_device(data, amp ? HCI_AMP : HCI_PRIMARY, NULL);
 }
 
 static int vhci_open(struct inode *inode, struct file *file)
-- 
2.25.1

