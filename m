Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] src: use btd_error_invalid_args()
Date: Mon, 13 Dec 2010 19:32:59 -0200
Message-Id: <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7ceac8b..0f4dc0b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -605,7 +605,7 @@ static DBusMessage *discover_services(DBusConnection *conn,
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
 						DBUS_TYPE_INVALID) == FALSE)
-		goto fail;
+		return btd_error_invalid_args(msg);
 
 	if (strlen(pattern) == 0) {
 		err = device_browse(device, conn, msg, NULL, FALSE);
-- 
1.7.3.2

