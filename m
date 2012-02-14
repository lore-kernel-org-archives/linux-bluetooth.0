Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/4] device: Fix invalid D-Bus calls during Reverse GATT Discovery
Date: Tue, 14 Feb 2012 12:06:03 -0400
Message-Id: <1329235564-12471-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no D-Bus client active during Reverse GATT Discovery, therefore
BlueZ should not send any D-Bus replies. This fixes errors reported by
D-Bus internal checks:

process 453: arguments to dbus_message_new_method_return() were
incorrect, assertion "method_call != NULL" failed in file dbus-message.c
line 1111.
---
 src/device.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index b581564..b410a63 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1799,9 +1799,12 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	GSList *l, *uuids = NULL;
 
 	if (status) {
-		DBusMessage *reply;
-		reply = btd_error_failed(req->msg, att_ecode2str(status));
-		g_dbus_send_message(req->conn, reply);
+		if (req->msg) {
+			DBusMessage *reply;
+			reply = btd_error_failed(req->msg,
+							att_ecode2str(status));
+			g_dbus_send_message(req->conn, reply);
+		}
 		goto done;
 	}
 
@@ -1821,7 +1824,8 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	g_slist_free(uuids);
 
 	services_changed(device);
-	create_device_reply(device, req);
+	if (req->msg)
+		create_device_reply(device, req);
 
 	store_services(device);
 
-- 
1.7.5.4

