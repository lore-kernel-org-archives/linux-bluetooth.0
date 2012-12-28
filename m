Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/11] core: Add command line switch for enabling experimental interfaces
Date: Fri, 28 Dec 2012 14:51:05 +0200
Message-Id: <1356699069-5469-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable passing --experimental/-E to enable experimental interfaces
---
 src/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/main.c b/src/main.c
index 4a67e0f..2e8ba34 100644
--- a/src/main.c
+++ b/src/main.c
@@ -368,6 +368,7 @@ static gchar *option_noplugin = NULL;
 static gboolean option_compat = FALSE;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
+static gboolean option_experimental = FALSE;
 
 static void free_options(void)
 {
@@ -453,6 +454,8 @@ static GOptionEntry options[] = {
 				"Specify plugins not to load", "NAME,..." },
 	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
 				"Provide deprecated command line interfaces" },
+	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
+				"Enable experimental interfaces" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Run with logging in foreground" },
@@ -467,6 +470,7 @@ int main(int argc, char *argv[])
 	GError *err = NULL;
 	uint16_t sdp_mtu = 0;
 	uint32_t sdp_flags = 0;
+	int gdbus_flags = 0;
 	GKeyFile *config;
 	guint signal, watchdog;
 	const char *watchdog_usec;
@@ -517,6 +521,11 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (option_experimental)
+		gdbus_flags = G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+
+	g_dbus_set_flags(gdbus_flags);
+
 	if (option_compat == TRUE)
 		sdp_flags |= SDP_SERVER_COMPAT;
 
-- 
1.8.0.1

