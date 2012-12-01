Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 2/2] input: Remove leftovers from the Input iface removal
Date: Fri, 30 Nov 2012 21:36:57 -0300
Message-Id: <1354322217-11219-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1354322217-11219-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1354322217-11219-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that the Input interface is removed, the only way to connect is
via the Profile interface, so no need to separate the way that
connection is made.
---
 profiles/input/device.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 7538297..8464062 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -64,14 +64,8 @@
 #define FI_FLAG_CONNECTED	1
 
 struct pending_connect {
-	bool local;
-	union {
-		struct {
-			struct btd_profile *profile;
-			btd_profile_cb cb;
-		} p;
-		DBusMessage *msg;
-	};
+	struct btd_profile *profile;
+	btd_profile_cb cb;
 };
 
 struct input_device {
@@ -119,11 +113,8 @@ static void input_device_free(struct input_device *idev)
 	g_free(idev->name);
 	g_free(idev->path);
 
-	if (idev->pending) {
-		if (idev->pending->local)
-			dbus_message_unref(idev->pending->msg);
+	if (idev->pending)
 		g_free(idev->pending);
-	}
 
 	if (idev->ctrl_watch > 0)
 		g_source_remove(idev->ctrl_watch);
@@ -510,8 +501,6 @@ static void connect_reply(struct input_device *idev, int err,
 							const char *err_msg)
 {
 	struct pending_connect *pending = idev->pending;
-	DBusConnection *conn = btd_get_dbus_connection();
-	DBusMessage *reply;
 
 	if (!pending)
 		return;
@@ -521,20 +510,7 @@ static void connect_reply(struct input_device *idev, int err,
 	if (err_msg)
 		error("%s", err_msg);
 
-	if (!pending->local) {
-		pending->p.cb(pending->p.profile, idev->device, err);
-		g_free(pending);
-		return;
-	}
-
-	if (err_msg) {
-		reply = btd_error_failed(idev->pending->msg, err_msg);
-		g_dbus_send_message(conn, reply);
-	} else {
-		g_dbus_send_reply(conn, pending->msg, DBUS_TYPE_INVALID);
-	}
-
-	dbus_message_unref(pending->msg);
+	pending->cb(pending->profile, idev->device, err);
 	g_free(pending);
 }
 
@@ -667,9 +643,8 @@ int input_device_connect(struct btd_device *dev, struct btd_profile *profile,
 		return -EALREADY;
 
 	idev->pending = g_new0(struct pending_connect, 1);
-	idev->pending->local = false;
-	idev->pending->p.profile = profile;
-	idev->pending->p.cb = cb;
+	idev->pending->profile = profile;
+	idev->pending->cb = cb;
 
 	return dev_connect(idev);
 }
-- 
1.8.0

