Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Jun 2015 21:06:26 +0200
From: Mateusz Lemusisk <mrlemux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] client: Display address if calling 'disconnect' without
 arguments
Message-ID: <20150604190626.GA6440@localhost.Belkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before:

[PHILIPS BTM2180]# disconnect
Attempting to disconnect from
Successful disconnected

After:

[PHILIPS BTM2180]# disconnect
Attempting to disconnect from XX:XX:XX:XX:XX:XX
Successful disconnected

---
 client/main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 41e95b2..88ae5ed 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1422,7 +1422,19 @@ static void cmd_disconn(const char *arg)
 		return;
 	}
 
-	rl_printf("Attempting to disconnect from %s\n", arg);
+	if (strlen(arg) == 0) {
+		const char *default_address;
+		DBusMessageIter iter;
+
+		if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
+			default_address = "";
+		else
+			dbus_message_iter_get_basic(&iter, &default_address);
+
+		rl_printf("Attempting to disconnect from %s\n", default_address);
+	} else {
+		rl_printf("Attempting to disconnect from %s\n", arg);
+	}
 }
 
 static void cmd_list_attributes(const char *arg)
-- 
2.4.2

