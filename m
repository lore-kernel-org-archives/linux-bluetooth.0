Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6E2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 01:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7CA60FD8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 01:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhJFBLb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 21:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhJFBLb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 21:11:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46213C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 18:09:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa4so223333pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JImQxPscmbjSSk43SXCJ7gIjxsRo4McgRKHqq5eurAw=;
        b=VAmSTECzUJTWa4qCjrb/nTcQ34L/OGjmESVCXksW5YCRcL20YmaLj+03sQ3qjJcreu
         cme2BNzPlwNWti3AjrhXO4FF/7eC/iqGwMObM4WER+zG8pIfgJ5Q8KxIswlz5zfNmm2U
         TOmT8/p/bR/nsUn0eSyDggQbGmT+7igmS8oFlmBAPpBPQh2uiO0F/s/0MtYtxjgYWgEw
         Wqup9l1qWcSdK2IinImhUtL7zt+qS7zPGa4tYOHjlJFAThOv2uPdmYtB5A5v5F/tuekv
         mSeuEJWzsGzqVWWab6UE8MlMI5kDPE3Qu9UNLZfjc6uwbfzJrfnjz4sRV+L2tZ2wcyRv
         f72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JImQxPscmbjSSk43SXCJ7gIjxsRo4McgRKHqq5eurAw=;
        b=ytui3y/KH12BunnKRDjmXxXiCFvkn6xNZWehQWg65uv+IpX2WifREOOLPNoxazGKtB
         Ai9DvhY3n7if+N/WnC7tc68Eltt+O0K3OCbnTWHhr+9dK8IA52SxfG5mQ4yVaniKf0SD
         xm+uLU/ygpVakSWRvGVGflLYj7n/hWduHbflUQDW8BH6thkXjDjaPXLGyFl0tJmn8aUK
         98VkU4tIGPxpH3h1XhGowCULiktaSxiaPscErRk9Ki8pTg8mebkG7oKDUBK7QX6dZpti
         Vr6Jx4bXJ3PDedbLlWvvqmdQT03E/1ERg2DbDj8gIC9v9KxjfRZBZ1lg6w7g77zIzGC5
         9vLA==
X-Gm-Message-State: AOAM5311/m2iwit1l16TQC1XDxrdbgMYmqLMVhglA4Kt3+Vd3N2rFlZ1
        UEGkvufdI4Br2Sk4A+0JR9vSkQz8AvA=
X-Google-Smtp-Source: ABdhPJx7z2nPb18FL+TEnncoyzwo7erOxF6iM2rMprS+0H21YFFA4nSstKIVg1m5FTlLFNYhrcQ4DA==
X-Received: by 2002:a17:903:124f:b0:13e:25e6:f733 with SMTP id u15-20020a170903124f00b0013e25e6f733mr8113091plh.42.1633482579396;
        Tue, 05 Oct 2021 18:09:39 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id nr14sm3158988pjb.24.2021.10.05.18.09.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:09:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: hci_vhci: Fix calling hci_{suspend,resume}_dev
Date:   Tue,  5 Oct 2021 18:09:33 -0700
Message-Id: <20211006010935.902645-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Defer calls to hci_{suspend,resume}_dev to work so it doesn't block the
processing of the events.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 5fd91106e853..56c6b22be10b 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -38,6 +38,7 @@ struct vhci_data {
 
 	struct mutex open_mutex;
 	struct delayed_work open_timeout;
+	struct work_struct suspend_work;
 
 	bool suspended;
 	bool wakeup;
@@ -114,6 +115,17 @@ static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
 }
 
+static void vhci_suspend_work(struct work_struct *work)
+{
+	struct vhci_data *data = container_of(work, struct vhci_data,
+					      suspend_work);
+
+	if (data->suspended)
+		hci_suspend_dev(data->hdev);
+	else
+		hci_resume_dev(data->hdev);
+}
+
 static ssize_t force_suspend_write(struct file *file,
 				   const char __user *user_buf,
 				   size_t count, loff_t *ppos)
@@ -129,16 +141,10 @@ static ssize_t force_suspend_write(struct file *file,
 	if (data->suspended == enable)
 		return -EALREADY;
 
-	if (enable)
-		err = hci_suspend_dev(data->hdev);
-	else
-		err = hci_resume_dev(data->hdev);
-
-	if (err)
-		return err;
-
 	data->suspended = enable;
 
+	schedule_work(&data->suspend_work);
+
 	return count;
 }
 
@@ -442,6 +448,7 @@ static int vhci_open(struct inode *inode, struct file *file)
 
 	mutex_init(&data->open_mutex);
 	INIT_DELAYED_WORK(&data->open_timeout, vhci_open_timeout);
+	INIT_WORK(&data->suspend_work, vhci_suspend_work);
 
 	file->private_data = data;
 	nonseekable_open(inode, file);
@@ -457,6 +464,7 @@ static int vhci_release(struct inode *inode, struct file *file)
 	struct hci_dev *hdev;
 
 	cancel_delayed_work_sync(&data->open_timeout);
+	flush_work(&data->suspend_work);
 
 	hdev = data->hdev;
 
-- 
2.31.1

