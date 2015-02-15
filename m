Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 4/4] core: Add support for Multi Profile Specification
Date: Sun, 15 Feb 2015 16:43:33 +0100
Message-Id: <1424015013-8608-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423928093-21850-1-git-send-email-szymon.janc@tieto.com>
References: <1423928093-21850-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds new main.conf configure option named MultiProfile. It allows
to enable MPSD and MPMD scenarios for MPS. By default MPS is disabled.
---
 src/main.c    | 23 +++++++++++++++++++++++
 src/main.conf |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/src/main.c b/src/main.c
index b3140d0..54cbeb0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -69,6 +69,9 @@
 struct main_opts main_opts;
 static GKeyFile *main_conf;
 
+static bool mps_mpsd = false;
+static bool mps_mpmd = false;
+
 static const char * const supported_options[] = {
 	"Name",
 	"Class",
@@ -81,6 +84,7 @@ static const char * const supported_options[] = {
 	"NameResolving",
 	"DebugKeys",
 	"ControllerMode",
+	"MultiProfile",
 };
 
 GKeyFile *btd_get_main_conf(void)
@@ -307,6 +311,22 @@ static void parse_config(GKeyFile *config)
 		main_opts.mode = get_mode(str);
 		g_free(str);
 	}
+
+	str = g_key_file_get_string(config, "General", "MultiProfile", &err);
+	if (err) {
+		g_clear_error(&err);
+	} else {
+		DBG("MultiProfile=%s", str);
+
+		if (!strcmp(str, "single")) {
+			mps_mpsd = true;
+		} else if (!strcmp(str, "multiple")) {
+			mps_mpsd = true;
+			mps_mpmd = true;
+		}
+
+		g_free(str);
+	}
 }
 
 static void init_defaults(void)
@@ -599,6 +619,9 @@ int main(int argc, char *argv[])
 		register_device_id(main_opts.did_source, main_opts.did_vendor,
 				main_opts.did_product, main_opts.did_version);
 
+	if (mps_mpsd)
+		register_mps(mps_mpmd);
+
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
 	 * best order of how to init various subsystems of the Bluetooth
diff --git a/src/main.conf b/src/main.conf
index d4d6ab0..9be90af 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -52,6 +52,13 @@
 # Possible values: "dual", "bredr", "le"
 #ControllerMode = dual
 
+# Enables Multi Profile Specification support. This allows to specify if
+# system supports only Multiple Profiles Single Device (MPSD) configuration
+# or both Multiple Profiles Single Device (MPSD) and Multiple Profiles Multiple
+# Devices (MPMD) configurations.
+# Possible values: "off", "single", "multiple"
+#MultiProfile = off
+
 #[Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
1.9.3

