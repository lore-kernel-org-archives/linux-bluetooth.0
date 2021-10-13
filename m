Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E612D60F21
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhJMAdG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhJMAdE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 20:33:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495FC06174E
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 17:31:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w14so649976pll.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 17:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0+E1AGudb1w+bAlldCshhuhzoFxZiJC+ny9qr/1FI2Y=;
        b=dkAmzhpPca1GRfIvyX7dPhBTXjIUEPNTQ89ff/OYs5wlfY0wSSOA1MVK/meQvgCrRK
         qbYc/B6o5LxsR4bge6UXQ/muTFQow10cEd0qApiGezU7ltRCsfUaA/lpbrSUv3L+ykEu
         Iz/H4HSkuVPzL7SpH3ChjL3viEV+XT004q63WNHGWA9fcGG8WJz+CIr3/Mymw2fwGJ9z
         LafTH4z5KRvL/mLS/THy1krJnTmypMWfmU3TgkipjN/Bl/mBv1CJzb1/tgUDg+F8piyh
         2BdmLtzmipSaE6eQfcfgXrwo0+03olP1IP1dVLQC3WEUExqiv7tlRF40nvaI9l80cuUS
         AF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+E1AGudb1w+bAlldCshhuhzoFxZiJC+ny9qr/1FI2Y=;
        b=jQi0irlvBQG26hmr22BGsW/64qdwsyCjftTcVvyrV+8bVAHj0zevvA8+RPvPeizcE3
         AwPOO12qoRzS7cz8eFyr9dZEpmHNBM2QunI6N+J+/vsT+Drdb+4JUHLdasnPKATM6R/L
         tnedku4GXw8JMJDtIn6laUEQUp/HrkxwLaxehhUnyVij1oNYs8M9ozsKRL8ykgWtRR+Q
         A0xj3KZT7Hcqige7pa0pLC55z7cKeCFpAZmvCa8MyjS4ZzqyWhGq+g88RZSS/TqmlN1W
         oebWlfUMj4fbaraWACoeunlLF4yL2LwSf7eU55rfvNlmwO6JMrLm+9M7fXbvhlR1SA5+
         kyzA==
X-Gm-Message-State: AOAM531hsvBxgHBGJ/9bHQiwgOOSDMaAbPcswj3aRKKGnFtoexaJNC2H
        QEPZUVCCUkx0ArLVimNlZsQQq6Z75pA=
X-Google-Smtp-Source: ABdhPJy5mG7BcTycACNVCVQkfNQv2evuA3fxchb7JfxZj45a0aeheViS/IIo2BfQ2TwjPt+uJ+Maew==
X-Received: by 2002:a17:90b:4014:: with SMTP id ie20mr4399659pjb.146.1634085060406;
        Tue, 12 Oct 2021 17:31:00 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s2sm11839996pfe.215.2021.10.12.17.30.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:31:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: vhci: Add support for setting aosp_capable
Date:   Tue, 12 Oct 2021 17:30:55 -0700
Message-Id: <20211013003055.2664728-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013003055.2664728-1-luiz.dentz@gmail.com>
References: <20211013003055.2664728-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a debugfs entry to set aosp_capable enabling vhci to emulate
controllers with AOSP extension support.

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

