Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 06/10] tools/btgatt-client: Added the "read-value" command.
Date: Wed,  3 Sep 2014 12:46:07 -0700
Message-Id: <1409773571-28417-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the "read-value" command which sends a simple read request to the
specified handle.
---
 tools/btgatt-client.c | 94 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 12 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 0f13d35..e0c48be 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -274,9 +274,27 @@ static void services_usage(void)
 		"\tservices\n\tservices -u 0x180d\n\tservices -a 0x0009\n");
 }
 
+static bool parse_args(char *str, int expected_argc,  char **argv, int *argc)
+{
+	char **ap;
+
+	for (ap = argv; (*ap = strsep(&str, " \t")) != NULL;) {
+		if (**ap == '\0')
+			continue;
+
+		(*argc)++;
+		ap++;
+
+		if (*argc > expected_argc)
+			return false;
+	}
+
+	return true;
+}
+
 static void cmd_services(struct client *cli, char *cmd_str)
 {
-	char **ap, *argv[3];
+	char *argv[3];
 	int argc = 0;
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
@@ -284,17 +302,9 @@ static void cmd_services(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	for (ap = argv; (*ap = strsep(&cmd_str, " \t")) != NULL;) {
-		if (**ap == '\0')
-			continue;
-
-		argc++;
-		ap++;
-
-		if (argc > 2) {
-			services_usage();
-			return;
-		}
+	if (!parse_args(cmd_str, 2, argv, &argc)) {
+		services_usage();
+		return;
 	}
 
 	if (!argc) {
@@ -333,6 +343,64 @@ static void cmd_services(struct client *cli, char *cmd_str)
 		services_usage();
 }
 
+static void read_value_usage(void)
+{
+	printf("Usage: read-value <value_handle>\n");
+}
+
+static void read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	int i;
+
+	if (!success) {
+		PRLOG("\nRead request failed: 0x%02x\n", att_ecode);
+		return;
+	}
+
+	printf("\nRead value");
+
+	if (length == 0) {
+		PRLOG(": 0 bytes\n");
+		return;
+	}
+
+	printf(" (%u bytes): ", length);
+
+	for (i = 0; i < length; i++)
+		printf("%02x ", value[i]);
+
+	PRLOG("\n");
+}
+
+static void cmd_read_value(struct client *cli, char *cmd_str)
+{
+	char *argv[2];
+	int argc = 0;
+	uint16_t handle;
+	char *endptr = NULL;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
+		read_value_usage();
+		return;
+	}
+
+	handle = strtol(argv[0], &endptr, 16);
+	if (!endptr || *endptr != '\0' || !handle) {
+		printf("Invalid value handle: %s\n", argv[0]);
+		return;
+	}
+
+	if (!bt_gatt_client_read_value(cli->gatt, handle, read_cb,
+								NULL, NULL))
+		printf("Failed to initiate read value procedure\n");
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -344,6 +412,8 @@ static struct {
 } command[] = {
 	{ "help", cmd_help, "\tDisplay help message" },
 	{ "services", cmd_services, "\tShow discovered services" },
+	{ "read-value", cmd_read_value,
+				"\tRead a characteristic or descriptor Value" },
 	{ }
 };
 
-- 
2.1.0.rc2.206.gedb03e5

