Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA970C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A747C2173E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 10:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfLKKem (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:34:42 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45573 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfLKKem (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 05:34:42 -0500
Received: from localhost.localdomain (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id F3372CECD1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2019 11:43:51 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove usage of BT_ERR_RATELIMITED macro
Date:   Wed, 11 Dec 2019 11:34:36 +0100
Message-Id: <20191211103436.15369-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The macro is really not needed and can be replaced with either usage of
bt_err_ratelimited or bt_dev_err_ratelimited.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  4 +---
 net/bluetooth/hci_event.c         | 14 ++++++--------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bd2675266859..e42bb8e03c09 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -138,8 +138,6 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 
-#define BT_ERR_RATELIMITED(fmt, ...) bt_err_ratelimited(fmt "\n", ##__VA_ARGS__)
-
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_warn(hdev, fmt, ...)				\
@@ -152,7 +150,7 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define bt_dev_warn_ratelimited(hdev, fmt, ...)			\
 	bt_warn_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_err_ratelimited(hdev, fmt, ...)			\
-	BT_ERR_RATELIMITED("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+	bt_err_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 
 /* Connection and socket states */
 enum {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c1d3a303d97f..1941f120a376 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5451,7 +5451,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static u8 ext_evt_type_to_legacy(u16 evt_type)
+static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 {
 	if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
 		switch (evt_type) {
@@ -5468,10 +5468,7 @@ static u8 ext_evt_type_to_legacy(u16 evt_type)
 			return LE_ADV_SCAN_RSP;
 		}
 
-		BT_ERR_RATELIMITED("Unknown advertising packet type: 0x%02x",
-				   evt_type);
-
-		return LE_ADV_INVALID;
+		goto invalid;
 	}
 
 	if (evt_type & LE_EXT_ADV_CONN_IND) {
@@ -5491,8 +5488,9 @@ static u8 ext_evt_type_to_legacy(u16 evt_type)
 	    evt_type & LE_EXT_ADV_DIRECT_IND)
 		return LE_ADV_NONCONN_IND;
 
-	BT_ERR_RATELIMITED("Unknown advertising packet type: 0x%02x",
-				   evt_type);
+invalid:
+	bt_dev_err_ratelimited(hdev, "Unknown advertising packet type: 0x%02x",
+			       evt_type);
 
 	return LE_ADV_INVALID;
 }
@@ -5510,7 +5508,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		u16 evt_type;
 
 		evt_type = __le16_to_cpu(ev->evt_type);
-		legacy_evt_type = ext_evt_type_to_legacy(evt_type);
+		legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
 		if (legacy_evt_type != LE_ADV_INVALID) {
 			process_adv_report(hdev, legacy_evt_type, &ev->bdaddr,
 					   ev->bdaddr_type, NULL, 0, ev->rssi,
-- 
2.23.0

