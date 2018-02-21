Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] client: Don't auto register agent on non-interactive mode
Date: Wed, 21 Feb 2018 16:14:53 +0200
Message-Id: <20180221141456.6656-5-luiz.dentz@gmail.com>
In-Reply-To: <20180221141456.6656-1-luiz.dentz@gmail.com>
References: <20180221141456.6656-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There is no use to register an agent when on non-interactive mode.
---
 client/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 38df75828..962f3383b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -520,7 +520,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		if (!agent_manager) {
 			agent_manager = proxy;
 
-			if (auto_register_agent)
+			if (auto_register_agent &&
+					!bt_shell_get_env("NON_INTERACTIVE"))
 				agent_register(dbus_conn, agent_manager,
 							auto_register_agent);
 		}
-- 
2.14.3

