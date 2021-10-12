Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979E1610CB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhJLVeF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhJLVeE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 17:34:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE17C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:32:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g14so658663pfm.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N85Luid2qeIUg6fxxCG72uIkC4VmAh6TIO/1nL0PZJc=;
        b=Z6jZPxJxKytMXbR+LPHezqvIkvnQQpf8sng8N6i3eex4g9/YaKiHcHl9zKQ0F9P33K
         +w9oGv51QXe5bGxH4cATgC/DFEMqYH44k+UaqztUshJjl4WBxiNHNrjFApKksla1tuIF
         vohp/lbUd9yBI07Bt1J3Pssgj5r6yeGHrT61u6DQhrrho5OysgMrcTbJSKyIy63DvfU+
         2splsdiGShXtwfrdnaaeGoqCK/L1JMGjFd8BiNT0vVLeulPH0zsMrAAPjp7muS31BLWm
         nzgwcmhJEGqZ0zg+sectz4Kx9ANOpW5A8o9gS391DoFNuVxyrRLwPjZJ3K+HJI8VQzyJ
         inAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N85Luid2qeIUg6fxxCG72uIkC4VmAh6TIO/1nL0PZJc=;
        b=uks06Mhk5QUeq29ZMBlxGj8C03qVOlXrzJ70DNo/4QrtwkrtxQxrcoWGZrj+Fqf8n5
         gpfbfvKSdMGWVg5f8uKI7PQUCw7WzEsrLpgdCMKUD7FFDGNumeZF9zutlLyjDi950PTr
         zvGlZh6KZKZ9lPhfxat3asJXof+nZKGAPE9zvzBq3/gQN4XZ+A2+QBIXV+/qIi77ezki
         lCIypyx0SOnfZpkUx9vLviRZkgG8g4yBMVZuBKh4Ebd6nITdBQsOv+U64QM2uss8pUSI
         yqegBO3VCuR410rQYSPiByiduS6JatqBGPLiJW11eEPCfCqb26XWUNfJa5jenSTBBjTe
         km/A==
X-Gm-Message-State: AOAM532k+/a2sS56Sg06M2hw7edg0xkLKy+75nPs7tBcUNNK+2PMJPBy
        7YK9SP+LifhV9gJqhaaR32TN5yCOyPc=
X-Google-Smtp-Source: ABdhPJyR7lyXl3P8+AMAJcqYMgwzalNznN4eXkiOi23KU2KXh2ezh/txFl1KSL5ATdmMUPPrwNG8qA==
X-Received: by 2002:aa7:94a8:0:b0:44c:f3e0:81fb with SMTP id a8-20020aa794a8000000b0044cf3e081fbmr21209632pfl.6.1634074321339;
        Tue, 12 Oct 2021 14:32:01 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id on17sm3940900pjb.47.2021.10.12.14.32.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 14:32:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: vhci: Add support for setting aosp_capable
Date:   Tue, 12 Oct 2021 14:31:58 -0700
Message-Id: <20211012213158.2635219-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012213158.2635219-1-luiz.dentz@gmail.com>
References: <20211012213158.2635219-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a debugfs entry to set aosp_capable enabling vhci to emulate
controllers with AOSP extention support.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 68 +++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 68a970db8db1..f9aa3fe14995 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -45,6 +45,9 @@ struct vhci_data {
 #if IS_ENABLED(CONFIG_BT_MSFTEXT)
 	__u16 msft_opcode;
 #endif
+#if IS_ENABLED(CONFIG_BT_AOSPEXT)
+	__u16 aosp_capable;
+#endif
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -223,18 +226,68 @@ static int msft_opcode_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(msft_opcode_fops, msft_opcode_get, msft_opcode_set,
 			 "%llu\n");
 
+#endif /* CONFIG_BT_MSFTEXT */
+
+#if IS_ENABLED(CONFIG_BT_AOSPEXT)
+
+static ssize_t aosp_capable_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct vhci_data *vhci = file->private_data;
+	char buf[3];
+
+	buf[0] = vhci->aosp_capable ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t aosp_capable_write(struct file *file,
+				  const char __user *user_buf, size_t count,
+				  loff_t *ppos)
+{
+	struct vhci_data *vhci = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (vhci->aosp_capable == enable)
+		return -EALREADY;
+
+	vhci->aosp_capable = enable;
+
+	return count;
+}
+
+static const struct file_operations aosp_capable_fops = {
+	.open		= simple_open,
+	.read		= aosp_capable_read,
+	.write		= aosp_capable_write,
+	.llseek		= default_llseek,
+};
+
+#endif /* CONFIG_BT_AOSEXT */
+
 static int vhci_setup(struct hci_dev *hdev)
 {
 	struct vhci_data *vhci = hci_get_drvdata(hdev);
 
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
 	if (vhci->msft_opcode)
 		hci_set_msft_opcode(hdev, vhci->msft_opcode);
+#endif
+
+#if IS_ENABLED(CONFIG_BT_AOSPEXT)
+	if (vhci->aosp_capable)
+		hci_set_aosp_capable(hdev);
+#endif
 
 	return 0;
 }
 
-#endif /* CONFIG_BT_MSFTEXT */
-
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -278,8 +331,10 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->get_codec_config_data = vhci_get_codec_config_data;
 	hdev->wakeup = vhci_wakeup;
 
-	/* Enable custom setup if CONFIG_BT_MSFTEXT is selected */
-#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+	/* Enable custom setup if CONFIG_BT_MSFTEXT or CONFIG_BT_AOSPEXT is
+	 * selected.
+	 */
+#if IS_ENABLED(CONFIG_BT_MSFTEXT) || IS_ENABLED(CONFIG_BT_AOSPEXT)
 	hdev->setup = vhci_setup;
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 #endif
@@ -311,6 +366,11 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 			    &msft_opcode_fops);
 #endif
 
+#if IS_ENABLED(CONFIG_BT_AOSPEXT)
+	debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
+			    &aosp_capable_fops);
+#endif
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.31.1

