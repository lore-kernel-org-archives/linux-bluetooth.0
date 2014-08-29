Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 7/7] tools/btgatt: Add command argument support.
Date: Fri, 29 Aug 2014 08:34:12 -0700
Message-Id: <1409326452-8534-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1409326452-8534-1-git-send-email-armansito@chromium.org>
References: <1409326452-8534-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added support for command arguments and added the -u and -a flags to the
"services" command to filter services by UUID or by start handle.
---
 tools/btgatt-client.c | 177 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 145 insertions(+), 32 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 445cfc7..0f13d35 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -167,11 +167,42 @@ static void print_uuid(const uint8_t uuid[16])
 	printf("%s\n", uuid_str);
 }
 
+static void print_service(const bt_gatt_service_t *service)
+{
+	const bt_gatt_characteristic_t *chrc;
+	size_t i, j;
+
+	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
+				"end: 0x%04x, uuid: ",
+				service->start_handle, service->end_handle);
+	print_uuid(service->uuid);
+
+	for (i = 0; i < service->num_chrcs; i++) {
+		chrc = service->chrcs + i;
+		printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
+				" - start: 0x%04x, end: 0x%04x, "
+				"value: 0x%04x, props: 0x%02x, uuid: ",
+				chrc->start_handle,
+				chrc->end_handle,
+				chrc->value_handle,
+				chrc->properties);
+		print_uuid(service->chrcs[i].uuid);
+
+		for (j = 0; j < chrc->num_descs; j++) {
+			printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
+						" - handle: 0x%04x, uuid: ",
+						chrc->descs[j].handle);
+			print_uuid(chrc->descs[j].uuid);
+		}
+	}
+
+	printf("\n");
+}
+
 static void print_services(struct client *cli)
 {
 	struct bt_gatt_service_iter iter;
 	bt_gatt_service_t service;
-	const bt_gatt_characteristic_t *chrc;
 
 	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
 		PRLOG("Failed to initialize service iterator\n");
@@ -180,32 +211,41 @@ static void print_services(struct client *cli)
 
 	printf("\n");
 
-	while (bt_gatt_service_iter_next(&iter, &service)) {
-		size_t i, j;
-
-		printf("service - start: 0x%04x, end: 0x%04x, uuid: ",
-				service.start_handle, service.end_handle);
-		print_uuid(service.uuid);
-
-		for (i = 0; i < service.num_chrcs; i++) {
-			chrc = service.chrcs + i;
-			printf("\t  charac - start: 0x%04x, end: 0x%04x, "
-					"value: 0x%04x, props: 0x%02x, uuid: ",
-					chrc->start_handle,
-					chrc->end_handle,
-					chrc->value_handle,
-					chrc->properties);
-			print_uuid(service.chrcs[i].uuid);
-
-			for (j = 0; j < chrc->num_descs; j++) {
-				printf("\t\t  descr - handle: 0x%04x, uuid: ",
-							chrc->descs[j].handle);
-				print_uuid(chrc->descs[j].uuid);
-			}
-		}
+	while (bt_gatt_service_iter_next(&iter, &service))
+		print_service(&service);
+}
+
+static void print_services_by_uuid(struct client *cli, const bt_uuid_t *uuid)
+{
+	struct bt_gatt_service_iter iter;
+	bt_gatt_service_t service;
 
-		printf("\n");
+	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
+		PRLOG("Failed to initialize service iterator\n");
+		return;
 	}
+
+	printf("\n");
+
+	while (bt_gatt_service_iter_next_by_uuid(&iter, uuid->value.u128.data,
+								&service))
+		print_service(&service);
+}
+
+static void print_services_by_handle(struct client *cli, uint16_t handle)
+{
+	struct bt_gatt_service_iter iter;
+	bt_gatt_service_t service;
+
+	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
+		PRLOG("Failed to initialize service iterator\n");
+		return;
+	}
+
+	printf("\n");
+
+	while (bt_gatt_service_iter_next_by_handle(&iter, handle, &service))
+		print_service(&service);
 }
 
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
@@ -224,19 +264,78 @@ static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
 	print_prompt();
 }
 
-static void cmd_services(struct client *cli)
+static void services_usage(void)
+{
+	printf("Usage: services [options]\nOptions:\n"
+		"\t -u, --uuid <uuid>\tService UUID\n"
+		"\t -a, --handle <handle>\tService start handle\n"
+		"\t -h, --help\t\tShow help message\n"
+		"e.g.:\n"
+		"\tservices\n\tservices -u 0x180d\n\tservices -a 0x0009\n");
+}
+
+static void cmd_services(struct client *cli, char *cmd_str)
 {
+	char **ap, *argv[3];
+	int argc = 0;
+
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
 		printf("GATT client not initialized\n");
 		return;
 	}
 
-	print_services(cli);
+	for (ap = argv; (*ap = strsep(&cmd_str, " \t")) != NULL;) {
+		if (**ap == '\0')
+			continue;
+
+		argc++;
+		ap++;
+
+		if (argc > 2) {
+			services_usage();
+			return;
+		}
+	}
+
+	if (!argc) {
+		print_services(cli);
+		return;
+	}
+
+	if (argc != 2) {
+		services_usage();
+		return;
+	}
+
+	if (!strcmp(argv[0], "-u") || !strcmp(argv[0], "--uuid")) {
+		bt_uuid_t tmp, uuid;
+
+		if (bt_string_to_uuid(&tmp, argv[1]) < 0) {
+			printf("Invalid UUID: %s\n", argv[1]);
+			return;
+		}
+
+		bt_uuid_to_uuid128(&tmp, &uuid);
+
+		print_services_by_uuid(cli, &uuid);
+	} else if (!strcmp(argv[0], "-a") || !strcmp(argv[0], "--handle")) {
+		uint16_t handle;
+		char *endptr = NULL;
+
+		handle = strtol(argv[1], &endptr, 16);
+		if (!endptr || *endptr != '\0') {
+			printf("Invalid start handle: %s\n", argv[1]);
+			return;
+		}
+
+		print_services_by_handle(cli, handle);
+	} else
+		services_usage();
 }
 
-static void cmd_help(struct client *cli);
+static void cmd_help(struct client *cli, char *cmd_str);
 
-typedef void (*command_func_t)(struct client *cli);
+typedef void (*command_func_t)(struct client *cli, char *cmd_str);
 
 static struct {
 	char *cmd;
@@ -248,7 +347,7 @@ static struct {
 	{ }
 };
 
-static void cmd_help(struct client *cli)
+static void cmd_help(struct client *cli, char *cmd_str)
 {
 	int i;
 
@@ -262,6 +361,7 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 	ssize_t read;
 	size_t len = 0;
 	char *line = NULL;
+	char *cmd = NULL, *args;
 	struct client *cli = user_data;
 	int i;
 
@@ -273,13 +373,26 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 	if ((read = getline(&line, &len, stdin)) == -1)
 		return;
 
+	if (read <= 1) {
+		cmd_help(cli, NULL);
+		print_prompt();
+		return;
+	}
+
+	line[read-1] = '\0';
+	args = line;
+
+	while ((cmd = strsep(&args, " \t")))
+		if (*cmd != '\0')
+			break;
+
 	for (i = 0; command[i].cmd; i++) {
-		if (strncmp(command[i].cmd, line, read - 1) == 0)
+		if (strcmp(command[i].cmd, cmd) == 0)
 			break;
 	}
 
 	if (command[i].cmd)
-		command[i].func(cli);
+		command[i].func(cli, args);
 	else
 		fprintf(stderr, "Unknown command: %s\n", line);
 
-- 
2.1.0.rc2.206.gedb03e5

