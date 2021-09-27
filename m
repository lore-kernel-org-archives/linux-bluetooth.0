Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD16C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6328960FC0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhI0UHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbhI0UHx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:07:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCA5C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:06:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j14so12570645plx.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7ImZumJaqGLk7DRVutrzYmU3lQu2ao/l717eoSbhgSU=;
        b=g92WVdfQuECTOqaywhPyz5RKqOSVx1dBxailPvAA799YSGe6/eTU7x33/EeW/W6J4S
         w9lew/++rMrYMni0hNMuHEltoaDtVXQ0jD3Dq6kCvD7h9cDeNVwB06ro/Q7ZlXKX6jih
         Ffw56aI4JTjt2oXcd8Cc4ArIzXkKzp0rzMCkQx7IP3laYfDmabyB7Z65fo3C29WgKdXp
         Bc3Id0WvC4vFDHSHSPDQTsbN06aPTot/tx9ic98c6qtC2APAGcQlke11oQo4R7Frb1jh
         /RNVAz2AxIQjRjFLx4kqfOAxvH4RqMKEjn0TNTmnggOrFjs1b6zURe0lKv6VS+G9bm8x
         ekCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ImZumJaqGLk7DRVutrzYmU3lQu2ao/l717eoSbhgSU=;
        b=utsAfQwd1//nYqiwAzjsZMZA4IZxTERZP/2gxCIwU9G5ANMMXhz1WeL6EujX1yTdCU
         hel5M4Mp4wyknlEp7JRChW/Rgr4aUY4R3xt+P9VRWN6RYfRE4UIlV3YJN5MjqQ+SCO1k
         6YAVty8g9PU/6cBFbXJwKU9NbNBSVgSsPuMEwbfbAQyw0KrgelmA0mNA1BtsVxODnIkj
         6T9yC3xii+x00zOl9i8SSEubHHqAcweN0unieE4MHXiGIPRtKmeDg0A1oxqamv8tUBxk
         IjkiLZYX2TtIoQuvJhlp+7kywICLExDGSbZ/LFmonRGAhdQ1CEr+s4CYH1aizins0QN6
         HabQ==
X-Gm-Message-State: AOAM533OE55poZf0ujeHNN7hDKJIFV+oYRdTTHHZXse8uv5+4/GhDxJJ
        H7U3EnoGI+MoxsIHePSwRkCkTRpVfFc=
X-Google-Smtp-Source: ABdhPJwlnik7PQG3XuJGVuWuGNl3YvehR1AEnHK6MCTWdMNsfdq4muvDtTLl+HGvZUPDmEiOvgKOwA==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr1028644pjb.52.1632773174269;
        Mon, 27 Sep 2021 13:06:14 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y5sm17742830pfb.207.2021.09.27.13.06.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:06:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: debugfs: Add force_prevent_wake entry
Date:   Mon, 27 Sep 2021 13:06:11 -0700
Message-Id: <20210927200611.2722757-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927200611.2722757-1-luiz.dentz@gmail.com>
References: <20210927200611.2722757-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds force_prevent_wake which can be used to force a certain state
while interacting with force_suspend, the entry is only created for
hdev which has not set prevent_wake callback (e.g. vhci).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_debugfs.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 53b39cc73cd7..0121022a7398 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -350,6 +350,51 @@ static const struct file_operations force_suspend_fops = {
 	.llseek		= default_llseek,
 };
 
+static bool prevent_wake;
+
+static ssize_t force_prevent_wake_read(struct file *file, char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	char buf[3];
+
+	buf[0] = prevent_wake ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static bool hci_debugfs_prevent_wake(struct hci_dev *hdev)
+{
+	return prevent_wake;
+}
+
+static ssize_t force_prevent_wake_write(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (prevent_wake == enable)
+		return -EALREADY;
+
+	hdev->prevent_wake = hci_debugfs_prevent_wake;
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
 DEFINE_INFO_ATTRIBUTE(hardware_info, hw_info);
 DEFINE_INFO_ATTRIBUTE(firmware_info, fw_info);
 
-- 
2.31.1

