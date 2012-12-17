Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] core: Fix set_pairable to not attempt to power on the adapter
Date: Mon, 17 Dec 2012 17:45:51 +0200
Message-Id: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Pairable flag is completely independent flag for the kernel so we can
reflect this in the D-Bus API.
---
 src/adapter.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 96a23e9..375bff4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -417,29 +417,9 @@ static void set_powered(struct btd_adapter *adapter, gboolean powered,
 static void set_pairable(struct btd_adapter *adapter, gboolean pairable,
 				bool reply, GDBusPendingPropertySet id)
 {
-	int err;
-
-	if (!adapter->connectable)
-		return g_dbus_pending_property_error(id,
-						ERROR_INTERFACE ".NotReady",
-						"Resource Not Ready");
-
 	if (pairable == adapter->pairable)
 		goto done;
 
-	if (!adapter->discoverable)
-		goto store;
-
-	err = set_mode(adapter, MODE_DISCOVERABLE);
-	if (err < 0) {
-		if (reply)
-			g_dbus_pending_property_error(id,
-						ERROR_INTERFACE ".Failed",
-						strerror(-err));
-		return;
-	}
-
-store:
 	mgmt_set_pairable(adapter->dev_id, pairable);
 
 done:
-- 
1.7.11.7

