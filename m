Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 2/4] gatt: Fix coding style checking boolean
Date: Fri, 21 Mar 2014 16:20:31 -0300
Message-Id: <1395429633-656-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use !foo instead of foo == FALSE
---
 src/gatt-dbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 896accf..ac50008 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -450,9 +450,9 @@ static const GDBusMethodTable methods[] = {
 
 gboolean gatt_dbus_manager_register(void)
 {
-	if (g_dbus_register_interface(btd_get_dbus_connection(),
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 				"/org/bluez", GATT_MGR_IFACE,
-				methods, NULL, NULL, NULL, NULL) == FALSE)
+				methods, NULL, NULL, NULL, NULL))
 		return FALSE;
 
 	proxy_hash = g_hash_table_new_full(g_direct_hash, g_direct_equal,
-- 
1.8.3.1

