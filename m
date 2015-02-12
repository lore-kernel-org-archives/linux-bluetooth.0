Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] tools/btgatt-client: Add support for set/get security on the link
Date: Thu, 12 Feb 2015 18:00:08 +0100
Message-Id: <1423760408-31020-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423760408-31020-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423760408-31020-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 9416791..2d893c3 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1072,6 +1072,66 @@ static void cmd_unregister_notify(struct client *cli, char *cmd_str)
 	printf("Unregistered notify handler with id: %u\n", id);
 }
 
+static void set_sec_level_usage(void)
+{
+	printf("Usage: set_sec_level <level>\n"
+		"level: 1-3\n"
+		"e.g.:\n"
+		"\tset-sec-level 2\n");
+}
+
+static void cmd_set_sec_level(struct client *cli, char *cmd_str)
+{
+	char *argvbuf[1];
+	char **argv = argvbuf;
+	int argc = 0;
+	char *endptr = NULL;
+	int level;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 1, argv, &argc)) {
+		printf("Too many arguments\n");
+		set_sec_level_usage();
+		return;
+	}
+
+	if (argc < 1) {
+		set_sec_level_usage();
+		return;
+	}
+
+	level = strtol(argv[0], &endptr, 0);
+	if (!endptr || *endptr != '\0' || level < 1 || level > 3) {
+		printf("Invalid level: %s\n", argv[0]);
+		return;
+	}
+
+	if (bt_gatt_client_set_sec_level(cli->gatt, level) < 0)
+		printf("Could not set sec level\n");
+	else
+		printf("Setting security level %d success\n", level);
+}
+
+static void cmd_get_sec_level(struct client *cli, char *cmd_str)
+{
+	int level;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	level = bt_gatt_client_get_sec_level(cli->gatt);
+	if (level < 0)
+		printf("Could not set sec level\n");
+	else
+		printf("Security level: %u\n", level);
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -1100,6 +1160,10 @@ static struct {
 			"\tSubscribe to not/ind from a characteristic" },
 	{ "unregister-notify", cmd_unregister_notify,
 						"Unregister a not/ind session"},
+	{ "set-sec-level", cmd_set_sec_level,
+					"Set security level on le connection"},
+	{ "get-sec-level", cmd_get_sec_level,
+					"Get security level on le connection"},
 	{ }
 };
 
-- 
1.8.4

