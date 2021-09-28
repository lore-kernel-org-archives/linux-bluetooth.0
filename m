Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D171BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 10:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98F0610A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 10:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbhI1K33 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:29:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55806 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbhI1K3X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 06:29:23 -0400
Received: from fedora.. (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2BE3ECECD9
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 12:27:43 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH] Bluetooth: Add framework for AOSP quality report setting
Date:   Tue, 28 Sep 2021 12:27:40 +0200
Message-Id: <20210928102740.40210-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/aosp.c             | 17 +++++++++++++++++
 net/bluetooth/aosp.h             | 13 +++++++++++++
 net/bluetooth/mgmt.c             | 17 ++++++++++++-----
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3b06990fcf16..9c57bbd12aea 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -603,6 +603,7 @@ struct hci_dev {
 
 #if IS_ENABLED(CONFIG_BT_AOSPEXT)
 	bool			aosp_capable;
+	bool			aosp_quality_report;
 #endif
 
 	int (*open)(struct hci_dev *hdev);
diff --git a/net/bluetooth/aosp.c b/net/bluetooth/aosp.c
index a1b7762335a5..1a984bca0880 100644
--- a/net/bluetooth/aosp.c
+++ b/net/bluetooth/aosp.c
@@ -23,6 +23,8 @@ void aosp_do_open(struct hci_dev *hdev)
 	if (IS_ERR(skb))
 		return;
 
+	/* TODO set hdev->aosp_quality_report accordingly */
+
 	kfree_skb(skb);
 }
 
@@ -33,3 +35,18 @@ void aosp_do_close(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "Cleanup of AOSP extension");
 }
+
+int aosp_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	if (!hdev->aosp_quality_report)
+		return -EOPNOTSUPP;
+
+	/* TODO execute HCI command */
+
+	return -EOPNOTSUPP;
+}
+
+bool aosp_has_quality_report(struct hci_dev *hdev)
+{
+	return hdev->aosp_quality_report;
+}
diff --git a/net/bluetooth/aosp.h b/net/bluetooth/aosp.h
index 328fc6d39f70..2fd8886d51b2 100644
--- a/net/bluetooth/aosp.h
+++ b/net/bluetooth/aosp.h
@@ -8,9 +8,22 @@
 void aosp_do_open(struct hci_dev *hdev);
 void aosp_do_close(struct hci_dev *hdev);
 
+bool aosp_has_quality_report(struct hci_dev *hdev);
+int aosp_set_quality_report(struct hci_dev *hdev, bool enable);
+
 #else
 
 static inline void aosp_do_open(struct hci_dev *hdev) {}
 static inline void aosp_do_close(struct hci_dev *hdev) {}
 
+static inline bool aosp_has_quality_report(struct hci_dev *hdev)
+{
+	return false;
+}
+
+static inline int aosp_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3e5283607b97..cd4a0a6da757 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -38,6 +38,7 @@
 #include "mgmt_util.h"
 #include "mgmt_config.h"
 #include "msft.h"
+#include "aosp.h"
 #include "eir.h"
 
 #define MGMT_VERSION	1
@@ -3863,7 +3864,8 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
-	if (hdev && hdev->set_quality_report) {
+	if (hdev && (aosp_has_quality_report(hdev) ||
+		     hdev->set_quality_report)) {
 		if (hci_dev_test_flag(hdev, HCI_QUALITY_REPORT))
 			flags = BIT(0);
 		else
@@ -4125,7 +4127,7 @@ static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 	val = !!cp->param[0];
 	changed = (val != hci_dev_test_flag(hdev, HCI_QUALITY_REPORT));
 
-	if (!hdev->set_quality_report) {
+	if (!aosp_has_quality_report(hdev) && !hdev->set_quality_report) {
 		err = mgmt_cmd_status(sk, hdev->id,
 				      MGMT_OP_SET_EXP_FEATURE,
 				      MGMT_STATUS_NOT_SUPPORTED);
@@ -4133,13 +4135,18 @@ static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (changed) {
-		err = hdev->set_quality_report(hdev, val);
+		if (hdev->set_quality_report)
+			err = hdev->set_quality_report(hdev, val);
+		else
+			err = aosp_set_quality_report(hdev, val);
+
 		if (err) {
 			err = mgmt_cmd_status(sk, hdev->id,
 					      MGMT_OP_SET_EXP_FEATURE,
 					      MGMT_STATUS_FAILED);
 			goto unlock_quality_report;
 		}
+
 		if (val)
 			hci_dev_set_flag(hdev, HCI_QUALITY_REPORT);
 		else
@@ -4151,8 +4158,8 @@ static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 	memcpy(rp.uuid, quality_report_uuid, 16);
 	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
 	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
-	err = mgmt_cmd_complete(sk, hdev->id,
-				MGMT_OP_SET_EXP_FEATURE, 0,
+
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_EXP_FEATURE, 0,
 				&rp, sizeof(rp));
 
 	if (changed)
-- 
2.31.1

