Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v1 1/3] main: Add IngoreDUN configuration switch
Date: Thu, 24 May 2012 12:00:16 +0200
Message-Id: <1337853618-7261-2-git-send-email-wagi@monom.org>
In-Reply-To: <1337853618-7261-1-git-send-email-wagi@monom.org>
References: <1337853618-7261-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 src/hcid.h    |    1 +
 src/main.c    |    9 +++++++++
 src/main.conf |    5 +++++
 3 files changed, 15 insertions(+)

diff --git a/src/hcid.h b/src/hcid.h
index 1e5e15a..2564467 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -39,6 +39,7 @@ struct main_opts {
 	gboolean	name_resolv;
 	gboolean	debug_keys;
 	gboolean	gatt_enabled;
+	gboolean	ignore_dun;
 
 	uint8_t		mode;
 
diff --git a/src/main.c b/src/main.c
index b062b4a..240326d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -245,6 +245,14 @@ static void parse_config(GKeyFile *config)
 	else
 		main_opts.gatt_enabled = boolean;
 
+	boolean = g_key_file_get_boolean(config, "General",
+						"IgnoreDUN", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else
+		main_opts.ignore_dun = boolean;
+
 	main_opts.link_mode = HCI_LM_ACCEPT;
 
 	main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
@@ -262,6 +270,7 @@ static void init_defaults(void)
 	main_opts.remember_powered = TRUE;
 	main_opts.reverse_sdp = TRUE;
 	main_opts.name_resolv = TRUE;
+	main_opts.ignore_dun = TRUE;
 
 	if (gethostname(main_opts.host_name, sizeof(main_opts.host_name) - 1) < 0)
 		strcpy(main_opts.host_name, "noname");
diff --git a/src/main.conf b/src/main.conf
index 787ef4f..676999d 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -62,3 +62,8 @@ DebugKeys = false
 
 # Enable the GATT functionality. Default is false
 EnableGatt = false
+
+# If a device supports both DUN and PAN at the same time, ignore the
+# DUN profile. Only PAN will be exposed through the D-Bus API in this
+# case. The default is true
+IgnoreDUN = true
-- 
1.7.10.130.g36e6c

