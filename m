Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB1C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631D82146E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="phEZ5p1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfBTKOw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:14:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36366 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBTKOw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 05:14:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so20317324ljk.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Feb 2019 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+drQVATyMJiDf+s8JjeurGDNSIVhCjqreTkGZvf4PPY=;
        b=phEZ5p1kR2L47gdMLECc01VmbGozi/SISKu/2kqyqSt5gIZwAECgNDJLpx01tlX4V0
         QP+6+tbuGxi8evXWz1SfKFZrRWx+iEUBM7hfZ6/S8eVy7ILo2fJzq58K7GL3oWPofKZQ
         9inaSLqBPz4C1cLL33ZKCeHww6wU005Vyc2kpFkNAX9xWgmjmvPrmqbyeqtRNm4fhe8M
         uNT473MQGv4s41d5BeRilJC7+R8Bs2fFPYXUrw7xTfOUJGMiksaA8U8kzdS/BRWtycPZ
         RtxAb/EkpxFj9e7CRmMuaQjFf9GrZ72yrvz5h7EkjlPexZu1P/8Me6lo+Zc5je+YGDAo
         XQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+drQVATyMJiDf+s8JjeurGDNSIVhCjqreTkGZvf4PPY=;
        b=eB1EwTGvirVamWJa5lAx97RS7jjLlxnDZea2TBbz0s8LJi6Vcw6Jdc/O8IJHw+pl2p
         tSftb0m9yY1doFSL3yXge1+1eMHUAWPr8DHyIAh6P8Cf2VjhdlrNoxCeTp3K9obZJiRs
         n42XjhMF0WwXe7UPhNtdWvRDSGkRnYDHEtY/PFBe3Wl9m1rLmvCWhk2OtvCGLEqjFUvI
         Zks3wJldmBLRde+wKdeMrwbCi0cKjIebb+TfMKLgOTJrTHhQzmIzRDnUknM94uUTpINC
         vobY9fahboL72C+hoGU/37/5S3YT6RngP6Lgvr8yzttEPqyPH8rs5rDeB9CePqcXSNi0
         60Tw==
X-Gm-Message-State: AHQUAuaWzy/Xg79OIM90/NFSEnPF2yCaDHc7E2fTwUsbhFlZQkfRBJ/K
        Mv3Je76uxokmxbgPpxK4rIxlvRQgzGA=
X-Google-Smtp-Source: AHgI3IbIxSsA+ALP8axKjdR54jQ2BWIjk8d+oxOZMc0aPq1o2AB6mY8T414hGOm8CloV1mR4o0wbIw==
X-Received: by 2002:a2e:5306:: with SMTP id h6-v6mr19562622ljb.67.1550657689769;
        Wed, 20 Feb 2019 02:14:49 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id x19sm3856218lfe.42.2019.02.20.02.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 02:14:49 -0800 (PST)
From:   Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 1/5] Bluetooth: Expose supported LE states via debugfs
Date:   Wed, 20 Feb 2019 11:14:24 +0100
Message-Id: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It may be useful for debugging purposes to quickly retrieve supported LE
stated bit mask for controller.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
---
 net/bluetooth/hci_debugfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 51f5b1efc3a5..c0b11ebacf7d 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -679,6 +679,29 @@ static const struct file_operations force_static_address_fops = {
 	.llseek		= default_llseek,
 };
 
+static int le_states_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+
+	hci_dev_lock(hdev);
+	seq_printf(f, "LE: %8ph\n", hdev->le_states);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int le_states_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, le_states_show, inode->i_private);
+}
+
+static const struct file_operations le_states_fops = {
+	.open		= le_states_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int white_list_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -956,6 +979,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 			    &random_address_fops);
 	debugfs_create_file("static_address", 0444, hdev->debugfs, hdev,
 			    &static_address_fops);
+	debugfs_create_file("le_states", 0444, hdev->debugfs, hdev,
+			    &le_states_fops);
 
 	/* For controllers with a public address, provide a debug
 	 * option to force the usage of the configured static
-- 
2.20.1

