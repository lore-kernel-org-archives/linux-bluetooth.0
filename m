Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/client: Add option to initialize only IVI roles
Date: Thu, 27 Nov 2014 18:04:39 +0100
Message-Id: <1417107880-13118-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417107880-13118-1-git-send-email-szymon.janc@tieto.com>
References: <1417107880-13118-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds 'ivi' option for haltest. With this option only IVI roles
will be initialized. Running haltest without options will initialize
only non-ivi roles.
---
 android/client/haltest.c | 59 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index add1978..0eaa43d 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -336,7 +336,8 @@ static void usage(void)
 		"Usage:\n");
 	printf("\thaltest [options]\n");
 	printf("options:\n"
-		"\t-n, --no-init          Don't call init for interfaces\n"
+		"\t-i  --ivi              Initialize only IVI interfaces\n"
+		"\t-n, --no-init          Don't initialize any interfaces\n"
 		"\t    --version          Print version\n"
 		"\t-h, --help             Show help options\n");
 }
@@ -352,19 +353,21 @@ static void print_version(void)
 
 static const struct option main_options[] = {
 	{ "no-init", no_argument, NULL, 'n' },
+	{ "ivi",     no_argument, NULL, 'i' },
 	{ "help",    no_argument, NULL, 'h' },
 	{ "version", no_argument, NULL, PRINT_VERSION },
 	{ NULL }
 };
 
 static bool no_init = false;
+static bool ivi_only = false;
 
 static void parse_command_line(int argc, char *argv[])
 {
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "nh", main_options, NULL);
+		opt = getopt_long(argc, argv, "inh", main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -372,6 +375,9 @@ static void parse_command_line(int argc, char *argv[])
 		case 'n':
 			no_init = true;
 			break;
+		case 'i':
+			ivi_only = true;
+			break;
 		case 'h':
 			usage();
 			exit(0);
@@ -386,23 +392,29 @@ static void parse_command_line(int argc, char *argv[])
 	}
 }
 
-static void init(void)
-{
-	static const char * const inames[] = {
-		BT_PROFILE_HANDSFREE_ID,
-		BT_PROFILE_ADVANCED_AUDIO_ID,
-		BT_PROFILE_AV_RC_ID,
-		BT_PROFILE_HEALTH_ID,
-		BT_PROFILE_HIDHOST_ID,
-		BT_PROFILE_PAN_ID,
-		BT_PROFILE_GATT_ID,
-		BT_PROFILE_SOCKETS_ID,
+static const char * const interface_names[] = {
+	BT_PROFILE_HANDSFREE_ID,
+	BT_PROFILE_ADVANCED_AUDIO_ID,
+	BT_PROFILE_AV_RC_ID,
+	BT_PROFILE_HEALTH_ID,
+	BT_PROFILE_HIDHOST_ID,
+	BT_PROFILE_PAN_ID,
+	BT_PROFILE_GATT_ID,
+	BT_PROFILE_SOCKETS_ID,
+	NULL
+};
+
+static const char * const ivi_interface_inames[] = {
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-		BT_PROFILE_HANDSFREE_CLIENT_ID,
-		BT_PROFILE_MAP_CLIENT_ID,
-		BT_PROFILE_AV_RC_CTRL_ID,
+	BT_PROFILE_HANDSFREE_CLIENT_ID,
+	BT_PROFILE_MAP_CLIENT_ID,
+	BT_PROFILE_AV_RC_CTRL_ID,
 #endif
-	};
+	NULL
+};
+
+static void init(const char * const *inames)
+{
 	const struct method *m;
 	const char *argv[4];
 	char init_audio[] = "audio init";
@@ -416,9 +428,10 @@ static void init(void)
 
 	m = get_interface_method("bluetooth", "get_profile_interface");
 
-	for (i = 0; i < NELEM(inames); ++i) {
-		argv[2] = inames[i];
+	while (*inames) {
+		argv[2] = *inames;
 		m->func(3, argv);
+		inames++;
 	}
 
 	/* Init what is available to init */
@@ -437,8 +450,12 @@ int main(int argc, char **argv)
 
 	terminal_setup();
 
-	if (!no_init)
-		init();
+	if (!no_init) {
+		if (ivi_only)
+			init(ivi_interface_inames);
+		else
+			init(interface_names);
+	}
 
 	history_restore(".haltest_history");
 
-- 
1.9.1

