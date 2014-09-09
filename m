Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 6/7] tools/btgatt-client: Add "unregister-notify" command.
Date: Tue,  9 Sep 2014 10:04:08 -0700
Message-Id: <1410282249-22004-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1410282249-22004-1-git-send-email-armansito@chromium.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the "unregister-notify" command which can be used to test the
bt_gatt_client_unregister_notify function.
---
 tools/btgatt-client.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index f95cc9c..d2d997e 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -770,6 +770,42 @@ static void cmd_register_notify(struct client *cli, char *cmd_str)
 	printf("\n");
 }
 
+static void unregister_notify_usage(void)
+{
+	printf("Usage: unregister-notify <notify id>\n");
+}
+
+static void cmd_unregister_notify(struct client *cli, char *cmd_str)
+{
+	char *argv[2];
+	int argc = 0;
+	unsigned int id;
+	char *endptr = NULL;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
+		unregister_notify_usage();
+		return;
+	}
+
+	id = strtol(argv[0], &endptr, 10);
+	if (!endptr || *endptr != '\0' || !id) {
+		printf("Invalid notify id: %s\n", argv[0]);
+		return;
+	}
+
+	if (!bt_gatt_client_unregister_notify(cli->gatt, id)) {
+		printf("Failed to unregister notify handler with id: %u\n", id);
+		return;
+	}
+
+	printf("Unregistered notify handler with id: %u\n", id);
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -791,6 +827,8 @@ static struct {
 			"Write long characteristic or descriptor value" },
 	{ "register-notify", cmd_register_notify,
 			"\tSubscribe to not/ind from a characteristic" },
+	{ "unregister-notify", cmd_unregister_notify,
+						"Unregister a not/ind session"},
 	{ }
 };
 
-- 
2.1.0.rc2.206.gedb03e5

