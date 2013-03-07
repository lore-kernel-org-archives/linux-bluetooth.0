Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3 v2] core: Add DisableProfiles entry to main.conf
Date: Thu,  7 Mar 2013 11:41:24 +0200
Message-Id: <1362649284-24335-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362649284-24335-1-git-send-email-luiz.dentz@gmail.com>
References: <1362649284-24335-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This entry can be used to globally disable profiles, this is specially
useful for qualification purposes where some platforms may decide to
only qualify a subset of the supported profiles.
---
 src/main.c    | 17 +++++++++++++++--
 src/main.conf |  4 ++++
 src/profile.c | 22 +++++++++++++++++++++-
 src/profile.h |  2 +-
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/src/main.c b/src/main.c
index 1e40ebc..62a88cd 100644
--- a/src/main.c
+++ b/src/main.c
@@ -65,6 +65,7 @@
 #define SHUTDOWN_GRACE_SECONDS 10
 
 struct main_opts main_opts;
+static char **disabled_profiles = NULL;
 
 static const char * const supported_options[] = {
 	"Name",
@@ -76,6 +77,7 @@ static const char * const supported_options[] = {
 	"ReverseServiceDiscovery",
 	"NameResolving",
 	"DebugKeys",
+	"DisableProfiles"
 };
 
 static GKeyFile *load_config(const char *file)
@@ -263,6 +265,15 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	else
 		main_opts.debug_keys = boolean;
+
+	str = g_key_file_get_string(config, "General", "DisableProfiles", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		disabled_profiles = g_strsplit(str, " ", -1);
+		g_free(str);
+	}
 }
 
 static void init_defaults(void)
@@ -538,7 +549,7 @@ int main(int argc, char *argv[])
 
 	btd_device_init();
 	btd_agent_init();
-	btd_profile_init();
+	btd_profile_init(disabled_profiles);
 
 	if (option_experimental)
 		gdbus_flags = G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
@@ -600,8 +611,10 @@ int main(int argc, char *argv[])
 
 	g_main_loop_unref(event_loop);
 
-	if (config)
+	if (config) {
 		g_key_file_free(config);
+		g_strfreev(disabled_profiles);
+	}
 
 	disconnect_dbus();
 
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
index 656506a..e05ec51 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -585,6 +585,7 @@ static GSList *custom_props = NULL;
 
 static GSList *profiles = NULL;
 static GSList *ext_profiles = NULL;
+static char **blacklist = NULL;
 
 void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
 								void *data)
@@ -610,6 +611,23 @@ void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
 
 int btd_profile_register(struct btd_profile *profile)
 {
+	int i;
+
+	if (blacklist == NULL)
+		goto done;
+
+	for (i = 0; blacklist[i]; i++) {
+		if (g_pattern_match_simple(blacklist[i], profile->name))
+			return -EPROTONOSUPPORT;
+
+		if (profile->local_uuid == NULL)
+			continue;
+
+		if (strcasecmp(blacklist[i], profile->local_uuid) == 0)
+			return -EPROTONOSUPPORT;
+	}
+
+done:
 	profiles = g_slist_append(profiles, profile);
 	return 0;
 }
@@ -2335,8 +2353,10 @@ bool btd_profile_remove_custom_prop(const char *uuid, const char *name)
 	return false;
 }
 
-void btd_profile_init(void)
+void btd_profile_init(char **disabled_profiles)
 {
+	blacklist = disabled_profiles;
+
 	g_dbus_register_interface(btd_get_dbus_connection(),
 				"/org/bluez", "org.bluez.ProfileManager1",
 				methods, NULL, NULL, NULL, NULL);
diff --git a/src/profile.h b/src/profile.h
index d858925..75b40fb 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -74,5 +74,5 @@ bool btd_profile_add_custom_prop(const char *uuid, const char *type,
 					void *user_data);
 bool btd_profile_remove_custom_prop(const char *uuid, const char *name);
 
-void btd_profile_init(void);
+void btd_profile_init(char **disabled_profiles);
 void btd_profile_cleanup(void);
-- 
1.8.1.4

