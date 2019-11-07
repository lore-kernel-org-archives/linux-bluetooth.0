Return-Path: <SRS0=nDLV=Y7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC9C5DF61
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 04:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270BA2178F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 04:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ice9-us.20150623.gappssmtp.com header.i=@ice9-us.20150623.gappssmtp.com header.b="MGEL88Kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfKGEHD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:07:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46244 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKGEHD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Nov 2019 23:07:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id l4so489778plt.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2019 20:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ice9-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=LtTQxTtUpOQDCP0PBJAdks4jWNQ+TOKDlBxapGHb1eI=;
        b=MGEL88Kn+vJktFuBe5qNvpkBFUnwQeL0j17FXzkIrNy5uD8bkDylTBEeDY32ugekt3
         EHPAGDanP9jBfh7YLdiTQh+rdO2YIk1WNZa2WeGAiQ6YxRcAOxExvfVuWHoOOyJdvnlQ
         uFCBLEDBh2obBxU2X2oUA67Co3SuHe9Y/pk5B4ojG5QPoe7LEGT6CRvGf8DazNWjE/uZ
         IOdidFiKs/+qk5N0wkA9S6GJ+gkaAkyTMflCIcqMDAXjYNKwHWAuqtYTg5xRMEycifIQ
         cCrV97IQfgzdkOs6fxqdeKWkxjDvVs9eGDLtq9TxX45Grk+fETpZf4E7fCDmkqswmeo4
         w/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LtTQxTtUpOQDCP0PBJAdks4jWNQ+TOKDlBxapGHb1eI=;
        b=aoJDh6G0V+O2pgQY2G0OeeNEb3sOtjqjbqmUnY+R0FTU8a9of3Htny8hVsoJpaEAfI
         uHU0MTt5tBaZvgsoaWny+kuQGBmP5GKoRtu09Z1/YIQUPbr9NyUKEcW22NntM7fWRsp2
         ZulC4f8eZifUExfaeLNQHG72lmv+prbUdxScZdFnIonwp/qcpY8uyLEBedV3NYGazvwy
         0LNHPBB4zWX4sZwVtlgF+3fPpKawEwadwPJWsnbTXX8LM83zk5hQTYRhya8SwcrB4zKo
         RCaAcJ0UamceHpyM02l4FWAaO/GQd/ofinflYw+MmpCEh8cfx1ijjOJ/XwWDeqotzujL
         Vv5Q==
X-Gm-Message-State: APjAAAWTPBpn9NPpMU6qK5Fbwz7y73ReFqS8wCRjxnDoQFsQpKA/V/lY
        il6VffID/309knhRV7vo1TTwII1eHP8=
X-Google-Smtp-Source: APXvYqwySDRmGlIDQ8ZPXdirWjD67j9CpxTqXJMbbIEpeHHOLq11iYewyHZ0WVFrekGcsxkvqk+Q5Q==
X-Received: by 2002:a17:902:7287:: with SMTP id d7mr1426755pll.333.1573099621655;
        Wed, 06 Nov 2019 20:07:01 -0800 (PST)
Received: from localhost.localdomain (c-67-188-68-101.hsd1.ca.comcast.net. [67.188.68.101])
        by smtp.gmail.com with ESMTPSA id s11sm554156pgo.85.2019.11.06.20.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 20:07:01 -0800 (PST)
From:   mike@ice9.us
To:     linux-bluetooth@vger.kernel.org
Cc:     mike@ice9.us
Subject: [PATCH] Bluetooth: Expose debugfs entry to allow illegal static address
Date:   Wed,  6 Nov 2019 20:06:56 -0800
Message-Id: <20191107040656.29306-1-mike@ice9.us>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Mike Ryan <mike@ice9.us>

The first two bits of valid static addresses must both be 0 because
other values are reserved for resolvable and non-resolvable private
addresses (RPA and NRPA). In order to facilitate impersonation attacks
against devices using RPAs, this debugfs entry allows the user to set
the static address to an illegal value reserved for RPAs.

Signed-off-by: Mike Ryan <mike@ice9.us>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_debugfs.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c        |  4 +++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bc1e30de..d1e477093 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -280,6 +280,7 @@ enum {
 	HCI_DUT_MODE,
 	HCI_VENDOR_DIAG,
 	HCI_FORCE_BREDR_SMP,
+	HCI_ALLOW_ILLEGAL_STATIC_ADDR,
 	HCI_FORCE_STATIC_ADDR,
 	HCI_LL_RPA_RESOLUTION,
 	HCI_CMD_PENDING,
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 402e2cc54..0d3006302 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -667,6 +667,47 @@ static int static_address_show(struct seq_file *f, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(static_address);
 
+static ssize_t allow_illegal_static_address_read(struct file *file,
+					 char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_ALLOW_ILLEGAL_STATIC_ADDR) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t allow_illegal_static_address_write(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (enable == hci_dev_test_flag(hdev, HCI_ALLOW_ILLEGAL_STATIC_ADDR))
+		return -EALREADY;
+
+	hci_dev_change_flag(hdev, HCI_ALLOW_ILLEGAL_STATIC_ADDR);
+
+	return count;
+
+}
+
+static const struct file_operations allow_illegal_static_address_fops = {
+	.open		= simple_open,
+	.read		= allow_illegal_static_address_read,
+	.write		= allow_illegal_static_address_write,
+	.llseek		= default_llseek,
+};
+
 static ssize_t force_static_address_read(struct file *file,
 					 char __user *user_buf,
 					 size_t count, loff_t *ppos)
@@ -1016,6 +1057,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 			    &random_address_fops);
 	debugfs_create_file("static_address", 0444, hdev->debugfs, hdev,
 			    &static_address_fops);
+	debugfs_create_file("allow_illegal_static_address", 0644, hdev->debugfs,
+			    hdev, &allow_illegal_static_address_fops);
 
 	/* For controllers with a public address, provide a debug
 	 * option to force the usage of the configured static
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index acb7c6d56..59945b850 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4428,10 +4428,12 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 					       MGMT_STATUS_INVALID_PARAMS);
 
 		/* Two most significant bits shall be set */
-		if ((cp->bdaddr.b[5] & 0xc0) != 0xc0)
+		if ((cp->bdaddr.b[5] & 0xc0) != 0xc0 &&
+		    !hci_dev_test_flag(hdev, HCI_ALLOW_ILLEGAL_STATIC_ADDR)) {
 			return mgmt_cmd_status(sk, hdev->id,
 					       MGMT_OP_SET_STATIC_ADDRESS,
 					       MGMT_STATUS_INVALID_PARAMS);
+		}
 	}
 
 	hci_dev_lock(hdev);
-- 
2.11.0

