Return-Path: <SRS0=ukjF=ZX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F00C432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 21:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5DD20865
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 21:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ice9-us.20150623.gappssmtp.com header.i=@ice9-us.20150623.gappssmtp.com header.b="UP4+bMER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLAV6p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Dec 2019 16:58:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35561 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLAV6p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Dec 2019 16:58:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so641713pfo.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Dec 2019 13:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ice9-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3CJfkTTxFHlb+JkB8ZdpjP3zB3i9I2B9suW22v+06qQ=;
        b=UP4+bMERkFdvcxWKWq6sETns6vqy6BUaMJeYzzQnHLG8PwYcj6ZDRzcCY0KQ0jnJ/T
         wlnSZxcysorkdl1c+crfCDWBcNO1T90CdJtlSHqVPdX+mMKeF+ab0AKnjbKsTzcZ43yN
         nJT1CyxfLdIjU6QyNR7eBcrkKh9mFNHifA1h2IgdJVNY1xsfLrfBz5nHY2vG6ckEMzxO
         ABNNTKIU0mZ2qO/z5LCjACnHbCWSnHGdd8IWqopGVrgHJ6arlkA551tT+JcjnLgELcUk
         JLt6vrzGfHlsyH361Fh08u/wGLe6FBifglGc6JDuKa9YCQJwyAbyr74WY4pavRmZeMRs
         yNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3CJfkTTxFHlb+JkB8ZdpjP3zB3i9I2B9suW22v+06qQ=;
        b=Q19lBGG/qyV7iFjEkO73WWbuzBby6wZndyAIsfWw0Fld5RmrzYVzjDQ+E76LXn9VOR
         BiQcTI56CMfB7y5RS30FUp9Pwd6QYkeYIZrmRTsz6dog36id4dqKI0X2OBOZaIaMP23x
         UQX1Ir4Zw1zuVfn6JSBxlYdU/PTXBX0SWtEDmHfjp9ItAjEsGbqowB1eiVeyNGxMuhpd
         IHEu2bMYc3kK0DSK4D52xMZJYONhf6P3eH9P/iRUnS5DOCB/i/TIEuALYt8y8ityL0qF
         ZtovSNZI6GNVk9Y2H8fpY+l7uUMN3BKKYbJuEeMmSWLAuXS4Vzfw7iJpRjhP6hzPcMDQ
         nF4Q==
X-Gm-Message-State: APjAAAV/xrccRYyTMISrIw6e6AabycdNKdWS9NuZyNC0rrO8aremaiot
        5qy4gUAnbhkRtUYVjnneGoMMFcXIEAcLrA==
X-Google-Smtp-Source: APXvYqx11CIBGgHIOJL93ZavdAp4S8oGzoPExg7oApXpCKJ+hBZKp44tlKkYDPGYU/DVVdFgvQ/9fw==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr29087671pgr.419.1575237524015;
        Sun, 01 Dec 2019 13:58:44 -0800 (PST)
Received: from localhost.localdomain (c-67-188-68-101.hsd1.ca.comcast.net. [67.188.68.101])
        by smtp.gmail.com with ESMTPSA id v16sm22939813pje.1.2019.12.01.13.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Dec 2019 13:58:43 -0800 (PST)
From:   Mike Ryan <mike@ice9.us>
To:     linux-bluetooth@vger.kernel.org
Cc:     mike@ice9.us
Subject: [PATCH] Bluetooth: Expose debugfs entry to force resolvable private address
Date:   Sun,  1 Dec 2019 13:57:44 -0800
Message-Id: <20191201215744.20162-1-mike@ice9.us>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In order to facilitate impersonation attacks against devices using
resolvable private addresses (RPAs), this debugfs entry allows the user
to set a fixed RPA that is used during undirected and directed
advertising. Writing 00:00:00:00:00:00 disables the forced address and
will resume generating valid RPAs.

Signed-off-by: Mike Ryan <mike@ice9.us>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_debugfs.c      | 54 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.c      | 15 ++++++++---
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb6..a822914d7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -428,6 +428,7 @@ struct hci_dev {
 	__u32			rpa_timeout;
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
+	bdaddr_t		force_rpa;
 
 #if IS_ENABLED(CONFIG_BT_LEDS)
 	struct led_trigger	*power_led;
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 402e2cc54..1efefe82c 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -710,6 +710,58 @@ static const struct file_operations force_static_address_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t force_rpa_read(struct file *file,
+					 char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[19];
+	bdaddr_t *ba = &hdev->force_rpa;
+
+	sprintf(buf, "%pMR\n", ba);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t force_rpa_write(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[18];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bdaddr_t rpa;
+
+	if (test_bit(HCI_UP, &hdev->flags))
+		return -EBUSY;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (str2ba(buf, &rpa))
+		return -EINVAL;
+
+	/* The two most significant bits shall be 01 unless the address is
+	 * 00:00:00:00:00:00.
+         */
+	if ((rpa.b[5] & 0xc0) != 0x40 && bacmp(&rpa, BDADDR_ANY))
+		return -EINVAL;
+
+	if (!bacmp(&hdev->force_rpa, &rpa))
+		return -EALREADY;
+
+	bacpy(&hdev->force_rpa, &rpa);
+
+	return count;
+}
+
+static const struct file_operations force_rpa_fops = {
+	.open		= simple_open,
+	.read		= force_rpa_read,
+	.write		= force_rpa_write,
+	.llseek		= default_llseek,
+};
+
 static int white_list_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1026,6 +1078,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 				    hdev->debugfs, hdev,
 				    &force_static_address_fops);
 
+	debugfs_create_file("force_rpa", 0644, hdev->debugfs, hdev,
+			    &force_rpa_fops);
 	debugfs_create_u8("white_list_size", 0444, hdev->debugfs,
 			  &hdev->le_white_list_size);
 	debugfs_create_file("white_list", 0444, hdev->debugfs, hdev,
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 2a1b64dbf..63f4d5c16 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1914,10 +1914,17 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		    !bacmp(&hdev->random_addr, &hdev->rpa))
 			return 0;
 
-		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
-		if (err < 0) {
-			bt_dev_err(hdev, "failed to generate new RPA");
-			return err;
+		/* If force_rpa is set to 00:00:00:00:00:00, generate a valid
+		 * RPA using IRK. Otherwise use the forced value.
+		 */
+		if (!bacmp(&hdev->force_rpa, BDADDR_ANY)) {
+			err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+			if (err < 0) {
+				bt_dev_err(hdev, "failed to generate new RPA");
+				return err;
+			}
+		} else {
+			bacpy(&hdev->rpa, &hdev->force_rpa);
 		}
 
 		set_random_addr(req, &hdev->rpa);
-- 
2.11.0

