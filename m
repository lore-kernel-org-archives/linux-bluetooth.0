Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v10 1/6] Bluetooth: preparation for new connect procedure
Date: Fri,  7 Aug 2015 20:22:51 +0200
Message-Id: <1438971776-10903-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, when trying to connect to already paired device that just
rotated its RPA MAC address, old address would be used and connection
would fail. In order to fix that, kernel must scan and receive
advertisement with fresh RPA before connecting.

This patch adds some fields to hci_conn_params, in preparation to new
connect procedure.

explicit_connect will be used to override any current auto_connect action,
and connect to device when ad is received.

HCI_AUTO_CONN_EXPLICIT was added to auto_connect enum. When this value
will be used, explicit connect is the only action, and params can be
removed after successful connection.

HCI_CONN_SCANNING is added to hci_conn flags. When it's set, connect is
scan phase. It gets cleared when advertisement is received, and
HCI_OP_LE_CREATE_CONN is sent.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2a6b091..c8d2b5a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -512,9 +512,11 @@ struct hci_conn_params {
 		HCI_AUTO_CONN_DIRECT,
 		HCI_AUTO_CONN_ALWAYS,
 		HCI_AUTO_CONN_LINK_LOSS,
+		HCI_AUTO_CONN_EXPLICIT,
 	} auto_connect;
 
 	struct hci_conn *conn;
+	bool explicit_connect;
 };
 
 extern struct list_head hci_dev_list;
@@ -639,6 +641,7 @@ enum {
 	HCI_CONN_DROP,
 	HCI_CONN_PARAM_REMOVAL_PEND,
 	HCI_CONN_NEW_LINK_KEY,
+	HCI_CONN_SCANNING,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
-- 
2.1.4

