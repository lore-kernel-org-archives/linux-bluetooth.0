Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] core: Add DisableProfiles entry to main.conf
Date: Fri,  1 Mar 2013 14:26:12 +0200
Message-Id: <1362140773-13672-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com>
References: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This entry can be used to globally disable profiles, this is specially
useful for qualification purposes where some platforms may decide to
only qualify a subset of the supported profiles.
---
 src/hcid.h    |  1 +
 src/main.c    | 10 ++++++++++
 src/main.conf |  4 ++++
 src/profile.c | 24 ++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/src/hcid.h b/src/hcid.h
index ea67cc2..f465a2b 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -32,6 +32,7 @@ struct main_opts {
 	gboolean	reverse_sdp;
 	gboolean	name_resolv;
 	gboolean	debug_keys;
+	char		**disabled_profiles;
 
 	uint16_t	did_source;
 	uint16_t	did_vendor;
diff --git a/src/main.c b/src/main.c
index 1e40ebc..933c20f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -76,6 +76,7 @@ static const char * const supported_options[] = {
 	"ReverseServiceDiscovery",
 	"NameResolving",
 	"DebugKeys",
+	"DisableProfiles"
 };
 
 static GKeyFile *load_config(const char *file)
@@ -263,6 +264,15 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	else
 		main_opts.debug_keys = boolean;
+
+	str = g_key_file_get_string(config, "General", "DisableProfiles", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		main_opts.disabled_profiles = g_strsplit(str, " ", -1);
+		g_free(str);
+	}
 }
 
 static void init_defaults(void)
diff --git a/src/main.conf b/src/main.conf
index a94274a..5c648bf 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -46,3 +46,7 @@
 # makes debug link keys valid only for the duration of the connection
 # that they were created for.
 #DebugKeys = false
+
+# Disable Profile, both driver name and 128 bits UUIDs can be used.
+# By default all profiles are enabled.
+#DisableProfiles = <profile1> <profile2> ...
diff --git a/src/profile.c b/src/profile.c
index 656506a..fc62f02 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -50,6 +50,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "hcid.h"
 
 #define DUN_DEFAULT_CHANNEL	1
 #define SPP_DEFAULT_CHANNEL	3
@@ -610,6 +611,29 @@ void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
 
 int btd_profile_register(struct btd_profile *profile)
 {
+	int i;
+
+	if (main_opts.disabled_profiles == NULL)
+		goto done;
+
+	for (i = 0; main_opts.disabled_profiles[i]; i++) {
+		if (g_strcmp0(main_opts.disabled_profiles[i],
+						profile->name) == 0)
+			return -EPROTONOSUPPORT;
+
+		if (g_strcmp0(main_opts.disabled_profiles[i],
+						profile->local_uuid) == 0)
+			return -EPROTONOSUPPORT;
+
+		if (profile->remote_uuids == NULL)
+			continue;
+
+		if (g_strcmp0(main_opts.disabled_profiles[i],
+						profile->remote_uuids[0]) == 0)
+			return -EPROTONOSUPPORT;
+	}
+
+done:
 	profiles = g_slist_append(profiles, profile);
 	return 0;
 }
-- 
1.8.1.2

