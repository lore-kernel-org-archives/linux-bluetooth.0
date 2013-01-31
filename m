Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] tools: Use device Alias instead of Name
Date: Thu, 31 Jan 2013 09:33:52 -0600
Message-Id: <1359646436-8113-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
References: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

User may have set a different Name using Alias, Alias should always
be set.
---
 tools/mpris-player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index aafa142..b82b5df 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1422,7 +1422,7 @@ static void register_player(GDBusProxy *proxy)
 	if (device == NULL)
 		return;
 
-	if (!g_dbus_proxy_get_property(device, "Name", &iter))
+	if (!g_dbus_proxy_get_property(device, "Alias", &iter))
 		return;
 
 	dbus_message_iter_get_basic(&iter, &name);
-- 
1.8.1

