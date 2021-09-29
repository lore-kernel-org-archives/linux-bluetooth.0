Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF06EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15316124C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 20:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346744AbhI2Ukm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbhI2Ukl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 16:40:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF31C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 13:39:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u7so2945262pfg.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U2rqGx4no0ZHGLYxCYhgHD7MjQh/BYq/hVset+XzC9E=;
        b=dy7c5HLkGA/8KXEPsBjm2H5wIxAYFLhC5fTJcADY5mAVrmZTrhNpuUI+0H1ujtcpoq
         AWrmqygSjitsKVyhrOBegmM1iz0n/oCG/WhsfmnGX4ItWKr6ORnlFrkemXPIIJ3K1uZH
         UsvNZr6lYdUsNyqtyUWBvOJkYEtKGW2UDGO0SjvJApgzDaKwnLUTILRqYoAZy2sDf2Xv
         o83LJB2OVQA9tjXTkX8vSPgZx67b1sVyPo1aVS4W7ApXt8svAc2emRp/uuA6Cwiy4oCc
         UN9wRVttsfATuaOHvubMJG4BWvmciEGcieLBBjvUTYrzdC3iyWleodVjGnwMTcE2ONVA
         hJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2rqGx4no0ZHGLYxCYhgHD7MjQh/BYq/hVset+XzC9E=;
        b=2zlxIOibAB7OkqIcpXgJZVIs108F0ogDznKZHJIQ+RBCi6OOJJErcA4M6Mh9nin1sY
         AOwr7saeQclsFRjy0procAEco7DDEPow/E0qj6+NWtXroO2IDwLMqlRxto22bXJ4u4dS
         e+olY/6HAjWp68IGGnxhjoc22ieWK0JS5F9+5Z64bHh0AjjDlgrCyRDrdBYOmNUH6bQT
         +JyeOzhH9dXMiU7bP1xDPW/wGcHC/tsAeIMPQX2S4bMveCFQCsSX3AI1s9Hu+Az1kr+f
         vMHOHpezeaZ9sJ06upQCO3UeDBHFpCo91ewk+bFi9o+36mzYloOEcSLq1NeXsVfOuKO+
         S0og==
X-Gm-Message-State: AOAM5300mOkaMuZgpT++umx2s7FZ9megfDwgipKjUJ9tKqxVM7FRzpTF
        2hlWWf60CoyRCZjxSx4EId1r6cDEkRA=
X-Google-Smtp-Source: ABdhPJztORllJTLPmjA4ELS6CH//FMbjuoOz64blBljhcU8LDAbjUO5t7j5bCcM1+Cu7yaiiaArZDA==
X-Received: by 2002:a63:4303:: with SMTP id q3mr1569475pga.375.1632947939480;
        Wed, 29 Sep 2021 13:38:59 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3sm481415pju.33.2021.09.29.13.38.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 13:38:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_vhci: Add force_prevent_wake entry
Date:   Wed, 29 Sep 2021 13:38:55 -0700
Message-Id: <20210929203855.3290899-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929203855.3290899-1-luiz.dentz@gmail.com>
References: <20210929203855.3290899-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds force_prevent_wake which can be used to force a certain state
while interacting with force_suspend.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 6cc326c55a24..acf2544dbb05 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -40,6 +40,7 @@ struct vhci_data {
 	struct delayed_work open_timeout;
 
 	bool suspended;
+	bool prevent_wake;
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -94,6 +95,13 @@ static int vhci_get_codec_config_data(struct hci_dev *hdev, __u8 type,
 	return 0;
 }
 
+static bool vhci_prevent_wake(struct hci_dev *hdev)
+{
+	struct vhci_data *data = hci_get_drvdata(hdev);
+
+	return data->prevent_wake;
+}
+
 static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
 				  size_t count, loff_t *ppos)
 {
@@ -141,6 +149,43 @@ static const struct file_operations force_suspend_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t force_prevent_wake_read(struct file *file, char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct vhci_data *data = file->private_data;
+	char buf[3];
+
+	buf[0] = data->prevent_wake ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_prevent_wake_write(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct vhci_data *data = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (data->prevent_wake == enable)
+		return -EALREADY;
+
+	return count;
+}
+
+static const struct file_operations force_prevent_wake_fops = {
+	.open		= simple_open,
+	.read		= force_prevent_wake_read,
+	.write		= force_prevent_wake_write,
+	.llseek		= default_llseek,
+};
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -182,6 +227,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->send  = vhci_send_frame;
 	hdev->get_data_path_id = vhci_get_data_path_id;
 	hdev->get_codec_config_data = vhci_get_codec_config_data;
+	hdev->prevent_wake = vhci_prevent_wake;
 
 	/* bit 6 is for external configuration */
 	if (opcode & 0x40)
@@ -202,6 +248,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
 			    &force_suspend_fops);
 
+	debugfs_create_file("force_prevent_wake", 0644, hdev->debugfs, data,
+			    &force_prevent_wake_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.31.1

