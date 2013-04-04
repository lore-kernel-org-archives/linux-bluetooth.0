Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/17] Bluetooth: Add macros for filter duplicates values
Date: Thu,  4 Apr 2013 20:21:01 -0300
Message-Id: <1365117675-2202-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds macros for filter_duplicates parameter values from
HCI LE Set Scan Enable command. It also fixes le_scan_enable_req
function so it uses the LE_SCAN_FILTER_DUP_ENABLE macro instead of
a magic number.

The LE_SCAN_FILTER_DUP_DISABLE was also defined since it will be
required to properly support the GAP Observer Role.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3f4266b..84c37ab 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -998,6 +998,8 @@ struct hci_cp_le_set_scan_param {
 
 #define LE_SCANNING_DISABLED		0x00
 #define LE_SCANNING_ENABLED		0x01
+#define LE_SCAN_FILTER_DUP_DISABLE	0x00
+#define LE_SCAN_FILTER_DUP_ENABLE	0x01
 
 #define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
 struct hci_cp_le_set_scan_enable {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0686e42..9519ce0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1875,7 +1875,7 @@ static void le_scan_enable_req(struct hci_request *req, unsigned long opt)
 
 	memset(&cp, 0, sizeof(cp));
 	cp.enable = 1;
-	cp.filter_dup = 1;
+	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
-- 
1.8.1.2

