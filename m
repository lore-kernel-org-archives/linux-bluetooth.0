Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] core: Move plugin_init and plugin_cleanup to plugin.h
Date: Mon,  4 Mar 2013 15:58:29 +0200
Message-Id: <1362405510-8685-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362405510-8685-1-git-send-email-luiz.dentz@gmail.com>
References: <1362405510-8685-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/input/manager.c  | 2 ++
 profiles/scanparam/scan.c | 2 ++
 src/hcid.h                | 3 ---
 src/main.c                | 1 +
 src/plugin.h              | 2 ++
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 6ed12ee..e1e1057 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -32,6 +32,8 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include <glib.h>
+
 #include "log.h"
 #include "plugin.h"
 
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 268bdc8..8428816 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -31,6 +31,8 @@
 
 #include <bluetooth/bluetooth.h>
 
+#include <glib.h>
+
 #include "lib/uuid.h"
 #include "log.h"
 #include "plugin.h"
diff --git a/src/hcid.h b/src/hcid.h
index ea67cc2..294e844 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -41,9 +41,6 @@ struct main_opts {
 
 extern struct main_opts main_opts;
 
-gboolean plugin_init(const char *enable, const char *disable);
-void plugin_cleanup(void);
-
 void rfkill_init(void);
 void rfkill_exit(void);
 
diff --git a/src/main.c b/src/main.c
index 62a88cd..23d598f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -56,6 +56,7 @@
 #include "agent.h"
 #include "profile.h"
 #include "systemd.h"
+#include "plugin.h"
 
 #define BLUEZ_NAME "org.bluez"
 
diff --git a/src/plugin.h b/src/plugin.h
index 89c7b85..f281cd9 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -39,6 +39,8 @@ struct bluetooth_plugin_desc {
 		struct bluetooth_plugin_desc __bluetooth_builtin_ ## name = { \
 			#name, version, priority, init, exit \
 		};
+gboolean plugin_init(const char *enable, const char *disable);
+void plugin_cleanup(void);
 #else
 #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
 		extern struct btd_debug_desc __start___debug[] \
-- 
1.8.1.2

