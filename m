Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] gdbus: Fix introspection data for deprecated properties
Date: Thu,  3 Jan 2013 21:46:11 +0200
Message-Id: <1357242371-6752-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357242371-6752-1-git-send-email-luiz.dentz@gmail.com>
References: <1357242371-6752-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix missing </property> when generating introspection xml of deprecated
properties.
---
 gdbus/object.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index b9cb284..729557b 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -210,9 +210,12 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 
 		if (!deprecated)
 			g_string_append_printf(gstr, "/>\n");
-		else
+		else {
 			g_string_append_printf(gstr,
 				G_DBUS_ANNOTATE_DEPRECATED(">\n\t\t\t"));
+
+			g_string_append_printf(gstr, "\t\t</property>\n");
+		}
 	}
 }
 
-- 
1.8.0.1

