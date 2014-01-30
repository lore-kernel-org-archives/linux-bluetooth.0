Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v6 02/14] Bluetooth: Group list_head fields from strcut hci_dev together
Date: Thu, 30 Jan 2014 18:22:05 -0300
Message-Id: <1391116937-28217-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch groups the list_head fields from struct hci_dev together
and removes empty lines between them.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 77a4cb5..197413b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -259,18 +259,15 @@ struct hci_dev {
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
1.8.5.3

