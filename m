Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Seulki Shin <sskcorea@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: SeulKi Shin <sskcorea@gmail.com>
Subject: [PATCH] client: fix calling ad_unregister
Date: Tue, 14 Feb 2017 18:27:50 +0900
Message-Id: <20170214092750.5528-1-sskcorea@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: SeulKi Shin <sskcorea@gmail.com>

ad_register shall only be called in case the advertise command has been
called so registered flag should be checked before calling
UnregisterAdvertisement.

Signed-off-by: SeulKi Shin <sskcorea@gmail.com>
---
 client/advertising.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 62201d5..81fa851 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -317,6 +317,9 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	if (!manager)
 		ad_release(conn);
 
+	if (!registered)
+		return;
+
 	if (g_dbus_proxy_method_call(manager, "UnregisterAdvertisement",
 					unregister_setup, unregister_reply,
 					conn, NULL) == FALSE) {
-- 
2.7.4

