Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] core: Simplify set_powered to not use set_mode
Date: Mon, 17 Dec 2012 17:45:53 +0200
Message-Id: <1355759155-27921-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
References: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/adapter.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ce4e44e..2d81f66 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -373,28 +373,19 @@ static void set_discoverable(struct btd_adapter *adapter,
 static void set_powered(struct btd_adapter *adapter, gboolean powered,
 						GDBusPendingPropertySet id)
 {
-	uint8_t mode;
 	int err;
 
-	if (powered)
-		return set_discoverable(adapter, adapter->discoverable, id);
-
-	mode = MODE_OFF;
-
-	if (mode == adapter->mode) {
-		adapter->global_mode = mode;
+	if (adapter->powered == powered)
 		return g_dbus_pending_property_success(id);
-	}
 
-	err = set_mode(adapter, mode);
+	err = mgmt_set_powered(adapter->dev_id, powered);
 	if (err < 0)
 		return g_dbus_pending_property_error(id,
 						ERROR_INTERFACE ".Failed",
-						strerror(-err));
+						strerror(err));
 
-	adapter->pending_mode = create_session(adapter, NULL, mode,
-					SESSION_TYPE_MODE_GLOBAL, NULL);
-	adapter->pending_mode->prop_id = id;
+	if (powered == FALSE)
+		adapter->off_requested = TRUE;
 }
 
 static void set_pairable(struct btd_adapter *adapter, gboolean pairable,
-- 
1.7.11.7

