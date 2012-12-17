Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/11] adapter: Use discoverable memeber instead of scan_mode
Date: Mon, 17 Dec 2012 15:44:54 +0100
Message-ID: <1355755498-2700-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Where possible use discoverable memeber instead of checking scan_mode
against SCAN_INQUIRY flag.
---
 src/adapter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 473c9cf..2af0d4f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -424,7 +424,7 @@ static void set_pairable(struct btd_adapter *adapter, gboolean pairable,
 	if (pairable == adapter->pairable)
 		goto done;
 
-	if (!(adapter->scan_mode & SCAN_INQUIRY))
+	if (!adapter->discoverable)
 		goto store;
 
 	err = set_mode(adapter, MODE_DISCOVERABLE);
@@ -687,7 +687,7 @@ static void set_discoverable_timeout(struct btd_adapter *adapter,
 	if (adapter->discov_timeout == timeout && timeout == 0)
 		return g_dbus_pending_property_success(id);
 
-	if (adapter->scan_mode & SCAN_INQUIRY)
+	if (adapter->discoverable)
 		mgmt_set_discoverable(adapter->dev_id, TRUE, timeout);
 
 	adapter->discov_timeout = timeout;
@@ -1163,7 +1163,7 @@ static gboolean adapter_property_get_discoverable(
 	struct btd_adapter *adapter = data;
 	dbus_bool_t value;
 
-	value = adapter->scan_mode & SCAN_INQUIRY ? TRUE : FALSE;
+	value = adapter->discoverable ? TRUE : FALSE;
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
 
 	return TRUE;
@@ -1928,7 +1928,7 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 		adapter_remove_connection(adapter, device);
 	}
 
-	if (adapter->scan_mode == (SCAN_PAGE | SCAN_INQUIRY))
+	if (adapter->discoverable)
 		emit_discoverable = true;
 
 	if (adapter->connectable && adapter->pairable == TRUE)
@@ -3183,6 +3183,7 @@ void adapter_mode_changed(struct btd_adapter *adapter, bool connectable,
 	case SCAN_DISABLED:
 		adapter->mode = MODE_OFF;
 		adapter->connectable = false;
+		adapter->discoverable = FALSE;
 		break;
 	case SCAN_PAGE:
 		adapter->mode = MODE_CONNECTABLE;
-- 
1.8.0

