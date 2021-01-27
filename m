Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F633C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 06:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526B5205CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 06:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhA0Gag (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:30:36 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1645 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231311AbhA0GSg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 01:18:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UN0aNvs_1611728255;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UN0aNvs_1611728255)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Jan 2021 14:17:39 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH v3] net/bluetooth/hci_debugfs.c:  fix coccicheck warnings
Date:   Wed, 27 Jan 2021 14:17:33 +0800
Message-Id: <1611728253-130374-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
for debugfs files.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
Changes in v2:
  -Modifying row alignment.

 net/bluetooth/hci_debugfs.c | 80 ++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 4626e02..1a0ab58 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -237,8 +237,8 @@ static int conn_info_min_age_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(conn_info_min_age_fops, conn_info_min_age_get,
-			conn_info_min_age_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(conn_info_min_age_fops, conn_info_min_age_get,
+			  conn_info_min_age_set, "%llu\n");
 
 static int conn_info_max_age_set(void *data, u64 val)
 {
@@ -265,8 +265,8 @@ static int conn_info_max_age_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(conn_info_max_age_fops, conn_info_max_age_get,
-			conn_info_max_age_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(conn_info_max_age_fops, conn_info_max_age_get,
+			  conn_info_max_age_set, "%llu\n");
 
 static ssize_t use_debug_keys_read(struct file *file, char __user *user_buf,
 				   size_t count, loff_t *ppos)
@@ -419,8 +419,8 @@ static int voice_setting_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(voice_setting_fops, voice_setting_get,
-			NULL, "0x%4.4llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(voice_setting_fops, voice_setting_get,
+			  NULL, "0x%4.4llx\n");
 
 static ssize_t ssp_debug_mode_read(struct file *file, char __user *user_buf,
 				   size_t count, loff_t *ppos)
@@ -476,9 +476,9 @@ static int min_encrypt_key_size_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(min_encrypt_key_size_fops,
-			min_encrypt_key_size_get,
-			min_encrypt_key_size_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(min_encrypt_key_size_fops,
+			  min_encrypt_key_size_get,
+			  min_encrypt_key_size_set, "%llu\n");
 
 static int auto_accept_delay_get(void *data, u64 *val)
 {
@@ -491,8 +491,8 @@ static int auto_accept_delay_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
-			auto_accept_delay_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
+			  auto_accept_delay_set, "%llu\n");
 
 static ssize_t force_bredr_smp_read(struct file *file,
 				    char __user *user_buf,
@@ -558,8 +558,8 @@ static int idle_timeout_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
-			idle_timeout_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
+			  idle_timeout_set, "%llu\n");
 
 static int sniff_min_interval_set(void *data, u64 val)
 {
@@ -586,8 +586,8 @@ static int sniff_min_interval_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(sniff_min_interval_fops, sniff_min_interval_get,
-			sniff_min_interval_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(sniff_min_interval_fops, sniff_min_interval_get,
+			  sniff_min_interval_set, "%llu\n");
 
 static int sniff_max_interval_set(void *data, u64 val)
 {
@@ -614,8 +614,8 @@ static int sniff_max_interval_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
-			sniff_max_interval_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
+			  sniff_max_interval_set, "%llu\n");
 
 void hci_debugfs_create_bredr(struct hci_dev *hdev)
 {
@@ -706,8 +706,8 @@ static int rpa_timeout_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(rpa_timeout_fops, rpa_timeout_get,
-			rpa_timeout_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(rpa_timeout_fops, rpa_timeout_get,
+			  rpa_timeout_set, "%llu\n");
 
 static int random_address_show(struct seq_file *f, void *p)
 {
@@ -869,8 +869,8 @@ static int conn_min_interval_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(conn_min_interval_fops, conn_min_interval_get,
-			conn_min_interval_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(conn_min_interval_fops, conn_min_interval_get,
+			  conn_min_interval_set, "%llu\n");
 
 static int conn_max_interval_set(void *data, u64 val)
 {
@@ -897,8 +897,8 @@ static int conn_max_interval_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
-			conn_max_interval_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
+			  conn_max_interval_set, "%llu\n");
 
 static int conn_latency_set(void *data, u64 val)
 {
@@ -925,8 +925,8 @@ static int conn_latency_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(conn_latency_fops, conn_latency_get,
-			conn_latency_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(conn_latency_fops, conn_latency_get,
+			  conn_latency_set, "%llu\n");
 
 static int supervision_timeout_set(void *data, u64 val)
 {
@@ -953,8 +953,8 @@ static int supervision_timeout_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(supervision_timeout_fops, supervision_timeout_get,
-			supervision_timeout_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(supervision_timeout_fops, supervision_timeout_get,
+			  supervision_timeout_set, "%llu\n");
 
 static int adv_channel_map_set(void *data, u64 val)
 {
@@ -981,8 +981,8 @@ static int adv_channel_map_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
-			adv_channel_map_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
+			  adv_channel_map_set, "%llu\n");
 
 static int adv_min_interval_set(void *data, u64 val)
 {
@@ -1009,8 +1009,8 @@ static int adv_min_interval_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(adv_min_interval_fops, adv_min_interval_get,
-			adv_min_interval_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(adv_min_interval_fops, adv_min_interval_get,
+			  adv_min_interval_set, "%llu\n");
 
 static int adv_max_interval_set(void *data, u64 val)
 {
@@ -1037,8 +1037,8 @@ static int adv_max_interval_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
-			adv_max_interval_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
+			  adv_max_interval_set, "%llu\n");
 
 static int min_key_size_set(void *data, u64 val)
 {
@@ -1065,8 +1065,8 @@ static int min_key_size_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(min_key_size_fops, min_key_size_get,
-			min_key_size_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(min_key_size_fops, min_key_size_get,
+			  min_key_size_set, "%llu\n");
 
 static int max_key_size_set(void *data, u64 val)
 {
@@ -1093,8 +1093,8 @@ static int max_key_size_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(max_key_size_fops, max_key_size_get,
-			max_key_size_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(max_key_size_fops, max_key_size_get,
+			  max_key_size_set, "%llu\n");
 
 static int auth_payload_timeout_set(void *data, u64 val)
 {
@@ -1121,9 +1121,9 @@ static int auth_payload_timeout_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(auth_payload_timeout_fops,
-			auth_payload_timeout_get,
-			auth_payload_timeout_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(auth_payload_timeout_fops,
+			  auth_payload_timeout_get,
+			  auth_payload_timeout_set, "%llu\n");
 
 static ssize_t force_no_mitm_read(struct file *file,
 				  char __user *user_buf,
-- 
1.8.3.1

