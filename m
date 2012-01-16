Return-Path: <cyrus@holtmann.org>
From: Yu A Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yu A Wang <arron.wang@intel.com>
Subject: [PATCH 2/2] rfkill: Set device powered even adapter is not created
Date: Mon, 16 Jan 2012 04:02:50 -0500
Message-Id: <1326704570-22854-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/rfkill.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/rfkill.c b/src/rfkill.c
index b40c6e7..5d32fac 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -128,11 +128,18 @@ static gboolean rfkill_event(GIOChannel *chan,
 	if (id < 0)
 		return TRUE;
 
+	DBG("RFKILL unblock for hci%d", id);
+
 	adapter = manager_find_adapter_by_id(id);
-	if (!adapter)
+	if (!adapter) {
+		/*
+		 * If device is rfkilled, the initialize operation
+		 * may failed and adapter is not created, then we
+		 * need to set the device powered directly.
+		 */
+		adapter_ops_set_powered(id, TRUE);
 		return TRUE;
-
-	DBG("RFKILL unblock for hci%d", id);
+	}
 
 	btd_adapter_restore_powered(adapter);
 
-- 
1.7.2.2

