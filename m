Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] core: Fix set_discoverable to not attempt to power on the adapter
Date: Mon, 17 Dec 2012 17:45:52 +0200
Message-Id: <1355759155-27921-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
References: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Discoverable flag is completely independent flag for the kernel so we
can reflect this in the D-Bus API.
---
 src/adapter.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 375bff4..ce4e44e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -366,25 +366,8 @@ done:
 static void set_discoverable(struct btd_adapter *adapter,
 			gboolean discoverable, GDBusPendingPropertySet id)
 {
-	uint8_t mode;
-	int err;
-
-	mode = discoverable ? MODE_DISCOVERABLE : MODE_CONNECTABLE;
-
-	if (mode == adapter->mode) {
-		adapter->global_mode = mode;
-		return g_dbus_pending_property_success(id);
-	}
-
-	err = set_mode(adapter, mode);
-	if (err < 0)
-		return g_dbus_pending_property_error(id,
-						ERROR_INTERFACE ".Failed",
-						strerror(-err));
-
-	adapter->pending_mode = create_session(adapter, NULL, mode,
-					SESSION_TYPE_MODE_GLOBAL, NULL);
-	adapter->pending_mode->prop_id = id;
+	mgmt_set_discoverable(adapter->dev_id, discoverable, 0);
+	g_dbus_pending_property_success(id);
 }
 
 static void set_powered(struct btd_adapter *adapter, gboolean powered,
-- 
1.7.11.7

