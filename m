Return-Path: <cyrus@holtmann.org>
From: Alexander Holler <holler@ahsoftware.de>
To: linux-bluetooth@vger.kernel.org
Cc: Alexander Holler <holler@ahsoftware.de>
Subject: [PATCH] bluetoothd: add option to automatically power on the first adapter found
Date: Fri, 10 Apr 2015 18:57:42 +0200
Message-Id: <1428685062-2911-1-git-send-email-holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You want this option if you're using e.g. a bt-keyboard as the only
input device. Other solutions to power on an adapter at startup are
either unreliable or too complicated.

E.g. I had a

	sleep 4
	echo 'power on' | bluetoothctl

in some startup-script. And with an update of bluez from 5.23 to
5.29 Murphy visited me and I had a box without a usable keyboard
because those 4 second haven't been enough anymore.
---
 src/adapter.c | 10 ++++++++--
 src/adapter.h |  2 +-
 src/main.c    |  7 ++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7ffd302..10de028 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -117,6 +117,8 @@ static GSList *adapter_drivers = NULL;
 static GSList *disconnect_list = NULL;
 static GSList *conn_fail_list = NULL;
 
+static bool power_on_first_adapter;
+
 struct link_key_info {
 	bdaddr_t bdaddr;
 	unsigned char key[16];
@@ -7315,8 +7317,11 @@ static int adapter_register(struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
-	if (adapters == NULL)
+	if (adapters == NULL) {
 		adapter->is_default = true;
+		if (power_on_first_adapter)
+			set_mode(adapter, MGMT_OP_SET_POWERED, 0x01);
+	}
 
 	adapters = g_slist_append(adapters, adapter);
 
@@ -8132,8 +8137,9 @@ static void mgmt_debug(const char *str, void *user_data)
 	info("%s%s", prefix, str);
 }
 
-int adapter_init(void)
+int adapter_init(bool _power_on_first_adapter)
 {
+	power_on_first_adapter = _power_on_first_adapter;
 	dbus_conn = btd_get_dbus_connection();
 
 	mgmt_master = mgmt_new_default();
diff --git a/src/adapter.h b/src/adapter.h
index 0c95f5d..96fef5f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -55,7 +55,7 @@ struct oob_handler {
 	void *user_data;
 };
 
-int adapter_init(void);
+int adapter_init(bool _power_on_first_adapter);
 void adapter_cleanup(void);
 void adapter_shutdown(void);
 
diff --git a/src/main.c b/src/main.c
index 4c94a69..d0a301e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -457,6 +457,7 @@ static gboolean option_compat = FALSE;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
 static gboolean option_experimental = FALSE;
+static gboolean option_power_on_first_adapter;
 
 static void free_options(void)
 {
@@ -542,6 +543,7 @@ static GOptionEntry options[] = {
 				"Specify plugins not to load", "NAME,..." },
 	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
 				"Provide deprecated command line interfaces" },
+
 	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
 				"Enable experimental interfaces" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
@@ -549,6 +551,9 @@ static GOptionEntry options[] = {
 				"Run with logging in foreground" },
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit" },
+	{ "power_on_first_adapter", 'o', 0, G_OPTION_ARG_NONE,
+		&option_power_on_first_adapter,
+		"Automatically power on the first adapter found" },
 	{ NULL },
 };
 
@@ -607,7 +612,7 @@ int main(int argc, char *argv[])
 
 	g_dbus_set_flags(gdbus_flags);
 
-	if (adapter_init() < 0) {
+	if (adapter_init(option_power_on_first_adapter) < 0) {
 		error("Adapter handling initialization failed");
 		exit(1);
 	}
-- 
2.1.0

