Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Nagaraj D R <nagaraj.dr@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>,
        Nagaraj D R <nagaraj.dr@samsung.com>
Subject: [PATCH] Fix possible invalid memory access
Date: Fri, 18 May 2018 09:28:16 +0530
Message-id: <1526615896-23631-1-git-send-email-nagaraj.dr@samsung.com>
References: <CGME20180518035824epcas2p356c2382c482a8fcdd0598816d4dee070@epcas2p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Uninitialized data is read from local variable 'addr'
---
 client/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/client/main.c b/client/main.c
index 54bd537..73e77c4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1774,12 +1774,12 @@ static void cmd_disconn(int argc, char *argv[])
 
 	if (argc < 2 || strlen(argv[1]) == 0) {
 		DBusMessageIter iter;
-		const char *addr;
 
-		if (g_dbus_proxy_get_property(proxy, "Address", &iter) == TRUE)
+		if (g_dbus_proxy_get_property(proxy, "Address", &iter) == TRUE) {
+			const char *addr;
 			dbus_message_iter_get_basic(&iter, &addr);
-
-		bt_shell_printf("Attempting to disconnect from %s\n", addr);
+			bt_shell_printf("Attempting to disconnect from %s\n", addr);
+		}
 	} else
 		bt_shell_printf("Attempting to disconnect from %s\n", argv[1]);
 }
-- 
1.9.1

