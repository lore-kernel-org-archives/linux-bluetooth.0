Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] adapter: Don't use adapter_get_path to access adapter path
Date: Fri, 5 Oct 2012 14:54:38 +0200
Message-ID: <1349441679-18557-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
References: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use struct btd_adapter directly to access path member.

---
 src/adapter.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 885d232..2f8c8a3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3183,7 +3183,6 @@ done:
 
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 {
-	const gchar *path = adapter_get_path(adapter);
 	gboolean discoverable, pairable;
 
 	DBG("old 0x%02x new 0x%02x", adapter->scan_mode, scan_mode);
@@ -3218,7 +3217,7 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 					ADAPTER_INTERFACE, "Pairable",
 					DBUS_TYPE_BOOLEAN, &pairable);
 
-	emit_property_changed(path,
+	emit_property_changed(adapter->path,
 				ADAPTER_INTERFACE, "Discoverable",
 				DBUS_TYPE_BOOLEAN, &discoverable);
 
-- 
1.7.9.5

