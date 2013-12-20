Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v5 02/14] Bluetooth: Group list_head fields from strcut hci_dev together
Date: Fri, 20 Dec 2013 08:57:43 -0300
Message-Id: <1387540675-2466-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1387540675-2466-1-git-send-email-andre.guedes@openbossa.org>
References: <1387540675-2466-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch groups the list_head fields from struct hci_dev together
and removes empty lines between them.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2ebe772..f970fc2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -257,18 +257,15 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 
-	struct list_head	mgmt_pending;
 
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
-	struct list_head	blacklist;
 
+	struct list_head	mgmt_pending;
+	struct list_head	blacklist;
 	struct list_head	uuids;
-
 	struct list_head	link_keys;
-
 	struct list_head	long_term_keys;
-
 	struct list_head	remote_oob_data;
 
 	struct hci_dev_stats	stat;
-- 
1.8.5.1

