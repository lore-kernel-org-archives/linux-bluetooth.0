Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420D3C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EFE2078D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 08:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEGK3MH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIOIxU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgIOIxO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 04:53:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E845C061788
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 01:53:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so1529528pfn.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSkXbP+J1TMjFBWegElSl4Q/t7muEHtw5BSMl1QhD/A=;
        b=bEGK3MH/KPcY/OY47ViPoat0bty5dX+hrA6NxHMHsXcBuOfJqR6FPMQQXpXhZgYigI
         JmgoZ4NtwzxGaSAd/RD23Dh1RXab8nON6MsVV6Pkl+v4tsUE/pilohW3ZU1WU5l0O6Sn
         lmXgcRxOCKEJ+BiIj/xEwzMSJx9odazEmrqWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSkXbP+J1TMjFBWegElSl4Q/t7muEHtw5BSMl1QhD/A=;
        b=ku1Ed+R2y8W/kam7lpTdTkAOP+dLOLCb6xFss6eE/80U7HbZMcxQghD2+O8ltjByet
         3ZT17d5VWGqY5hXJAxZXF+rP6vJC5C6PGlzaeMsPlTImcie3qPYRP+pXyIrLPhEqAcfq
         S6EWuwhxxBchAUHdXSopyq72GB8iccroHkyuhGWDCvNqpCGtwvYqTeBa++aizt9IZ8K0
         WkjAxwGJNohtcnGJegm0rH1AlpgMhzlvhJC7MWrmc9R2qAN1AOOZp3Jaz5c/32vUv5hQ
         5uFcPrVPHvFIRIG1g0EQfyzZyZ7fuxqbe4p5xQxbOH9Azf8LRkNNG3WoOkoBvXXHTL3j
         lddg==
X-Gm-Message-State: AOAM532Yn4Hp+UKrnw61YpQ5xJ+cfXjGfhETbt5fqpzRSlkqnUsu4aQ8
        rdldRRV6ipEK0qBh52m7Xt9iDA==
X-Google-Smtp-Source: ABdhPJxPgY2cVxs+wfsepzZjYz4wG5cYt8PMDDotZxERLscCPzUpGidDwul7+Hj5ACF0S8AxFvoZtQ==
X-Received: by 2002:a05:6a00:1513:b029:142:2501:34de with SMTP id q19-20020a056a001513b0290142250134demr945662pfu.55.1600159993183;
        Tue, 15 Sep 2020 01:53:13 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id c1sm12707157pfi.136.2020.09.15.01.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 01:53:12 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: Move force_bredr_smp debugfs into hci_debugfs_create_bredr
Date:   Tue, 15 Sep 2020 16:53:07 +0800
Message-Id: <20200915085307.1171598-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Avoid multiple attempts to create the debugfs entery, force_bredr_smp,
by moving it from the SMP registration to the BR/EDR controller init
section. hci_debugfs_create_bredr is only called when HCI_SETUP and
HCI_CONFIG is not set.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 net/bluetooth/hci_debugfs.c | 50 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/smp.c         | 44 ++------------------------------
 net/bluetooth/smp.h         |  2 ++
 3 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 5e8af2658e44..4626e0289a97 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -494,6 +494,45 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
+static ssize_t force_bredr_smp_read(struct file *file,
+				    char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_bredr_smp_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	err = smp_force_bredr(hdev, enable);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static const struct file_operations force_bredr_smp_fops = {
+	.open		= simple_open,
+	.read		= force_bredr_smp_read,
+	.write		= force_bredr_smp_write,
+	.llseek		= default_llseek,
+};
+
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -589,6 +628,17 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
 	debugfs_create_file("voice_setting", 0444, hdev->debugfs, hdev,
 			    &voice_setting_fops);
 
+	/* If the controller does not support BR/EDR Secure Connections
+	 * feature, then the BR/EDR SMP channel shall not be present.
+	 *
+	 * To test this with Bluetooth 4.0 controllers, create a debugfs
+	 * switch that allows forcing BR/EDR SMP support and accepting
+	 * cross-transport pairing on non-AES encrypted connections.
+	 */
+	if (!lmp_sc_capable(hdev))
+		debugfs_create_file("force_bredr_smp", 0644, hdev->debugfs,
+				    hdev, &force_bredr_smp_fops);
+
 	if (lmp_ssp_capable(hdev)) {
 		debugfs_create_file("ssp_debug_mode", 0444, hdev->debugfs,
 				    hdev, &ssp_debug_mode_fops);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 433227f96c73..8b817e4358fd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3353,31 +3353,8 @@ static void smp_del_chan(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
-static ssize_t force_bredr_smp_read(struct file *file,
-				    char __user *user_buf,
-				    size_t count, loff_t *ppos)
+int smp_force_bredr(struct hci_dev *hdev, bool enable)
 {
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t force_bredr_smp_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	bool enable;
-	int err;
-
-	err = kstrtobool_from_user(user_buf, count, &enable);
-	if (err)
-		return err;
-
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 		return -EALREADY;
 
@@ -3399,16 +3376,9 @@ static ssize_t force_bredr_smp_write(struct file *file,
 
 	hci_dev_change_flag(hdev, HCI_FORCE_BREDR_SMP);
 
-	return count;
+	return 0;
 }
 
-static const struct file_operations force_bredr_smp_fops = {
-	.open		= simple_open,
-	.read		= force_bredr_smp_read,
-	.write		= force_bredr_smp_write,
-	.llseek		= default_llseek,
-};
-
 int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
@@ -3433,17 +3403,7 @@ int smp_register(struct hci_dev *hdev)
 
 	hdev->smp_data = chan;
 
-	/* If the controller does not support BR/EDR Secure Connections
-	 * feature, then the BR/EDR SMP channel shall not be present.
-	 *
-	 * To test this with Bluetooth 4.0 controllers, create a debugfs
-	 * switch that allows forcing BR/EDR SMP support and accepting
-	 * cross-transport pairing on non-AES encrypted connections.
-	 */
 	if (!lmp_sc_capable(hdev)) {
-		debugfs_create_file("force_bredr_smp", 0644, hdev->debugfs,
-				    hdev, &force_bredr_smp_fops);
-
 		/* Flag can be already set here (due to power toggle) */
 		if (!hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 			return 0;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 121edadd5f8d..fc35a8bf358e 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -193,6 +193,8 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
 int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16]);
 
+int smp_force_bredr(struct hci_dev *hdev, bool enable);
+
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);
 
-- 
2.28.0.618.gf4bc123cb7-goog

