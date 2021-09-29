Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6217C61247
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 20:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbhI2Uko (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbhI2Ukm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 16:40:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85908C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 13:39:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e7so3950820pgk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hDPV5Ooll8rbILKiuvzU7+Hf6B2wSI+z5ANjZ1JDwo=;
        b=OtHR+Pb7/7F1bH+ewRbk6ZRWVJEqi2ZUDOp1VZRNmp97LwsdZZCJtMDr4GNTotsQuk
         xut1m0uumHG8EMhyhQgUbzCahY1Q+QUEyNY58UwPJQthiXvoIT6fvnAMEuS4Pk7cZLCR
         dMlp0qMu63jhZaZ30w9Y2AnnHw6kn/MbmOX4kYc5NGjykMF6kYwkd3ihqaJgzbMIOfna
         KwJ/45uHmn6sD0rEPzXKB60Zj1xhqqqj03fuPaoByZWFqRc00pcWD6BO2jRmyTb7t4lC
         OksIT4DUKvPPvEKapQdw7idq/GmccraLXwRUVUn/N4YPH2hfxg3SUw5Zk+ptS1B/7JwT
         IQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hDPV5Ooll8rbILKiuvzU7+Hf6B2wSI+z5ANjZ1JDwo=;
        b=sgq3/2vDHtB5JgId3wzVnHuReVF68l4lsOCgRm6vFvLlNeiQHQCOYpBPODu1PP13XV
         1huJcjE/pLkFM3hK2DqOqwdWgse9CMqaogTcQzLar3mVMBJqitXiOBALF5vpS2MQinou
         QwwxyTTyUAcZjoAOKCU9T6vpl8++JbLazbNX2ikyxMC/azycRhXpbBQi/N5V5ngXJNrn
         ibgLKLdki6u6eFj00Blr+r3GmHq1F+EJ0M868xXLuiXI9wch6Ccn/MZCXmXyZI7FwgOh
         YEy3NEW6CcWzf5pXG9IpPjY/rMfiXL15TBi3/AqKWRsUzBSMsconU593DNEVWVddBpsI
         PVjg==
X-Gm-Message-State: AOAM532QhEz6qD8zQUIBaCDAU1p3vRjj5c9wcbIPmpNpYXx5y6fOhwzp
        3wQcs2tYE410Les+n85p8+4ESCHjJP0=
X-Google-Smtp-Source: ABdhPJxQbrqHtqd5u494+1CsY9lHm5aNZpkbV7o/zoWZ7zM+DUA2WSJgTnVKzQA/jXD3310q73IN0g==
X-Received: by 2002:a05:6a00:4:b0:440:6476:bcb4 with SMTP id h4-20020a056a00000400b004406476bcb4mr1756820pfk.0.1632947938936;
        Wed, 29 Sep 2021 13:38:58 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3sm481415pju.33.2021.09.29.13.38.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 13:38:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_vhci: Add force_suspend entry
Date:   Wed, 29 Sep 2021 13:38:54 -0700
Message-Id: <20210929203855.3290899-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds force_suspend which can be used to force the controller into
suspend/resume state.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index cc3679f3491d..6cc326c55a24 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -21,6 +21,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/miscdevice.h>
+#include <linux/debugfs.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -37,6 +38,8 @@ struct vhci_data {
 
 	struct mutex open_mutex;
 	struct delayed_work open_timeout;
+
+	bool suspended;
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -91,6 +94,53 @@ static int vhci_get_codec_config_data(struct hci_dev *hdev, __u8 type,
 	return 0;
 }
 
+static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	struct vhci_data *data = file->private_data;
+	char buf[3];
+
+	buf[0] = data->suspended ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_suspend_write(struct file *file,
+				   const char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct vhci_data *data = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (data->suspended == enable)
+		return -EALREADY;
+
+	if (enable)
+		err = hci_suspend_dev(data->hdev);
+	else
+		err = hci_resume_dev(data->hdev);
+
+	if (err)
+		return err;
+
+	data->suspended = enable;
+
+	return count;
+}
+
+static const struct file_operations force_suspend_fops = {
+	.open		= simple_open,
+	.read		= force_suspend_read,
+	.write		= force_suspend_write,
+	.llseek		= default_llseek,
+};
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -149,6 +199,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		return -EBUSY;
 	}
 
+	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
+			    &force_suspend_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.31.1

