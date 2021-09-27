Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA5EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F51660FD7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhI0UHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbhI0UHw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:07:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468AEC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:06:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w11so12521465plz.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HTSQIonYKgAwfCIStg/nIK5VaCcXB4lw6smzHJZ9Wi0=;
        b=k27iMtmEDEGzcg9FRYlmxsO9nV3eZzwbZdlhDj022kjOOOnHVCE5kC+44Lv848C6bC
         gkb0Mj5WC4/kcObjs6e+ZOsLfhveYDECkXDTy4FREeAHKjLK4dAf2F8z47/PIww7v3CS
         DtzrHkP9WFqwxJ+r2k3UN+c1gRN1TJwVnCVngcWGE4Hb3q89GmyHHz66N/8RzbdjcdLk
         +WOyY2zZafuWOZFPaYTvW6zlNiK+54/4UURXQ7FL8J7lWA2MALdi53OG5FaDCpBXHUuK
         CGqyid9zO5G7CQY/IVvgHYkifEW9sTQD96DcYsgpOORUjU+rBsp/Zrq94wGj2UAdxlpf
         py8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTSQIonYKgAwfCIStg/nIK5VaCcXB4lw6smzHJZ9Wi0=;
        b=IzPd3xnYGXICR4t7Ff5Yb6asq0d5hRsKtM6RCa9/VkCcLZ3Mxxic0vTqcseien5LPv
         9yoW5iawC6FvenpOOPNNBhMoBDZNHGzC16zoNKEoT7Cbcfp0VqjUHrNWzzZyxDhYYhir
         39cAqd77GGfQv0Py8/ou0MdBKHGQ6FumPVK7uLB1pY2/yMs9x3uF1CPsHKSb5RGDnVcn
         Ds2qRC0mtLzqqVg/JJGNpHGO49cODeDVGNZUrVGbMCKm0btxmfc6uP82ShP3o8BK7MAE
         JJxNEqVGNb48tnQOnWKI2/ItxODknM1pxpgjhDPWxZcVwsGfG88GDszpcFvlHTRz2p2M
         Z3Zw==
X-Gm-Message-State: AOAM531d8Ba3ryvFpvUJvJ1OW6JSTk8lbSnCWMVqoUAQ8FeetSYODH6E
        55YykP+XP7pF930Lmjduw5TzyZmz46Y=
X-Google-Smtp-Source: ABdhPJyfL+VjQ4k5icLcB9SdmaWFeII0EX1U5YolS5OwdI5w4dqTijiAfJfjmpt85E4GEpdLaxLZtA==
X-Received: by 2002:a17:90b:1e09:: with SMTP id pg9mr998410pjb.73.1632773173541;
        Mon, 27 Sep 2021 13:06:13 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y5sm17742830pfb.207.2021.09.27.13.06.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:06:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: debugfs: Add force_suspend entry
Date:   Mon, 27 Sep 2021 13:06:10 -0700
Message-Id: <20210927200611.2722757-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927200611.2722757-1-luiz.dentz@gmail.com>
References: <20210927200611.2722757-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_debugfs.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 902b40a90b91..53b39cc73cd7 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -305,6 +305,51 @@ static const struct file_operations sc_only_mode_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hdev->suspended ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_suspend_write(struct file *file,
+				   const char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (hdev->suspended == enable)
+		return -EALREADY;
+
+	if (enable)
+		err = hci_suspend_dev(hdev);
+	else
+		err = hci_resume_dev(hdev);
+
+	if (err)
+		return err;
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
 DEFINE_INFO_ATTRIBUTE(hardware_info, hw_info);
 DEFINE_INFO_ATTRIBUTE(firmware_info, fw_info);
 
@@ -336,6 +381,9 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	debugfs_create_file("conn_info_max_age", 0644, hdev->debugfs, hdev,
 			    &conn_info_max_age_fops);
 
+	debugfs_create_file("force_suspend", 0644, hdev->debugfs, hdev,
+			    &force_suspend_fops);
+
 	if (lmp_ssp_capable(hdev) || lmp_le_capable(hdev))
 		debugfs_create_file("use_debug_keys", 0444, hdev->debugfs,
 				    hdev, &use_debug_keys_fops);
-- 
2.31.1

