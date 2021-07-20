Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A719C07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 15:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9A6610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 15:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbhGTO2b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 10:28:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56020 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbhGTOKx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 10:10:53 -0400
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16KEoOCk055304;
        Tue, 20 Jul 2021 23:50:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Tue, 20 Jul 2021 23:50:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16KEoJYh055284
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Jul 2021 23:50:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, LinMa <linma@zju.edu.cn>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] Bluetooth: introduce hci_dev_lock_killable()
Date:   Tue, 20 Jul 2021 23:50:09 +0900
Message-Id: <20210720145009.5201-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since being able to immediately react to SIGKILL is good,
introduce killable version of hci_dev_lock().

Since there are 270+ hci_dev_lock() callers, this patch updates only
hci_debugfs.c part where blindly aborting operation would be acceptable.

Although hci_dev_lock_killable() is currently an alias of
mutex_lock_killable() which returns either 0 or -EINTR, this patch
explicitly receives return value of hci_dev_lock_killable() using a
local variable in order to make it possible to add race detection into
hci_dev_lock_killable(), and e.g. return 0 without doing anything when
a race was detected.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/hci_debugfs.c      | 221 ++++++++++++++++++++++++-------
 2 files changed, 171 insertions(+), 51 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d9e55682b908..f8d0e57407e7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1208,6 +1208,7 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 }
 
 #define hci_dev_lock(d)		mutex_lock(&d->lock)
