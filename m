Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 13/14] main: Add PreferPANoverDUN configuration switch
Date: Thu, 31 May 2012 15:43:37 +0200
Message-Id: <1338471818-20894-14-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 src/hcid.h    |    1 +
 src/main.c    |    8 ++++++++
 src/main.conf |    5 +++++
 3 files changed, 14 insertions(+)

diff --git a/src/hcid.h b/src/hcid.h
index 1e5e15a..2e46a44 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -39,6 +39,7 @@ struct main_opts {
 	gboolean	name_resolv;
 	gboolean	debug_keys;
 	gboolean	gatt_enabled;
+	gboolean	prefer_pan;
 
 	uint8_t		mode;
 
diff --git a/src/main.c b/src/main.c
index 286baa0..8ae9f6a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -241,6 +241,14 @@ static void parse_config(GKeyFile *config)
 	else
 		main_opts.gatt_enabled = boolean;
 
+	boolean = g_key_file_get_boolean(config, "General",
+						"PreferPANoverDUN", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else
+		main_opts.prefer_pan = boolean;
+
 	main_opts.link_mode = HCI_LM_ACCEPT;
 
 	main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
diff --git a/src/main.conf b/src/main.conf
index 787ef4f..eda01ec 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -62,3 +62,8 @@ DebugKeys = false
 
 # Enable the GATT functionality. Default is false
 EnableGatt = false
+
+# If a device supports both DUN and PAN at the same time, ignore the
+# DUN profile. Only PAN will be exposed through the D-Bus API in this
+# case. The default is false
+PreferPANoverDUN = false
-- 
1.7.10.130.g36e6c

