Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core: Fix leaking disconnect message
Date: Tue, 10 Dec 2013 10:41:17 +0200
Message-Id: <1386664877-10137-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1386664877-10137-1-git-send-email-luiz.dentz@gmail.com>
References: <1386664877-10137-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a disconnect message is pending return an error since currently the
code cannot process it in parallel.
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 953a338..18543ee 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1434,6 +1434,9 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (!service)
 		return btd_error_invalid_args(msg);
 
+	if (dev->disconnect)
+		return btd_error_in_progress(msg);
+
 	dev->disconnect = dbus_message_ref(msg);
 
 	err = btd_service_disconnect(service);
-- 
1.8.3.1