+#define hci_dev_lock_killable(d) mutex_lock_killable(&d->lock)
 #define hci_dev_unlock(d)	mutex_unlock(&d->lock)
 
 #define to_hci_dev(d) container_of(d, struct hci_dev, dev)
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 841393389f7b..6a5801d90126 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -77,8 +77,10 @@ static const struct file_operations __name ## _fops = {			      \
 static int __name ## _show(struct seq_file *f, void *ptr)		      \
 {									      \
 	struct hci_dev *hdev = f->private;				      \
+	const int err = hci_dev_lock_killable(hdev);			      \
 									      \
-	hci_dev_lock(hdev);						      \
+	if (err)							      \
+		return err;						      \
 	seq_printf(f, "%s\n", hdev->__field ? : "");			      \
 	hci_dev_unlock(hdev);						      \
 									      \
@@ -91,8 +93,10 @@ static int features_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
 	u8 p;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	for (p = 0; p < HCI_MAX_PAGES && p <= hdev->max_page; p++)
 		seq_printf(f, "%2u: %8ph\n", p, hdev->features[p]);
 	if (lmp_le_capable(hdev))
@@ -107,8 +111,10 @@ DEFINE_SHOW_ATTRIBUTE(features);
 static int device_id_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	seq_printf(f, "%4.4x:%4.4x:%4.4x:%4.4x\n", hdev->devid_source,
 		  hdev->devid_vendor, hdev->devid_product, hdev->devid_version);
 	hci_dev_unlock(hdev);
@@ -123,8 +129,10 @@ static int device_list_show(struct seq_file *f, void *ptr)
 	struct hci_dev *hdev = f->private;
 	struct hci_conn_params *p;
 	struct bdaddr_list *b;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	list_for_each_entry(b, &hdev->accept_list, list)
 		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
@@ -142,8 +150,10 @@ static int blacklist_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
 	struct bdaddr_list *b;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	list_for_each_entry(b, &hdev->reject_list, list)
 		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
 	hci_dev_unlock(hdev);
@@ -172,8 +182,10 @@ static int uuids_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
 	struct bt_uuid *uuid;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	list_for_each_entry(uuid, &hdev->uuids, list) {
 		u8 i, val[16];
 
@@ -197,8 +209,10 @@ static int remote_oob_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
 	struct oob_data *data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	list_for_each_entry(data, &hdev->remote_oob_data, list) {
 		seq_printf(f, "%pMR (type %u) %u %*phN %*phN %*phN %*phN\n",
 			   &data->bdaddr, data->bdaddr_type, data->present,
@@ -215,11 +229,14 @@ DEFINE_SHOW_ATTRIBUTE(remote_oob);
 static int conn_info_min_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val == 0 || val > hdev->conn_info_max_age)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->conn_info_min_age = val;
 	hci_dev_unlock(hdev);
 
@@ -229,8 +246,10 @@ static int conn_info_min_age_set(void *data, u64 val)
 static int conn_info_min_age_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->conn_info_min_age;
 	hci_dev_unlock(hdev);
 
@@ -243,11 +262,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(conn_info_min_age_fops, conn_info_min_age_get,
 static int conn_info_max_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val == 0 || val < hdev->conn_info_min_age)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->conn_info_max_age = val;
 	hci_dev_unlock(hdev);
 
@@ -257,8 +279,10 @@ static int conn_info_max_age_set(void *data, u64 val)
 static int conn_info_max_age_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->conn_info_max_age;
 	hci_dev_unlock(hdev);
 
@@ -357,8 +381,10 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 	struct hci_dev *hdev = f->private;
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 
 	list_for_each_entry(e, &cache->all, all) {
 		struct inquiry_data *data = &e->data;
@@ -397,8 +423,10 @@ DEFINE_SHOW_ATTRIBUTE(link_keys);
 static int dev_class_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	seq_printf(f, "0x%.2x%.2x%.2x\n", hdev->dev_class[2],
 		   hdev->dev_class[1], hdev->dev_class[0]);
 	hci_dev_unlock(hdev);
@@ -411,8 +439,10 @@ DEFINE_SHOW_ATTRIBUTE(dev_class);
 static int voice_setting_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->voice_setting;
 	hci_dev_unlock(hdev);
 
@@ -443,8 +473,10 @@ static const struct file_operations ssp_debug_mode_fops = {
 static int auto_accept_delay_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	hdev->auto_accept_delay = val;
 	hci_dev_unlock(hdev);
 
@@ -454,11 +486,14 @@ static int auto_accept_delay_set(void *data, u64 val)
 static int min_encrypt_key_size_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val < 1 || val > 16)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->min_enc_key_size = val;
 	hci_dev_unlock(hdev);
 
@@ -468,8 +503,10 @@ static int min_encrypt_key_size_set(void *data, u64 val)
 static int min_encrypt_key_size_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->min_enc_key_size;
 	hci_dev_unlock(hdev);
 
@@ -483,8 +520,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(min_encrypt_key_size_fops,
 static int auto_accept_delay_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->auto_accept_delay;
 	hci_dev_unlock(hdev);
 
@@ -536,11 +575,14 @@ static const struct file_operations force_bredr_smp_fops = {
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val != 0 && (val < 500 || val > 3600000))
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->idle_timeout = val;
 	hci_dev_unlock(hdev);
 
@@ -550,8 +592,10 @@ static int idle_timeout_set(void *data, u64 val)
 static int idle_timeout_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->idle_timeout;
 	hci_dev_unlock(hdev);
 
@@ -564,11 +608,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
 static int sniff_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->sniff_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -578,8 +625,10 @@ static int sniff_min_interval_set(void *data, u64 val)
 static int sniff_min_interval_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->sniff_min_interval;
 	hci_dev_unlock(hdev);
 
@@ -592,11 +641,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(sniff_min_interval_fops, sniff_min_interval_get,
 static int sniff_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->sniff_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -606,8 +658,10 @@ static int sniff_max_interval_set(void *data, u64 val)
 static int sniff_max_interval_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->sniff_max_interval;
 	hci_dev_unlock(hdev);
 
@@ -663,8 +717,10 @@ static int identity_show(struct seq_file *f, void *p)
 	struct hci_dev *hdev = f->private;
 	bdaddr_t addr;
 	u8 addr_type;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 
 	hci_copy_identity_address(hdev, &addr, &addr_type);
 
@@ -681,6 +737,7 @@ DEFINE_SHOW_ATTRIBUTE(identity);
 static int rpa_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	/* Require the RPA timeout to be at least 30 seconds and at most
 	 * 24 hours.
@@ -688,7 +745,9 @@ static int rpa_timeout_set(void *data, u64 val)
 	if (val < 30 || val > (60 * 60 * 24))
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->rpa_timeout = val;
 	hci_dev_unlock(hdev);
 
@@ -698,8 +757,10 @@ static int rpa_timeout_set(void *data, u64 val)
 static int rpa_timeout_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->rpa_timeout;
 	hci_dev_unlock(hdev);
 
@@ -712,8 +773,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(rpa_timeout_fops, rpa_timeout_get,
 static int random_address_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	seq_printf(f, "%pMR\n", &hdev->random_addr);
 	hci_dev_unlock(hdev);
 
@@ -725,8 +788,10 @@ DEFINE_SHOW_ATTRIBUTE(random_address);
 static int static_address_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	seq_printf(f, "%pMR\n", &hdev->static_addr);
 	hci_dev_unlock(hdev);
 
@@ -782,8 +847,10 @@ static int white_list_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
 	struct bdaddr_list *b;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	list_for_each_entry(b, &hdev->le_accept_list, list)
 		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
 	hci_dev_unlock(hdev);
@@ -797,8 +864,10 @@ static int resolv_list_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
 	struct bdaddr_list *b;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	list_for_each_entry(b, &hdev->le_resolv_list, list)
 		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
 	hci_dev_unlock(hdev);
@@ -847,11 +916,14 @@ DEFINE_SHOW_ATTRIBUTE(long_term_keys);
 static int conn_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_conn_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -861,8 +933,10 @@ static int conn_min_interval_set(void *data, u64 val)
 static int conn_min_interval_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_conn_min_interval;
 	hci_dev_unlock(hdev);
 
@@ -875,11 +949,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(conn_min_interval_fops, conn_min_interval_get,
 static int conn_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_conn_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -889,8 +966,10 @@ static int conn_max_interval_set(void *data, u64 val)
 static int conn_max_interval_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_conn_max_interval;
 	hci_dev_unlock(hdev);
 
@@ -903,11 +982,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
 static int conn_latency_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val > 0x01f3)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_conn_latency = val;
 	hci_dev_unlock(hdev);
 
@@ -917,8 +999,10 @@ static int conn_latency_set(void *data, u64 val)
 static int conn_latency_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_conn_latency;
 	hci_dev_unlock(hdev);
 
@@ -931,11 +1015,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(conn_latency_fops, conn_latency_get,
 static int supervision_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val < 0x000a || val > 0x0c80)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_supv_timeout = val;
 	hci_dev_unlock(hdev);
 
@@ -945,8 +1032,10 @@ static int supervision_timeout_set(void *data, u64 val)
 static int supervision_timeout_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_supv_timeout;
 	hci_dev_unlock(hdev);
 
@@ -959,11 +1048,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(supervision_timeout_fops, supervision_timeout_get,
 static int adv_channel_map_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val < 0x01 || val > 0x07)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_adv_channel_map = val;
 	hci_dev_unlock(hdev);
 
@@ -973,8 +1065,10 @@ static int adv_channel_map_set(void *data, u64 val)
 static int adv_channel_map_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_adv_channel_map;
 	hci_dev_unlock(hdev);
 
@@ -987,11 +1081,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
 static int adv_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_adv_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -1001,8 +1098,10 @@ static int adv_min_interval_set(void *data, u64 val)
 static int adv_min_interval_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_adv_min_interval;
 	hci_dev_unlock(hdev);
 
@@ -1015,11 +1114,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(adv_min_interval_fops, adv_min_interval_get,
 static int adv_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_adv_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -1029,8 +1131,10 @@ static int adv_max_interval_set(void *data, u64 val)
 static int adv_max_interval_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_adv_max_interval;
 	hci_dev_unlock(hdev);
 
@@ -1043,11 +1147,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
 static int min_key_size_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val > hdev->le_max_key_size || val < SMP_MIN_ENC_KEY_SIZE)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_min_key_size = val;
 	hci_dev_unlock(hdev);
 
@@ -1057,8 +1164,10 @@ static int min_key_size_set(void *data, u64 val)
 static int min_key_size_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_min_key_size;
 	hci_dev_unlock(hdev);
 
@@ -1071,11 +1180,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(min_key_size_fops, min_key_size_get,
 static int max_key_size_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val > SMP_MAX_ENC_KEY_SIZE || val < hdev->le_min_key_size)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->le_max_key_size = val;
 	hci_dev_unlock(hdev);
 
@@ -1085,8 +1197,10 @@ static int max_key_size_set(void *data, u64 val)
 static int max_key_size_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->le_max_key_size;
 	hci_dev_unlock(hdev);
 
@@ -1099,11 +1213,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(max_key_size_fops, max_key_size_get,
 static int auth_payload_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	if (val < 0x0001 || val > 0xffff)
 		return -EINVAL;
 
-	hci_dev_lock(hdev);
+	err = hci_dev_lock_killable(hdev);
+	if (err)
+		return err;
 	hdev->auth_payload_timeout = val;
 	hci_dev_unlock(hdev);
 
@@ -1113,8 +1230,10 @@ static int auth_payload_timeout_set(void *data, u64 val)
 static int auth_payload_timeout_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
+	const int err = hci_dev_lock_killable(hdev);
 
-	hci_dev_lock(hdev);
+	if (err)
+		return err;
 	*val = hdev->auth_payload_timeout;
 	hci_dev_unlock(hdev);
 
-- 
2.18.4

