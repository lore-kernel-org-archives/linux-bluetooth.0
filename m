Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/3] Fix adapter->up declaration
Date: Mon, 12 Sep 2011 09:06:30 -0300
Message-Id: <1315829192-30924-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Minor code convention fix. This patch fix "up" variable declaration in
adapter structure. Convert "up" to gboolean making it compliant with
its usage.
---
 src/adapter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bb7f5bc..7a5f7b3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -105,7 +105,7 @@ struct service_auth {
 
 struct btd_adapter {
 	uint16_t dev_id;
-	int up;
+	gboolean up;
 	char *path;			/* adapter object path */
 	bdaddr_t bdaddr;		/* adapter Bluetooth Address */
 	uint32_t dev_class;		/* Class of Device */
@@ -2428,7 +2428,7 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
 				"Powered", DBUS_TYPE_BOOLEAN, &powered);
 
-	adapter->up = 0;
+	adapter->up = FALSE;
 	adapter->scan_mode = SCAN_DISABLED;
 	adapter->mode = MODE_OFF;
 	adapter->state = STATE_IDLE;
-- 
1.7.6

