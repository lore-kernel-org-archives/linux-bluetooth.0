Return-Path: <SRS0=iTYz=VN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5596C76192
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D4C20880
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 18:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfGPSeq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:34:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47315 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPSeq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jul 2019 14:34:46 -0400
Received: from localhost.localdomain (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 32F64CECB0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2019 20:43:19 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add debug setting for changing minimum encryption key size
Date:   Tue, 16 Jul 2019 20:34:41 +0200
Message-Id: <20190716183441.27501-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For testing and qualification purposes it is useful to allow changing
the minimum encryption key size value that the host stack is going to
enforce. This adds a new debugfs setting min_encrypt_key_size to achieve
this functionality.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_debugfs.c      | 31 +++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c       |  2 +-
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2bc0aa49a84b..b689aceb636b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -278,6 +278,7 @@ struct hci_dev {
 	__u16		conn_info_min_age;
 	__u16		conn_info_max_age;
 	__u16		auth_payload_timeout;
+	__u8		min_enc_key_size;
 	__u8		ssp_debug_mode;
 	__u8		hw_error_code;
 	__u32		clock;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b9585e7d9d2e..04bc79359a17 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3202,6 +3202,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->conn_info_min_age = DEFAULT_CONN_INFO_MIN_AGE;
 	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
 	hdev->auth_payload_timeout = DEFAULT_AUTH_PAYLOAD_TIMEOUT;
+	hdev->min_enc_key_size = HCI_MIN_ENC_KEY_SIZE;
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index bb67f4a5479a..402e2cc54044 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -433,6 +433,35 @@ static int auto_accept_delay_set(void *data, u64 val)
 	return 0;
 }
 
+static int min_encrypt_key_size_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 1 || val > 16)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->min_enc_key_size = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int min_encrypt_key_size_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->min_enc_key_size;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(min_encrypt_key_size_fops,
+			min_encrypt_key_size_get,
+			min_encrypt_key_size_set, "%llu\n");
+
 static int auto_accept_delay_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
@@ -545,6 +574,8 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
 	if (lmp_ssp_capable(hdev)) {
 		debugfs_create_file("ssp_debug_mode", 0444, hdev->debugfs,
 				    hdev, &ssp_debug_mode_fops);
+		debugfs_create_file("min_encrypt_key_size", 0644, hdev->debugfs,
+				    hdev, &min_encrypt_key_size_fops);
 		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
 				    hdev, &auto_accept_delay_fops);
 	}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cc506fe99b4d..dfc1edb168b7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1361,7 +1361,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
 	 * actually encrypted before enforcing a key size.
 	 */
 	return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
-		hcon->enc_key_size >= HCI_MIN_ENC_KEY_SIZE);
+		hcon->enc_key_size >= hcon->hdev->min_enc_key_size);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
-- 
2.21.0

