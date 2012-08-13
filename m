Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 2/8] dbusoob: Simplify remove_remote_data
Date: Mon, 13 Aug 2012 12:46:34 +0200
Message-ID: <1344854800-20972-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
References: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

str2ba already checks if address is valid before converting and returns
-1 in case of failure.

---
 plugins/dbusoob.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 1791342..d259159 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -164,11 +164,9 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 			DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	if (bachk(addr))
+	if (str2ba(addr, &bdaddr) < 0)
 		return btd_error_invalid_args(msg);
 
-	str2ba(addr, &bdaddr);
-
 	if (btd_adapter_remove_remote_oob_data(adapter, &bdaddr))
 		return btd_error_failed(msg, "Request failed");
 
-- 
1.7.9.5

