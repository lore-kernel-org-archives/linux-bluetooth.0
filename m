Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] core: Make use of g_dbus_close
Date: Mon, 19 Nov 2012 10:46:26 +0200
Message-Id: <1353314786-11427-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
References: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/main.c b/src/main.c
index 414849a..1ca6015 100644
--- a/src/main.c
+++ b/src/main.c
@@ -383,6 +383,7 @@ static void disconnect_dbus(void)
 
 	set_dbus_connection(NULL);
 
+	g_dbus_close(conn);
 	dbus_connection_unref(conn);
 }
 
-- 
1.7.11.7

