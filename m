Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 10:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FF32082F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 10:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFQKmL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:42:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44876 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgFQKmL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 06:42:11 -0400
Received: from localhost.localdomain (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id E6DDDCECD5
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 12:52:01 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/14] Bluetooth: Replace wakeable list with flag
Date:   Wed, 17 Jun 2020 12:41:54 +0200
Message-Id: <71a3186aa0d3d08981e2e3289e5669c737c79c21.1592390407.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592390407.git.marcel@holtmann.org>
References: <cover.1592390407.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Since the classic device list now supports flags, convert the wakeable
list into a flag on the existing device list.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 11 ++++++++++-
 net/bluetooth/hci_core.c         |  1 -
 net/bluetooth/hci_request.c      | 12 ++++++++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 95a3935325bb..0643c737ba85 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -143,6 +143,16 @@ struct bdaddr_list_with_flags {
 	u32 current_flags;
 };
 
+enum hci_conn_flags {
+	HCI_CONN_FLAG_REMOTE_WAKEUP,
+	HCI_CONN_FLAG_MAX
+};
+
+#define hci_conn_test_flag(nr, flags) ((flags) & (1U << nr))
+
+/* Make sure number of flags doesn't exceed sizeof(current_flags) */
+static_assert(HCI_CONN_FLAG_MAX < 32);
+
 struct bt_uuid {
 	struct list_head list;
 	u8 uuid[16];
@@ -463,7 +473,6 @@ struct hci_dev {
 	struct list_head	mgmt_pending;
 	struct list_head	blacklist;
 	struct list_head	whitelist;
-	struct list_head	wakeable;
 	struct list_head	uuids;
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a471bec2731..8e01afb2ee8c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3499,7 +3499,6 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->blacklist);
 	INIT_LIST_HEAD(&hdev->whitelist);
-	INIT_LIST_HEAD(&hdev->wakeable);
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index a7f572ad38ef..a5b53d3ea508 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -968,15 +968,19 @@ static void hci_req_clear_event_filter(struct hci_request *req)
 
 static void hci_req_set_event_filter(struct hci_request *req)
 {
-	struct bdaddr_list *b;
+	struct bdaddr_list_with_flags *b;
 	struct hci_cp_set_event_filter f;
 	struct hci_dev *hdev = req->hdev;
-	u8 scan;
+	u8 scan = SCAN_DISABLED;
 
 	/* Always clear event filter when starting */
 	hci_req_clear_event_filter(req);
 
-	list_for_each_entry(b, &hdev->wakeable, list) {
+	list_for_each_entry(b, &hdev->whitelist, list) {
+		if (!hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
+					b->current_flags))
+			continue;
+
 		memset(&f, 0, sizeof(f));
 		bacpy(&f.addr_conn_flt.bdaddr, &b->bdaddr);
 		f.flt_type = HCI_FLT_CONN_SETUP;
@@ -985,9 +989,9 @@ static void hci_req_set_event_filter(struct hci_request *req)
 
 		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
 		hci_req_add(req, HCI_OP_SET_EVENT_FLT, sizeof(f), &f);
+		scan = SCAN_PAGE;
 	}
 
-	scan = !list_empty(&hdev->wakeable) ? SCAN_PAGE : SCAN_DISABLED;
 	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-- 
2.26.2

