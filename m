Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C663C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255FA61206
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbhI1Vij (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhI1Vii (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 17:38:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F880C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:36:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s16so187010pfk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Fpd125Fp3aw0OcEBLjwQau/IVlYDW1wDNutvI1kdhkQ=;
        b=OVZkq4mwmUywUb1vC1Ry3lQASyysa8TWPMyns7VZK3SqmxVoRAUwqvt7Bb7mDelTfy
         hGux+0ro/KwRPz9pipEs4wFq+V6rvcmAfOXOQxXATHj9HEEYjRoPJbe7nMnubEG2j5om
         z1Iy/qlnxjiIkU44oBEJ5/3brVQeHiKrNDFowuqUtGTZll/QA7EE7OnVUA70OjYUt9v/
         6W0/3JON3xHuQ3Kl9OfixAU+zGu2VSQ+ynB6K//APytC4cVsSQ66KrhwXKwCraaOR3VH
         pFrCDWCHquOori+86nyDPclWMFgrHsx5I6b6NM/Ehu8haHe2PlQsUx4Y8BvkE7M3YHAA
         nS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fpd125Fp3aw0OcEBLjwQau/IVlYDW1wDNutvI1kdhkQ=;
        b=ZTn7OycyW1RTFNnX3iew/bpFrHUcny5QH37K91TqQwAmDDOz3HEaGrGhNPM8UdA9Uo
         91enTX3AgJwq3i5LDksKKB7hM1AiYeJ0Zi0CYbtRK9YLZc1CfkEnF226V0Nh4MhbpUO4
         bYV3CKJHCyfK3DWPSGYyaVaHD3f1tiCURKtkpp0sd5attBdWrqovUrr8J0+CJ9bDJokj
         gKhBy1nFiRfeTzfeXEInkYNsGbizsogUBHEviulsgIizmwPPGcditjU+K18On4XgmO2s
         kYVphBsuN7iG/HzL2vP9NnJ6mndZcrrHnlW7+cTphs5ZUWooMyzf3PttGB1U9+CSDWmS
         WYvw==
X-Gm-Message-State: AOAM531QyHQYiw9yHeEi/HNddoBHCSYVU+hMxwmHcdMvHlExBBbr2h3V
        Bh+5hiHsr/72SDM9MGBua1HMVtY58EU=
X-Google-Smtp-Source: ABdhPJx7PejY0X48ctb3R7rlMhwNvBpdaxUnQ7T5Gk2+E2YYwkLIu6Law+2GEuOq9cjOozM50SQGiA==
X-Received: by 2002:a05:6a00:c3:b0:43d:e6be:b2a6 with SMTP id e3-20020a056a0000c300b0043de6beb2a6mr7511715pfj.34.1632865018249;
        Tue, 28 Sep 2021 14:36:58 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ml21sm2053862pjb.55.2021.09.28.14.36.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:36:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: hci_vhci: Add force_suspend entry
Date:   Tue, 28 Sep 2021 14:36:52 -0700
Message-Id: <20210928213653.3028439-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928213653.3028439-1-luiz.dentz@gmail.com>
References: <20210928213653.3028439-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/hci_vhci.c | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index cc3679f3491d..52f9106faeae 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -21,6 +21,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/miscdevice.h>
+#include <linux/debugfs.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -91,6 +92,51 @@ static int vhci_get_codec_config_data(struct hci_dev *hdev, __u8 type,
 	return 0;
 }
 
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
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -149,6 +195,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		return -EBUSY;
 	}
 
+	debugfs_create_file("force_suspend", 0644, hdev->debugfs, hdev,
+			    &force_suspend_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.31.1

