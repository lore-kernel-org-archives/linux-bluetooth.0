Return-Path: <cyrus@holtmann.org>
From: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Check uuid in disconnect profile.
Date: Mon, 21 Jan 2013 14:44:25 +0100
Message-Id: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the user calls Device1.DisconnectProfile with an invalid profile
uuid disconnect_profile still tries to parse the uuid resulting in
a SIGSEGV

---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 3675616..1771c0f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1270,6 +1270,9 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 
 	uuid = bt_name2string(pattern);
 
+	if (uuid == NULL)
+		return btd_error_invalid_args(msg);
+
 	p = find_connectable_profile(dev, uuid);
 	g_free(uuid);
 
-- 
1.8.1

