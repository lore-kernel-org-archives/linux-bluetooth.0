Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E95C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26540611CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbhI1Vik (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhI1Vij (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 17:38:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F35C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:37:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 133so488033pgb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X5UvtBIEd/KLYSlijNmdwPM9ku2ECn9PfyFZL2jvL0U=;
        b=hHkPJSNaxSFkhJYF3654XdoIjSFM3F36T/t47P6eRuFKcPXz5V1BZZoUVcCeGaGunD
         CgtwFgAXDaZYgD7YWnvcgBPitLd6teBs3CFzUN+CD2N786h9TgyWwPATxyFuF4hD+bzr
         YMlxCpvkMki49E52YYqlGRDFZ1kVmNm2309aCBONTD44Tas3rKIEVzxafHckvrbopvve
         8+A/CkWKCLFa49RlaJkJTZzRL3qnfPWOSKaI1yHvjBDJb7CeeQxk/0x0IRI5izw6BTGp
         sHgmWYF9O7I59guBLYoronJtwVR2eMN3c06UkmGFGzZx/hXuBX7BVazbs4TeXTDcCSxi
         9auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5UvtBIEd/KLYSlijNmdwPM9ku2ECn9PfyFZL2jvL0U=;
        b=yfSLcMMnhO6g9tdSywtXER19AkMUf5zcb89YHr2/0iDdRIVhzAkj5CgK8uE0FlycX8
         GD7OIR7zFEPYmR1p0ZZ1b3jCxNYsx6xvrg8ZPUT9mZFRdfvYyWOrxOFD8C8smbyRHYFK
         gKeFzmA6kL9loOx+yt8+E//zA6AuTmg0KfUAswenTUA/nTDi1NUO7wPTaQhBchnPDQg/
         iqld3SlE2naXlOqE0+7ZIz3EGH28o43iRgJC8x+I5iP8xnobe6ocuVDvyh5mc8OfRQVN
         1E5gfItgFjZTM4vlqEqD3RKgLHpXUg8W32vYzCLDBaOqqJTV+DJR8XvQYkhBHKc9OMQE
         b6yw==
X-Gm-Message-State: AOAM531VWDbfQMnKagiIUgajsoQ6POnTHO4OrlWBcFxADOazW9eU+NJm
        JVh4bPgMYA9fhEeXDkdFl8p5ouENM98=
X-Google-Smtp-Source: ABdhPJwPIkJ59SQt8VNEaokVG2Peqylvn1B0PGbZaKQAfhmwl6R8pxJkCUabXt6YCARV+JTeab/0VQ==
X-Received: by 2002:a63:348c:: with SMTP id b134mr6453256pga.243.1632865019319;
        Tue, 28 Sep 2021 14:36:59 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ml21sm2053862pjb.55.2021.09.28.14.36.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:36:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: hci_vhci: Add force_prevent_wake entry
Date:   Tue, 28 Sep 2021 14:36:53 -0700
Message-Id: <20210928213653.3028439-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928213653.3028439-1-luiz.dentz@gmail.com>
References: <20210928213653.3028439-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/hci_vhci.c | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 52f9106faeae..60a408a49828 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -137,6 +137,51 @@ static const struct file_operations force_suspend_fops = {
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
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -198,6 +243,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	debugfs_create_file("force_suspend", 0644, hdev->debugfs, hdev,
 			    &force_suspend_fops);
 
+	debugfs_create_file("force_prevent_wake", 0644, hdev->debugfs, hdev,
+			    &force_prevent_wake_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.31.1

