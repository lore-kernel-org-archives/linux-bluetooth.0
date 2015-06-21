Return-Path: <cyrus@holtmann.org>
From: Mateusz Lemusisk <mrlemux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mateusz Lemusisk <mrlemux@gmail.com>
Subject: [PATCH v2] client: Display address if calling 'disconnect' without arguments
Date: Sun, 21 Jun 2015 17:08:52 +0200
Message-Id: <1434899332-5208-1-git-send-email-mrlemux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simplified the patch
---
 client/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/client/main.c b/client/main.c
index 41e95b2..f1a600f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1421,7 +1421,12 @@ static void cmd_disconn(const char *arg)
 		rl_printf("Failed to disconnect\n");
 		return;
 	}
+	if (strlen(arg) == 0) {
+		DBusMessageIter iter;
 
+		if (g_dbus_proxy_get_property(proxy, "Address", &iter) == TRUE)
+		    dbus_message_iter_get_basic(&iter, &arg);
+	}
 	rl_printf("Attempting to disconnect from %s\n", arg);
 }
 
-- 
2.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
