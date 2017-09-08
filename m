Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add characteristic property name check
Date: Fri,  8 Sep 2017 15:19:34 -0700
Message-Id: <20170908221934.11910-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If PropertyChanged signal is not emitted due to a change in
characteristic's "Value" property, the characteristic does
not need to be processed.
---
 mesh/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 42506a6..3a39d8f 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1295,8 +1295,9 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		rl_printf("Characteristic property changed %s\n",
 						g_dbus_proxy_get_path(proxy));
 
-		if ((connection.type == CONN_TYPE_PROVISION) ||
-							connection.session_open)
+		if ((strcmp(name, "Value") == 0) &&
+				((connection.type == CONN_TYPE_PROVISION) ||
+						connection.session_open))
 			process_mesh_characteristic(proxy);
 	}
 }
-- 
2.9.5

