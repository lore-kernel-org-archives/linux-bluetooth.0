Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76621C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjCWKmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCWKlo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10EC2F065
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so84355105ede.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVU42B4Dr0BnvC5xEKXdM1x0vLNCEDJsJBUynT6eTLE=;
        b=Vb/f/BlTQu9/NtCC1vaXn0y7PfFNpXfxG29jrOBjRicYxnPWxZ5LpDyEy+k/RxhM/z
         MoYlpUmGUfaqa3FpDRzuTDW7OdeL67D4wcHbJkAUnhPcZfR2XFbjkV2AOs2uP1EPjHIG
         WtnN/F5ALNjZKUJhrwrWrrErt8wwZwV4ywzvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVU42B4Dr0BnvC5xEKXdM1x0vLNCEDJsJBUynT6eTLE=;
        b=N6avEMpCkq01w43COid+2jp+JgIL/bLXpV0DHkvN3DQCaoOhtPosyJVSf3RoCP2dtm
         ir8dEbokmYRlVUcDhAfeEa/TgL9dy4xkz1URGqCFk2bnvNQ7VQlH1EaD0gFpUR5/Uy+1
         jDuSa9o38PTonwr7yQ/sMkhGA5w/1yugDJb36IT214hgYSqukz5l09IzJLsKaB5BiNg2
         uUinp9TfUg0HkdlSiIUoCf6ITklTHi7Av8O+zEwlQJzwTsAGzj/Y2VcAAHXBGHCUg4yb
         w508h32z/oEG/1LVSbMxqybY/D0DMMG7FTEyADtRqRqb7KTm/JCY3cycKmLg5hhrdhpY
         s2lA==
X-Gm-Message-State: AO0yUKX6r5ilw3xPmENCCH42z3JgY7sLGe/SqTAGYGSrpX9pG3h8fAhx
        VvpWOGJCV6bSyEqWFS7gcjwGRrXmS/2xu6XrbWg=
X-Google-Smtp-Source: AK7set/+59+Hz/c5j9Klcx+0Ma90xbOMSVJ8FxncdH212IPi9ZxX/rJ9kF16iUNPhEfIGhOI8MCQsQ==
X-Received: by 2002:a05:6402:1013:b0:4fb:98e2:3df8 with SMTP id c19-20020a056402101300b004fb98e23df8mr9887656edu.27.1679567921018;
        Thu, 23 Mar 2023 03:38:41 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:40 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 4/9] btgatt-client: Rewrite to use bt_shell
Date:   Thu, 23 Mar 2023 11:38:30 +0100
Message-Id: <20230323103835.571037-5-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.tools        |    2 +-
 src/shared/shell.h    |    1 +
 tools/btgatt-client.c | 1087 ++++++++++++++++-------------------------
 3 files changed, 412 insertions(+), 678 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index df4cad065..6125e57f7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -315,7 +315,7 @@ tools_ibeacon_LDADD = src/libshared-mainloop.la
 
 tools_btgatt_client_SOURCES = tools/btgatt-client.c src/uuid-helper.c
 tools_btgatt_client_LDADD = src/libshared-mainloop.la \
-						lib/libbluetooth-internal.la
+						lib/libbluetooth-internal.la -lreadline
 
 tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
 tools_btgatt_server_LDADD = src/libshared-mainloop.la \
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 87fb5c415..8793835c0 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -15,6 +15,7 @@
 #define COLOR_GREEN	"\001\x1B[0;92m\002"
 #define COLOR_YELLOW	"\001\x1B[0;93m\002"
 #define COLOR_BLUE	"\001\x1B[0;94m\002"
+#define COLOR_MAGENTA	"\x1B[0;95m"
 #define COLOR_BOLDGRAY	"\001\x1B[1;30m\002"
 #define COLOR_BOLDWHITE	"\001\x1B[1;37m\002"
 #define COLOR_HIGHLIGHT	"\001\x1B[1;39m\002"
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 2a0cb5181..ecfe3f3f1 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -28,6 +28,7 @@
 #include "lib/uuid.h"
 
 #include "src/shared/mainloop.h"
+#include "src/shared/shell.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
 #include "src/shared/queue.h"
@@ -37,19 +38,29 @@
 #define ATT_CID 4
 #define ATT_PSM 31
 
-#define PRLOG(...) \
-	printf(__VA_ARGS__); print_prompt();
-
-#define COLOR_OFF	"\x1B[0m"
-#define COLOR_RED	"\x1B[0;91m"
-#define COLOR_GREEN	"\x1B[0;92m"
-#define COLOR_YELLOW	"\x1B[0;93m"
-#define COLOR_BLUE	"\x1B[0;94m"
-#define COLOR_MAGENTA	"\x1B[0;95m"
-#define COLOR_BOLDGRAY	"\x1B[1;30m"
-#define COLOR_BOLDWHITE	"\x1B[1;37m"
+#define MAX_LEN_LINE 512
 
+struct client *cli;
 static bool verbose = false;
+static bool shell_running = false;
+
+#define print(fmt, arg...) do { \
+	if (shell_running) \
+		bt_shell_printf(fmt "\n", ## arg); \
+	else \
+		printf(fmt "\n", ## arg); \
+} while (0)
+
+#define error(fmt, arg...) do { \
+	if (shell_running) \
+		bt_shell_printf(COLOR_RED fmt "\n" COLOR_OFF, ## arg); \
+	else \
+		fprintf(stderr, COLOR_RED fmt "\n" COLOR_OFF, ## arg); \
+} while (0)
+
+#define append(str, fmt, arg...) do { \
+	sprintf(strchr(str, '\0'), fmt, ## arg); \
+} while (0)
 
 struct client {
 	int fd;
@@ -60,10 +71,11 @@ struct client {
 	unsigned int reliable_session_id;
 };
 
-static void print_prompt(void)
+static void update_prompt(void)
 {
-	printf(COLOR_BLUE "[GATT client]" COLOR_OFF "# ");
-	fflush(stdout);
+	char str[32];
+	sprintf(str, COLOR_BLUE "[GATT client]" COLOR_OFF "# ");
+	bt_shell_set_prompt(str);
 }
 
 static const char *ecode_to_string(uint8_t ecode)
@@ -116,7 +128,7 @@ static const char *ecode_to_string(uint8_t ecode)
 
 static void att_disconnect_cb(int err, void *user_data)
 {
-	printf("Device disconnected: %s\n", strerror(err));
+	print("Device disconnected: %s", strerror(err));
 
 	mainloop_quit();
 }
@@ -125,14 +137,14 @@ static void att_debug_cb(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	PRLOG(COLOR_BOLDGRAY "%s" COLOR_BOLDWHITE "%s\n" COLOR_OFF, prefix, str);
+	print(COLOR_BOLDGRAY "%s" COLOR_BOLDWHITE "%s" COLOR_OFF, prefix, str);
 }
 
 static void gatt_debug_cb(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	PRLOG(COLOR_GREEN "%s%s\n" COLOR_OFF, prefix, str);
+	print(COLOR_GREEN "%s%s" COLOR_OFF, prefix, str);
 }
 
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data);
@@ -150,7 +162,7 @@ static void log_service_event(struct gatt_db_attribute *attr, const char *str)
 
 	gatt_db_attribute_get_service_handles(attr, &start, &end);
 
-	PRLOG("%s - UUID: %s start: 0x%04x end: 0x%04x\n", str, uuid_str,
+	print("%s - UUID: %s start: 0x%04x end: 0x%04x", str, uuid_str,
 								start, end);
 }
 
@@ -170,20 +182,20 @@ static struct client *client_create(int fd, uint16_t mtu)
 
 	cli = new0(struct client, 1);
 	if (!cli) {
-		fprintf(stderr, "Failed to allocate memory for client\n");
+		error("Failed to allocate memory for client");
 		return NULL;
 	}
 
 	cli->att = bt_att_new(fd, false);
 	if (!cli->att) {
-		fprintf(stderr, "Failed to initialze ATT transport layer\n");
+		error("Failed to initialze ATT transport layer");
 		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
 	}
 
 	if (!bt_att_set_close_on_unref(cli->att, true)) {
-		fprintf(stderr, "Failed to set up ATT transport layer\n");
+		error("Failed to set up ATT transport layer");
 		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
@@ -191,7 +203,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 
 	if (!bt_att_register_disconnect(cli->att, att_disconnect_cb, NULL,
 								NULL)) {
-		fprintf(stderr, "Failed to set ATT disconnect handler\n");
+		error("Failed to set ATT disconnect handler");
 		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
@@ -200,7 +212,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 	cli->fd = fd;
 	cli->db = gatt_db_new();
 	if (!cli->db) {
-		fprintf(stderr, "Failed to create GATT database\n");
+		error("Failed to create GATT database");
 		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
@@ -208,7 +220,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 
 	cli->gatt = bt_gatt_client_new(cli->db, cli->att, mtu, 0);
 	if (!cli->gatt) {
-		fprintf(stderr, "Failed to create GATT client\n");
+		error("Failed to create GATT client");
 		gatt_db_unref(cli->db);
 		bt_att_unref(cli->att);
 		free(cli);
@@ -225,8 +237,8 @@ static struct client *client_create(int fd, uint16_t mtu)
 									NULL);
 	}
 
-	bt_gatt_client_ready_register(cli->gatt, ready_cb, cli, NULL);
-	bt_gatt_client_set_service_changed(cli->gatt, service_changed_cb, cli,
+	bt_gatt_client_ready_register(cli->gatt, ready_cb, NULL, NULL);
+	bt_gatt_client_set_service_changed(cli->gatt, service_changed_cb, NULL,
 									NULL);
 
 	/* bt_gatt_client already holds a reference */
@@ -242,7 +254,7 @@ static void client_destroy(struct client *cli)
 	free(cli);
 }
 
-static void print_uuid(const bt_uuid_t *uuid)
+static void append_uuid(char *str, const bt_uuid_t *uuid)
 {
 	char uuid_str[MAX_LEN_UUID_STR];
 	bt_uuid_t uuid128;
@@ -250,15 +262,15 @@ static void print_uuid(const bt_uuid_t *uuid)
 	bt_uuid_to_uuid128(uuid, &uuid128);
 	bt_uuid_to_string(&uuid128, uuid_str, sizeof(uuid_str));
 
-	printf("%s\n", uuid_str);
+	append(str, "%s", uuid_str);
 }
 
 static void print_incl(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct client *cli = user_data;
 	uint16_t handle, start, end;
 	struct gatt_db_attribute *service;
 	bt_uuid_t uuid;
+	char line[MAX_LEN_LINE] = {0};
 
 	if (!gatt_db_attribute_get_incl_data(attr, &handle, &start, &end))
 		return;
@@ -269,18 +281,21 @@ static void print_incl(struct gatt_db_attribute *attr, void *user_data)
 
 	gatt_db_attribute_get_service_uuid(service, &uuid);
 
-	printf("\t  " COLOR_GREEN "include" COLOR_OFF " - handle: "
+	append(line, "\t  " COLOR_GREEN "include" COLOR_OFF " - handle: "
 					"0x%04x, - start: 0x%04x, end: 0x%04x,"
 					"uuid: ", handle, start, end);
-	print_uuid(&uuid);
+	append_uuid(line, &uuid);
+	print("%s", line);
 }
 
 static void print_desc(struct gatt_db_attribute *attr, void *user_data)
 {
-	printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
+	char line[MAX_LEN_LINE] = {0};
+	append(line, "\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
 					" - handle: 0x%04x, uuid: ",
 					gatt_db_attribute_get_handle(attr));
-	print_uuid(gatt_db_attribute_get_type(attr));
+	append_uuid(line, gatt_db_attribute_get_type(attr));
+	print("%s", line);
 }
 
 static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
@@ -289,6 +304,7 @@ static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
 	uint8_t properties;
 	uint16_t ext_prop;
 	bt_uuid_t uuid;
+	char line[MAX_LEN_LINE] = {0};
 
 	if (!gatt_db_attribute_get_char_data(attr, &handle,
 								&value_handle,
@@ -297,170 +313,133 @@ static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
 								&uuid))
 		return;
 
-	printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
+	append(line, "\t  " COLOR_YELLOW "charac" COLOR_OFF
 				" - start: 0x%04x, value: 0x%04x, "
 				"props: 0x%02x, ext_props: 0x%04x, uuid: ",
 				handle, value_handle, properties, ext_prop);
-	print_uuid(&uuid);
+	append_uuid(line, &uuid);
+	print("%s", line);
 
 	gatt_db_service_foreach_desc(attr, print_desc, NULL);
 }
 
 static void print_service(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct client *cli = user_data;
 	uint16_t start, end;
 	bool primary;
 	bt_uuid_t uuid;
+	char line[MAX_LEN_LINE] = {0};
 
 	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
 									&uuid))
 		return;
 
-	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
+	append(line, COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
 				"end: 0x%04x, type: %s, uuid: ",
 				start, end, primary ? "primary" : "secondary");
-	print_uuid(&uuid);
+	append_uuid(line, &uuid);
+	print("%s", line);
 
-	gatt_db_service_foreach_incl(attr, print_incl, cli);
+	gatt_db_service_foreach_incl(attr, print_incl, NULL);
 	gatt_db_service_foreach_char(attr, print_chrc, NULL);
-
-	printf("\n");
 }
 
 static void print_services(struct client *cli)
 {
-	printf("\n");
-
-	gatt_db_foreach_service(cli->db, NULL, print_service, cli);
+	gatt_db_foreach_service(cli->db, NULL, print_service, NULL);
 }
 
-static void print_services_by_uuid(struct client *cli, const bt_uuid_t *uuid)
+static void print_services_by_uuid(const bt_uuid_t *uuid)
 {
-	printf("\n");
-
-	gatt_db_foreach_service(cli->db, uuid, print_service, cli);
+	gatt_db_foreach_service(cli->db, uuid, print_service, NULL);
 }
 
-static void print_services_by_handle(struct client *cli, uint16_t handle)
+static void print_services_by_handle(uint16_t handle)
 {
-	printf("\n");
-
 	/* TODO: Filter by handle */
 	gatt_db_foreach_service(cli->db, NULL, print_service, cli);
 }
 
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
 {
-	struct client *cli = user_data;
-
 	if (!success) {
-		PRLOG("GATT discovery procedures failed - error code: 0x%02x\n",
+		error("GATT discovery procedures failed - error code: 0x%02x",
 								att_ecode);
 		return;
 	}
 
-	PRLOG("GATT discovery procedures complete\n");
+	print("GATT discovery procedures complete");
 
 	print_services(cli);
-	print_prompt();
 }
 
 static void service_changed_cb(uint16_t start_handle, uint16_t end_handle,
 								void *user_data)
 {
-	struct client *cli = user_data;
-
-	printf("\nService Changed handled - start: 0x%04x end: 0x%04x\n",
+	print("Service Changed handled - start: 0x%04x end: 0x%04x",
 						start_handle, end_handle);
 
-	gatt_db_foreach_service_in_range(cli->db, NULL, print_service, cli,
+	gatt_db_foreach_service_in_range(cli->db, NULL, print_service, NULL,
 						start_handle, end_handle);
-	print_prompt();
-}
-
-static void services_usage(void)
-{
-	printf("Usage: services [options]\nOptions:\n"
-		"\t -u, --uuid <uuid>\tService UUID\n"
-		"\t -a, --handle <handle>\tService start handle\n"
-		"\t -h, --help\t\tShow help message\n"
-		"e.g.:\n"
-		"\tservices\n\tservices -u 0x180d\n\tservices -a 0x0009\n");
 }
 
-static bool parse_args(char *str, int expected_argc,  char **argv, int *argc)
-{
-	char **ap;
-
-	for (ap = argv; (*ap = strsep(&str, " \t")) != NULL;) {
-		if (**ap == '\0')
-			continue;
-
-		(*argc)++;
-		ap++;
-
-		if (*argc > expected_argc)
-			return false;
-	}
-
-	return true;
-}
+static struct option services_options[] = {
+	{ "uuid",	1, 0, 'u' },
+	{ "handle",	1, 0, 'a' },
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
 
-static void cmd_services(struct client *cli, char *cmd_str)
+static void cmd_services(int argc, char **argv)
 {
-	char *argv[3];
-	int argc = 0;
+	int opt;
+	bool use_uuid = false;
+	bt_uuid_t tmp, uuid;
+	uint16_t handle = 0;
+	char *endptr = NULL;
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
-	if (!parse_args(cmd_str, 2, argv, &argc)) {
-		services_usage();
-		return;
-	}
-
-	if (!argc) {
-		print_services(cli);
+		print("GATT client not initialized");
 		return;
 	}
 
-	if (argc != 2) {
-		services_usage();
-		return;
-	}
-
-	if (!strcmp(argv[0], "-u") || !strcmp(argv[0], "--uuid")) {
-		bt_uuid_t tmp, uuid;
-
-		if (bt_string_to_uuid(&tmp, argv[1]) < 0) {
-			printf("Invalid UUID: %s\n", argv[1]);
-			return;
-		}
-
-		bt_uuid_to_uuid128(&tmp, &uuid);
-
-		print_services_by_uuid(cli, &uuid);
-	} else if (!strcmp(argv[0], "-a") || !strcmp(argv[0], "--handle")) {
-		uint16_t handle;
-		char *endptr = NULL;
-
-		handle = strtol(argv[1], &endptr, 0);
-		if (!endptr || *endptr != '\0') {
-			printf("Invalid start handle: %s\n", argv[1]);
-			return;
+	while ((opt = getopt_long(argc, argv, "u:a:", services_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'u':
+			if (bt_string_to_uuid(&tmp, optarg) < 0) {
+				error("Invalid UUID: %s", optarg);
+				optind = 0;
+				return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			}
+			bt_uuid_to_uuid128(&tmp, &uuid);
+			use_uuid = true;
+			break;
+		case 'a':
+			handle = strtol(optarg, &endptr, 0);
+			if (!endptr || *endptr != '\0') {
+				error("Invalid start handle: %s", optarg);
+				optind = 0;
+				return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			}
+			break;
+		case 'h':
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		default:
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
+	}
 
-		print_services_by_handle(cli, handle);
-	} else
-		services_usage();
-}
+	optind = 0;
 
-static void read_multiple_usage(void)
-{
-	printf("Usage: read-multiple <handle_1> <handle_2> ...\n");
+	if (use_uuid)
+		print_services_by_uuid(&uuid);
+	else
+		print_services_by_handle(handle);
 }
 
 static void read_multiple_cb(bool success, uint8_t att_ecode,
@@ -468,43 +447,37 @@ static void read_multiple_cb(bool success, uint8_t att_ecode,
 					void *user_data)
 {
 	int i;
+	char line[MAX_LEN_LINE] = {0};
 
 	if (!success) {
-		PRLOG("\nRead multiple request failed: 0x%02x\n", att_ecode);
+		error("Read multiple request failed: 0x%02x", att_ecode);
 		return;
 	}
 
-	printf("\nRead multiple value (%u bytes):", length);
+	append(line, "Read multiple value (%u bytes):", length);
 
 	for (i = 0; i < length; i++)
-		printf("%02x ", value[i]);
+		append(line, "%02x ", value[i]);
 
-	PRLOG("\n");
+	print("%s", line);
 }
 
-static void cmd_read_multiple(struct client *cli, char *cmd_str)
+static void cmd_read_multiple(int argc, char **argv)
 {
-	int argc = 0;
 	uint16_t *value;
-	char *argv[512];
 	int i;
 	char *endptr = NULL;
 
-	if (!parse_args(cmd_str, sizeof(argv), argv, &argc) || argc < 2) {
-		read_multiple_usage();
-		return;
-	}
-
 	value = malloc(sizeof(uint16_t) * argc);
 	if (!value) {
-		printf("Failed to construct value\n");
+		error("Failed to construct value");
 		return;
 	}
 
-	for (i = 0; i < argc; i++) {
+	for (i = 1; i < argc; i++) {
 		value[i] = strtol(argv[i], &endptr, 0);
 		if (endptr == argv[i] || *endptr != '\0' || !value[i]) {
-			printf("Invalid value byte: %s\n", argv[i]);
+			error("Invalid value byte: %s", argv[i]);
 			free(value);
 			return;
 		}
@@ -512,133 +485,98 @@ static void cmd_read_multiple(struct client *cli, char *cmd_str)
 
 	if (!bt_gatt_client_read_multiple(cli->gatt, value, argc,
 						read_multiple_cb, NULL, NULL))
-		printf("Failed to initiate read multiple procedure\n");
+		error("Failed to initiate read multiple procedure");
 
 	free(value);
 }
 
-static void read_value_usage(void)
-{
-	printf("Usage: read-value <value_handle>\n");
-}
-
 static void read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
 	int i;
+	char line[MAX_LEN_LINE] = {0};
 
 	if (!success) {
-		PRLOG("\nRead request failed: %s (0x%02x)\n",
+		error("Read request failed: %s (0x%02x)",
 				ecode_to_string(att_ecode), att_ecode);
 		return;
 	}
 
-	printf("\nRead value");
+	append(line, "Read value");
 
 	if (length == 0) {
-		PRLOG(": 0 bytes\n");
+		print("%s: 0 bytes", line);
 		return;
 	}
 
-	printf(" (%u bytes): ", length);
+	append(line, " (%u bytes): ", length);
 
 	for (i = 0; i < length; i++)
-		printf("%02x ", value[i]);
+		append(line, "%02x ", value[i]);
 
-	PRLOG("\n");
+	print("%s", line);
 }
 
-static void cmd_read_value(struct client *cli, char *cmd_str)
+static void cmd_read_value(int argc, char **argv)
 {
-	char *argv[2];
-	int argc = 0;
 	uint16_t handle;
 	char *endptr = NULL;
 
-	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
-		read_value_usage();
-		return;
-	}
-
-	handle = strtol(argv[0], &endptr, 0);
+	handle = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || !handle) {
-		printf("Invalid value handle: %s\n", argv[0]);
+		error("Invalid value handle: %s", argv[1]);
 		return;
 	}
 
 	if (!bt_gatt_client_read_value(cli->gatt, handle, read_cb,
 								NULL, NULL))
-		printf("Failed to initiate read value procedure\n");
-}
-
-static void read_long_value_usage(void)
-{
-	printf("Usage: read-long-value <value_handle> <offset>\n");
+		error("Failed to initiate read value procedure");
 }
 
-static void cmd_read_long_value(struct client *cli, char *cmd_str)
+static void cmd_read_long_value(int argc, char **argv)
 {
-	char *argv[3];
-	int argc = 0;
 	uint16_t handle;
 	uint16_t offset;
 	char *endptr = NULL;
 
-	if (!parse_args(cmd_str, 2, argv, &argc) || argc != 2) {
-		read_long_value_usage();
-		return;
-	}
-
-	handle = strtol(argv[0], &endptr, 0);
+	handle = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || !handle) {
-		printf("Invalid value handle: %s\n", argv[0]);
+		error("Invalid value handle: %s", argv[1]);
 		return;
 	}
 
 	endptr = NULL;
-	offset = strtol(argv[1], &endptr, 0);
+	offset = strtol(argv[2], &endptr, 0);
 	if (!endptr || *endptr != '\0') {
-		printf("Invalid offset: %s\n", argv[1]);
+		error("Invalid offset: %s", argv[2]);
 		return;
 	}
 
 	if (!bt_gatt_client_read_long_value(cli->gatt, handle, offset, read_cb,
 								NULL, NULL))
-		printf("Failed to initiate read long value procedure\n");
-}
-
-static void write_value_usage(void)
-{
-	printf("Usage: write-value [options] <value_handle> <value>\n"
-		"Options:\n"
-		"\t-w, --without-response\tWrite without response\n"
-		"\t-s, --signed-write\tSigned write command\n"
-		"e.g.:\n"
-		"\twrite-value 0x0001 00 01 00\n");
+		error("Failed to initiate read long value procedure");
 }
 
 static struct option write_value_options[] = {
 	{ "without-response",	0, 0, 'w' },
 	{ "signed-write",	0, 0, 's' },
+	{ "help",	0, 0, 'h' },
 	{ }
 };
 
 static void write_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	if (success) {
-		PRLOG("\nWrite successful\n");
+		print("Write successful");
 	} else {
-		PRLOG("\nWrite failed: %s (0x%02x)\n",
+		error("Write failed: %s (0x%02x)",
 				ecode_to_string(att_ecode), att_ecode);
 	}
 }
 
-static void cmd_write_value(struct client *cli, char *cmd_str)
+static void cmd_write_value(int argc, char **argv)
 {
 	int opt, i, val;
-	char *argvbuf[516];
-	char **argv = argvbuf;
-	int argc = 1;
 	uint16_t handle;
 	char *endptr = NULL;
 	int length;
@@ -646,14 +584,6 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 	bool without_response = false;
 	bool signed_write = false;
 
-	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
-		printf("Too many arguments\n");
-		write_value_usage();
-		return;
-	}
-
-	optind = 0;
-	argv[0] = "write-value";
 	while ((opt = getopt_long(argc, argv, "+ws", write_value_options,
 								NULL)) != -1) {
 		switch (opt) {
@@ -663,23 +593,24 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 		case 's':
 			signed_write = true;
 			break;
+		case 'h':
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 		default:
-			write_value_usage();
-			return;
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 	}
 
 	argc -= optind;
 	argv += optind;
-
-	if (argc < 1) {
-		write_value_usage();
-		return;
-	}
+	optind = 0;
 
 	handle = strtol(argv[0], &endptr, 0);
 	if (!endptr || *endptr != '\0' || !handle) {
-		printf("Invalid handle: %s\n", argv[0]);
+		error("Invalid handle: %s", argv[1]);
 		return;
 	}
 
@@ -687,13 +618,13 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 
 	if (length > 0) {
 		if (length > UINT16_MAX) {
-			printf("Write value too long\n");
+			error("Write value too long");
 			return;
 		}
 
 		value = malloc(length);
 		if (!value) {
-			printf("Failed to construct write value\n");
+			error("Failed to construct write value");
 			return;
 		}
 
@@ -701,7 +632,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 			val = strtol(argv[i], &endptr, 0);
 			if (endptr == argv[i] || *endptr != '\0'
 				|| errno == ERANGE || val < 0 || val > 255) {
-				printf("Invalid value byte: %s\n",
+				error("Invalid value byte: %s",
 								argv[i]);
 				goto done;
 			}
@@ -712,36 +643,27 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 	if (without_response) {
 		if (!bt_gatt_client_write_without_response(cli->gatt, handle,
 						signed_write, value, length)) {
-			printf("Failed to initiate write without response "
-								"procedure\n");
+			error("Failed to initiate write without response "
+								"procedure");
 			goto done;
 		}
 
-		printf("Write command sent\n");
+		print("Write command sent");
 		goto done;
 	}
 
 	if (!bt_gatt_client_write_value(cli->gatt, handle, value, length,
 								write_cb,
 								NULL, NULL))
-		printf("Failed to initiate write procedure\n");
+		error("Failed to initiate write procedure");
 
 done:
 	free(value);
 }
 
-static void write_long_value_usage(void)
-{
-	printf("Usage: write-long-value [options] <value_handle> <offset> "
-				"<value>\n"
-				"Options:\n"
-				"\t-r, --reliable-write\tReliable write\n"
-				"e.g.:\n"
-				"\twrite-long-value 0x0001 0 00 01 00\n");
-}
-
 static struct option write_long_value_options[] = {
 	{ "reliable-write",	0, 0, 'r' },
+	{ "help", 0, 0, 'h' },
 	{ }
 };
 
@@ -749,21 +671,18 @@ static void write_long_cb(bool success, bool reliable_error, uint8_t att_ecode,
 								void *user_data)
 {
 	if (success) {
-		PRLOG("Write successful\n");
+		print("Write successful");
 	} else if (reliable_error) {
-		PRLOG("Reliable write not verified\n");
+		error("Reliable write not verified");
 	} else {
-		PRLOG("\nWrite failed: %s (0x%02x)\n",
+		error("Write failed: %s (0x%02x)",
 				ecode_to_string(att_ecode), att_ecode);
 	}
 }
 
-static void cmd_write_long_value(struct client *cli, char *cmd_str)
+static void cmd_write_long_value(int argc, char **argv)
 {
 	int opt, i, val;
-	char *argvbuf[516];
-	char **argv = argvbuf;
-	int argc = 1;
 	uint16_t handle;
 	uint16_t offset;
 	char *endptr = NULL;
@@ -771,44 +690,44 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 	uint8_t *value = NULL;
 	bool reliable_writes = false;
 
-	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
-		printf("Too many arguments\n");
-		write_value_usage();
-		return;
-	}
-
-	optind = 0;
-	argv[0] = "write-long-value";
 	while ((opt = getopt_long(argc, argv, "+r", write_long_value_options,
 								NULL)) != -1) {
 		switch (opt) {
 		case 'r':
 			reliable_writes = true;
 			break;
+		case 'h':
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 		default:
-			write_long_value_usage();
-			return;
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 	}
 
 	argc -= optind;
 	argv += optind;
+	optind = 0;
 
-	if (argc < 2) {
-		write_long_value_usage();
+	if (argc > 514) {
+		error("Too many arguments");
+		bt_shell_usage();
+		optind = 0;
 		return;
 	}
 
 	handle = strtol(argv[0], &endptr, 0);
 	if (!endptr || *endptr != '\0' || !handle) {
-		printf("Invalid handle: %s\n", argv[0]);
+		error("Invalid handle: %s", argv[1]);
 		return;
 	}
 
 	endptr = NULL;
 	offset = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || errno == ERANGE) {
-		printf("Invalid offset: %s\n", argv[1]);
+		error("Invalid offset: %s", argv[2]);
 		return;
 	}
 
@@ -816,13 +735,13 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 
 	if (length > 0) {
 		if (length > UINT16_MAX) {
-			printf("Write value too long\n");
+			error("Write value too long");
 			return;
 		}
 
 		value = malloc(length);
 		if (!value) {
-			printf("Failed to construct write value\n");
+			error("Failed to construct write value");
 			return;
 		}
 
@@ -830,7 +749,7 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 			val = strtol(argv[i], &endptr, 0);
 			if (endptr == argv[i] || *endptr != '\0'
 				|| errno == ERANGE || val < 0 || val > 255) {
-				printf("Invalid value byte: %s\n",
+				error("Invalid value byte: %s",
 								argv[i]);
 				free(value);
 				return;
@@ -843,32 +762,20 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 							offset, value, length,
 							write_long_cb,
 							NULL, NULL))
-		printf("Failed to initiate long write procedure\n");
+		error("Failed to initiate long write procedure");
 
 	free(value);
 }
 
-static void write_prepare_usage(void)
-{
-	printf("Usage: write-prepare [options] <value_handle> <offset> "
-				"<value>\n"
-				"Options:\n"
-				"\t-s, --session-id\tSession id\n"
-				"e.g.:\n"
-				"\twrite-prepare -s 1 0x0001 00 01 00\n");
-}
-
 static struct option write_prepare_options[] = {
 	{ "session-id",		1, 0, 's' },
+	{ "help", 0, 0, 'h' },
 	{ }
 };
 
-static void cmd_write_prepare(struct client *cli, char *cmd_str)
+static void cmd_write_prepare(int argc, char **argv)
 {
 	int opt, i, val;
-	char *argvbuf[516];
-	char **argv = argvbuf;
-	int argc = 0;
 	unsigned int id = 0;
 	uint16_t handle;
 	uint16_t offset;
@@ -876,59 +783,50 @@ static void cmd_write_prepare(struct client *cli, char *cmd_str)
 	unsigned int length;
 	uint8_t *value = NULL;
 
-	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
-		printf("Too many arguments\n");
-		write_value_usage();
-		return;
-	}
-
-	/* Add command name for getopt_long */
-	argc++;
-	argv[0] = "write-prepare";
-
-	optind = 0;
 	while ((opt = getopt_long(argc, argv , "s:", write_prepare_options,
 								NULL)) != -1) {
 		switch (opt) {
 		case 's':
-			if (!optarg) {
-				write_prepare_usage();
-				return;
-			}
-
 			id = atoi(optarg);
-
 			break;
+		case 'h':
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 		default:
-			write_prepare_usage();
-			return;
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 	}
 
 	argc -= optind;
 	argv += optind;
+	optind = 0;
 
-	if (argc < 3) {
-		write_prepare_usage();
+	if (argc > 514) {
+		error("Too many arguments");
+		bt_shell_usage();
+		optind = 0;
 		return;
 	}
 
 	if (cli->reliable_session_id != id) {
-		printf("Session id != Ongoing session id (%u!=%u)\n", id,
+		error("Session id != Ongoing session id (%u!=%u)", id,
 						cli->reliable_session_id);
 		return;
 	}
 
 	handle = strtol(argv[0], &endptr, 0);
 	if (!endptr || *endptr != '\0' || !handle) {
-		printf("Invalid handle: %s\n", argv[0]);
+		error("Invalid handle: %s", argv[1]);
 		return;
 	}
 
 	endptr = NULL;
 	offset = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || errno == ERANGE) {
-		printf("Invalid offset: %s\n", argv[1]);
+		error("Invalid offset: %s", argv[2]);
 		return;
 	}
 
@@ -942,13 +840,13 @@ static void cmd_write_prepare(struct client *cli, char *cmd_str)
 		goto done;
 
 	if (length > UINT16_MAX) {
-		printf("Write value too long\n");
+		error("Write value too long");
 		return;
 	}
 
 	value = malloc(length);
 	if (!value) {
-		printf("Failed to allocate memory for value\n");
+		error("Failed to allocate memory for value");
 		return;
 	}
 
@@ -956,7 +854,7 @@ static void cmd_write_prepare(struct client *cli, char *cmd_str)
 		val = strtol(argv[i], &endptr, 0);
 		if (endptr == argv[i] || *endptr != '\0' || errno == ERANGE
 						|| val < 0 || val > 255) {
-			printf("Invalid value byte: %s\n", argv[i]);
+			error("Invalid value byte: %s", argv[i]);
 			free(value);
 			return;
 		}
@@ -971,64 +869,43 @@ done:
 							write_long_cb, NULL,
 							NULL);
 	if (!cli->reliable_session_id)
-		printf("Failed to proceed prepare write\n");
+		error("Failed to proceed prepare write");
 	else
-		printf("Prepare write success.\n"
-				"Session id: %d to be used on next write\n",
+		print("Prepare write success."
+				"Session id: %d to be used on next write",
 						cli->reliable_session_id);
 
 	free(value);
 }
 
-static void write_execute_usage(void)
-{
-	printf("Usage: write-execute <session_id> <execute>\n"
-				"e.g.:\n"
-				"\twrite-execute 1 0\n");
-}
-
-static void cmd_write_execute(struct client *cli, char *cmd_str)
+static void cmd_write_execute(int argc, char **argv)
 {
-	char *argvbuf[516];
-	char **argv = argvbuf;
-	int argc = 0;
 	char *endptr = NULL;
 	unsigned int session_id;
 	bool execute;
 
-	if (!parse_args(cmd_str, 514, argv, &argc)) {
-		printf("Too many arguments\n");
-		write_value_usage();
-		return;
-	}
-
-	if (argc < 2) {
-		write_execute_usage();
-		return;
-	}
-
-	session_id = strtol(argv[0], &endptr, 0);
+	session_id = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0') {
-		printf("Invalid session id: %s\n", argv[0]);
+		error("Invalid session id: %s", argv[1]);
 		return;
 	}
 
 	if (session_id != cli->reliable_session_id) {
-		printf("Invalid session id: %u != %u\n", session_id,
+		error("Invalid session id: %u != %u", session_id,
 						cli->reliable_session_id);
 		return;
 	}
 
-	execute = !!strtol(argv[1], &endptr, 0);
+	execute = !!strtol(argv[2], &endptr, 0);
 	if (!endptr || *endptr != '\0') {
-		printf("Invalid execute: %s\n", argv[1]);
+		error("Invalid execute: %s", argv[2]);
 		return;
 	}
 
 	if (execute) {
 		if (!bt_gatt_client_write_execute(cli->gatt, session_id,
 							write_cb, NULL, NULL))
-			printf("Failed to proceed write execute\n");
+			error("Failed to proceed write execute");
 	} else {
 		bt_gatt_client_cancel(cli->gatt, session_id);
 	}
@@ -1036,46 +913,40 @@ static void cmd_write_execute(struct client *cli, char *cmd_str)
 	cli->reliable_session_id = 0;
 }
 
-static void register_notify_usage(void)
-{
-	printf("Usage: register-notify <chrc value handle>\n");
-}
-
 static void notify_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
 	int i;
+	char line[MAX_LEN_LINE] = {0};
 
-	printf("\n\tHandle Value Not/Ind: 0x%04x - ", value_handle);
+	append(line, "\tHandle Value Not/Ind: 0x%04x - ", value_handle);
 
 	if (length == 0) {
-		PRLOG("(0 bytes)\n");
+		print("%s(0 bytes)", line);
 		return;
 	}
 
-	printf("(%u bytes): ", length);
+	append(line, "(%u bytes): ", length);
 
 	for (i = 0; i < length; i++)
-		printf("%02x ", value[i]);
+		append(line, "%02x ", value[i]);
 
-	PRLOG("\n");
+	print("%s", line);
 }
 
 static void register_notify_cb(uint16_t att_ecode, void *user_data)
 {
 	if (att_ecode) {
-		PRLOG("Failed to register notify handler "
-					"- error code: 0x%02x\n", att_ecode);
+		error("Failed to register notify handler "
+					"- error code: 0x%02x", att_ecode);
 		return;
 	}
 
-	PRLOG("Registered notify handler!\n");
+	print("Registered notify handler!");
 }
 
-static void cmd_register_notify(struct client *cli, char *cmd_str)
+static void cmd_register_notify(int argc, char **argv)
 {
-	char *argv[2];
-	int argc = 0;
 	uint16_t value_handle;
 	unsigned int id;
 	char *endptr = NULL;
@@ -1085,14 +956,9 @@ static void cmd_register_notify(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
-		register_notify_usage();
-		return;
-	}
-
-	value_handle = strtol(argv[0], &endptr, 0);
+	value_handle = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || !value_handle) {
-		printf("Invalid value handle: %s\n", argv[0]);
+		error("Invalid value handle: %s", argv[1]);
 		return;
 	}
 
@@ -1100,22 +966,15 @@ static void cmd_register_notify(struct client *cli, char *cmd_str)
 							register_notify_cb,
 							notify_cb, NULL, NULL);
 	if (!id) {
-		printf("Failed to register notify handler\n");
+		error("Failed to register notify handler");
 		return;
 	}
 
-	printf("Registering notify handler with id: %u\n", id);
+	print("Registering notify handler with id: %u", id);
 }
 
-static void unregister_notify_usage(void)
+static void cmd_unregister_notify(int argc, char **argv)
 {
-	printf("Usage: unregister-notify <notify id>\n");
-}
-
-static void cmd_unregister_notify(struct client *cli, char *cmd_str)
-{
-	char *argv[2];
-	int argc = 0;
 	unsigned int id;
 	char *endptr = NULL;
 
@@ -1124,72 +983,46 @@ static void cmd_unregister_notify(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
-		unregister_notify_usage();
-		return;
-	}
-
-	id = strtol(argv[0], &endptr, 0);
+	id = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || !id) {
-		printf("Invalid notify id: %s\n", argv[0]);
+		error("Invalid notify id: %s", argv[1]);
 		return;
 	}
 
 	if (!bt_gatt_client_unregister_notify(cli->gatt, id)) {
-		printf("Failed to unregister notify handler with id: %u\n", id);
+		error("Failed to unregister notify handler with id: %u", id);
 		return;
 	}
 
-	printf("Unregistered notify handler with id: %u\n", id);
-}
-
-static void set_security_usage(void)
-{
-	printf("Usage: set-security <level>\n"
-		"level: 1-3\n"
-		"e.g.:\n"
-		"\tset-security 2\n");
+	print("Unregistered notify handler with id: %u", id);
 }
 
-static void cmd_set_security(struct client *cli, char *cmd_str)
+static void cmd_set_security(int argc, char **argv)
 {
-	char *argv[2];
-	int argc = 0;
 	char *endptr = NULL;
 	int level;
 
-	if (!parse_args(cmd_str, 1, argv, &argc)) {
-		printf("Too many arguments\n");
-		set_security_usage();
-		return;
-	}
-
-	if (argc < 1) {
-		set_security_usage();
-		return;
-	}
-
-	level = strtol(argv[0], &endptr, 0);
+	level = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || level < 1 || level > 3) {
-		printf("Invalid level: %s\n", argv[0]);
+		error("Invalid level: %s", argv[1]);
 		return;
 	}
 
 	if (!bt_gatt_client_set_security(cli->gatt, level))
-		printf("Could not set sec level\n");
+		error("Could not set sec level");
 	else
-		printf("Setting security level %d success\n", level);
+		print("Setting security level %d success", level);
 }
 
-static void cmd_get_security(struct client *cli, char *cmd_str)
+static void cmd_get_security(int argc, char **argv)
 {
 	int level;
 
 	level = bt_gatt_client_get_security(cli->gatt);
 	if (level < 0)
-		printf("Could not set sec level\n");
+		error("Could not get sec level");
 	else
-		printf("Security level: %u\n", level);
+		print("Security level: %u", level);
 }
 
 static bool convert_sign_key(char *optarg, uint8_t key[16])
@@ -1197,7 +1030,7 @@ static bool convert_sign_key(char *optarg, uint8_t key[16])
 	int i;
 
 	if (strlen(optarg) != 32) {
-		printf("sign-key length is invalid\n");
+		error("sign-key length is invalid");
 		return false;
 	}
 
@@ -1209,14 +1042,6 @@ static bool convert_sign_key(char *optarg, uint8_t key[16])
 	return true;
 }
 
-static void set_sign_key_usage(void)
-{
-	printf("Usage: set-sign-key [options]\nOptions:\n"
-		"\t -c, --sign-key <csrk>\tCSRK\n"
-		"e.g.:\n"
-		"\tset-sign-key -c D8515948451FEA320DC05A2E88308188\n");
-}
-
 static bool local_counter(uint32_t *sign_cnt, void *user_data)
 {
 	static uint32_t cnt = 0;
@@ -1226,141 +1051,74 @@ static bool local_counter(uint32_t *sign_cnt, void *user_data)
 	return true;
 }
 
-static void cmd_set_sign_key(struct client *cli, char *cmd_str)
+static void cmd_set_sign_key(int argc, char **argv)
 {
-	char *argv[3];
-	int argc = 0;
 	uint8_t key[16];
 
 	memset(key, 0, 16);
 
-	if (!parse_args(cmd_str, 2, argv, &argc)) {
-		set_sign_key_usage();
-		return;
-	}
-
-	if (argc != 2) {
-		set_sign_key_usage();
-		return;
-	}
-
-	if (!strcmp(argv[0], "-c") || !strcmp(argv[0], "--sign-key")) {
-		if (convert_sign_key(argv[1], key))
+	if (!strcmp(argv[1], "-c") || !strcmp(argv[1], "--sign-key")) {
+		if (convert_sign_key(argv[2], key))
 			bt_att_set_local_key(cli->att, key, local_counter, cli);
-	} else
-		set_sign_key_usage();
-}
-
-static void cmd_help(struct client *cli, char *cmd_str);
-
-typedef void (*command_func_t)(struct client *cli, char *cmd_str);
-
-static struct {
-	char *cmd;
-	command_func_t func;
-	char *doc;
-} command[] = {
-	{ "help", cmd_help, "\tDisplay help message" },
-	{ "services", cmd_services, "\tShow discovered services" },
-	{ "read-value", cmd_read_value,
-				"\tRead a characteristic or descriptor value" },
-	{ "read-long-value", cmd_read_long_value,
-		"\tRead a long characteristic or desctriptor value" },
-	{ "read-multiple", cmd_read_multiple, "\tRead Multiple" },
-	{ "write-value", cmd_write_value,
-			"\tWrite a characteristic or descriptor value" },
-	{ "write-long-value", cmd_write_long_value,
-			"Write long characteristic or descriptor value" },
-	{ "write-prepare", cmd_write_prepare,
-			"\tWrite prepare characteristic or descriptor value" },
-	{ "write-execute", cmd_write_execute,
-			"\tExecute already prepared write" },
-	{ "register-notify", cmd_register_notify,
-			"\tSubscribe to not/ind from a characteristic" },
-	{ "unregister-notify", cmd_unregister_notify,
-						"Unregister a not/ind session"},
-	{ "set-security", cmd_set_security,
-				"\tSet security level on le connection"},
-	{ "get-security", cmd_get_security,
-				"\tGet security level on le connection"},
-	{ "set-sign-key", cmd_set_sign_key,
-				"\tSet signing key for signed write command"},
-	{ }
-};
-
-static void cmd_help(struct client *cli, char *cmd_str)
-{
-	int i;
-
-	printf("Commands:\n");
-	for (i = 0; command[i].cmd; i++)
-		printf("\t%-15s\t%s\n", command[i].cmd, command[i].doc);
-}
-
-static void prompt_read_cb(int fd, uint32_t events, void *user_data)
-{
-	ssize_t read;
-	size_t len = 0;
-	char *line = NULL;
-	char *cmd = NULL, *args;
-	struct client *cli = user_data;
-	int i;
-
-	if (events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR)) {
-		mainloop_quit();
-		return;
-	}
-
-	read = getline(&line, &len, stdin);
-	if (read < 0) {
-		free(line);
-		return;
-	}
-
-	if (read <= 1) {
-		cmd_help(cli, NULL);
-		print_prompt();
-		free(line);
-		return;
-	}
-
-	line[read-1] = '\0';
-	args = line;
-
-	while ((cmd = strsep(&args, " \t")))
-		if (*cmd != '\0')
-			break;
-
-	if (!cmd)
-		goto failed;
-
-	for (i = 0; command[i].cmd; i++) {
-		if (strcmp(command[i].cmd, cmd) == 0)
-			break;
+	} else {
+		bt_shell_usage();
+		optind = 0;
 	}
-
-	if (command[i].cmd)
-		command[i].func(cli, args);
-	else
-		fprintf(stderr, "Unknown command: %s\n", line);
-
-failed:
-	print_prompt();
-
-	free(line);
 }
 
-static void signal_cb(int signum, void *user_data)
-{
-	switch (signum) {
-	case SIGINT:
-	case SIGTERM:
-		mainloop_quit();
-		break;
-	default:
-		break;
-	}
-}
+static const struct bt_shell_menu main_menu = {
+	.name = "main",
+	.entries = {
+	{ "services", "[options...]", cmd_services,
+		"Show discovered services\n"
+		"Options:\n"
+			"\t -u, --uuid <uuid>\tService UUID\n"
+			"\t -a, --handle <handle>\tService start handle\n"
+		"e.g.:\n"
+			"\tservices\n\tservices -u 0x180d\n\tservices -a 0x0009"
+	},
+	{ "read-value", "<value_handle>",
+		cmd_read_value, "Read a characteristic or descriptor value" },
+	{ "read-long-value", "<value_handle> <offset>",
+		cmd_read_long_value, "Read a long characteristic or desctriptor value" },
+	{ "read-multiple", "<handles...>",
+		cmd_read_multiple, "Read Multiple" },
+	{ "write-value", " [-w|-s] <value_handle> <value...>",
+		cmd_write_value, "Write a characteristic or descriptor value\n"
+		"Options:\n"
+			"\t-w, --without-response\tWrite without response\n"
+			"\t-s, --signed-write\tSigned write command\n"
+		"e.g.:\n"
+			"\twrite-value 0x0001 00 01 00"
+	},
+	{ "write-long-value", "[-r] <value_handle> <offset>",
+		cmd_write_long_value, "Write long characteristic or descriptor value\n"
+		"Options:\n"
+			"\t-r, --reliable-write\tReliable write\n"
+		"e.g.:\n"
+			"\twrite-long-value 0x0001 0 00 01 00"
+	},
+	{ "write-prepare", " [options...] <value_handle> <value>",
+		cmd_write_prepare, "Write prepare characteristic or descriptor value\n"
+		"Options:\n"
+			"\t-s, --session-id\tSession id\n"
+		"e.g.:\n"
+			"\twrite-prepare -s 1 0x0001 00 01 00"
+	},
+	{ "write-execute", " <session_id> <execute>",
+		cmd_write_execute, "Execute already prepared write" },
+	{ "register-notify", "<chrc_value_handle>",
+		cmd_register_notify, "Subscribe to not/ind from a characteristic" },
+	{ "unregister-notify", "<notify_id>",
+		cmd_unregister_notify, "Unregister a not/ind session"},
+	{ "set-security", "<level 1-3>",
+		cmd_set_security, "Set security level on connection"},
+	{ "get-security", NULL,
+		cmd_get_security, "Get security level on connection"},
+	{ "set-sign-key", "<csrk>",
+		cmd_set_sign_key, "Set signing key for signed write command"},
+	{} },
+};
 
 static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 									int sec)
@@ -1375,15 +1133,15 @@ static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 		ba2str(src, srcaddr_str);
 		ba2str(dst, dstaddr_str);
 
-		printf("btgatt-client: Opening L2CAP %s connection on ATT "
-					"channel:\n\t src: %s\n\tdest: %s\n",
+		print("btgatt-client: Opening L2CAP %s connection on ATT "
+					"channel:\n\t src: %s\n\tdest: %s",
 					(dst_type == BDADDR_BREDR ? "BR/EDR" : "LE"),
 					srcaddr_str, dstaddr_str);
 	}
 
 	sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sock < 0) {
-		perror("Failed to create L2CAP socket");
+		error("Failed to create L2CAP socket");
 		return -1;
 	}
 
@@ -1398,7 +1156,7 @@ static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	bacpy(&srcaddr.l2_bdaddr, src);
 
 	if (bind(sock, (struct sockaddr *)&srcaddr, sizeof(srcaddr)) < 0) {
-		perror("Failed to bind L2CAP socket");
+		error("Failed to bind L2CAP socket");
 		close(sock);
 		return -1;
 	}
@@ -1408,7 +1166,7 @@ static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	btsec.level = sec;
 	if (setsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &btsec,
 							sizeof(btsec)) != 0) {
-		fprintf(stderr, "Failed to set L2CAP security level\n");
+		error("Failed to set L2CAP security level");
 		close(sock);
 		return -1;
 	}
@@ -1423,164 +1181,144 @@ static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	dstaddr.l2_bdaddr_type = dst_type;
 	bacpy(&dstaddr.l2_bdaddr, dst);
 
-	printf("Connecting to device...");
+	print("Connecting to device...");
 	fflush(stdout);
 
 	if (connect(sock, (struct sockaddr *) &dstaddr, sizeof(dstaddr)) < 0) {
-		perror(" Failed to connect");
+		error("Failed to connect");
 		close(sock);
 		return -1;
 	}
 
-	printf(" Done\n");
+	print("Done");
 
 	return sock;
 }
 
-static void usage(void)
-{
-	printf("btgatt-client\n");
-	printf("Usage:\n\tbtgatt-client [options]\n");
-
-	printf("Options:\n"
-		"\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n"
-		"\t-d, --dest <addr>\t\tSpecify the destination address\n"
-		"\t-t, --type [random|public|bredr] \tSpecify the address type\n"
-		"\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
-		"\t-s, --security-level <sec> \tSet security level (low|medium|"
-								"high|fips)\n"
-		"\t-v, --verbose\t\t\tEnable extra logging\n"
-		"\t-h, --help\t\t\tDisplay help\n");
-}
-
 static struct option main_options[] = {
-	{ "index",		1, 0, 'i' },
-	{ "dest",		1, 0, 'd' },
-	{ "type",		1, 0, 't' },
-	{ "mtu",		1, 0, 'm' },
-	{ "security-level",	1, 0, 's' },
-	{ "verbose",		0, 0, 'v' },
-	{ "help",		0, 0, 'h' },
+	{ "index",     required_argument, NULL, 'i' },
+	{ "dst-addr",  required_argument, NULL, 'd' },
+	{ "type",      required_argument, NULL, 'T' },
+	{ "mtu",       required_argument, NULL, 'M' },
+	{ "sec-level", required_argument, NULL, 's' },
+	{ "verbose",   no_argument,       NULL, 'V' },
 	{ }
 };
 
+static const char *index_option;
+static const char *dst_addr_option;
+static const char *type_option;
+static const char *mtu_option;
+static const char *security_level_option;
+static const char *verbose_option;
+
+static const char **optargs[] = {
+	&index_option,
+	&dst_addr_option,
+	&type_option,
+	&mtu_option,
+	&security_level_option,
+	&verbose_option,
+};
+
+static const char *help[] = {
+	"Specify adapter index, e.g. hci0",
+	"Specify the destination address",
+	"Specify the address type (random|public|bredr)",
+	"The ATT MTU to use",
+	"Set security level (low|medium|high|fips)",
+	"Enable extra logging"
+};
+
+static const struct bt_shell_opt opt = {
+	.options = main_options,
+	.optno = sizeof(main_options) / sizeof(struct option),
+	.optstr = "i:d:T:M:s:V",
+	.optarg = optargs,
+	.help = help,
+};
+
 int main(int argc, char *argv[])
 {
-	int opt;
 	int sec = BT_SECURITY_LOW;
 	uint16_t mtu = 0;
 	uint8_t dst_type = BDADDR_LE_PUBLIC;
-	bool dst_addr_given = false;
 	bdaddr_t src_addr, dst_addr;
 	int dev_id = -1;
 	int fd;
-	struct client *cli;
-
-	while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:i:",
-						main_options, NULL)) != -1) {
-		switch (opt) {
-		case 'h':
-			usage();
-			return EXIT_SUCCESS;
-		case 'v':
-			verbose = true;
-			break;
-		case 's':
-			if (strcmp(optarg, "low") == 0)
-				sec = BT_SECURITY_LOW;
-			else if (strcmp(optarg, "medium") == 0)
-				sec = BT_SECURITY_MEDIUM;
-			else if (strcmp(optarg, "high") == 0)
-				sec = BT_SECURITY_HIGH;
-			else if (strcmp(optarg, "fips") == 0)
-				sec = BT_SECURITY_FIPS;
-			else {
-				fprintf(stderr, "Invalid security level\n");
-				return EXIT_FAILURE;
-			}
-			break;
-		case 'm': {
-			int arg;
-
-			arg = atoi(optarg);
-			if (arg <= 0) {
-				fprintf(stderr, "Invalid MTU: %d\n", arg);
-				return EXIT_FAILURE;
-			}
-
-			if (arg > UINT16_MAX) {
-				fprintf(stderr, "MTU too large: %d\n", arg);
-				return EXIT_FAILURE;
-			}
-
-			mtu = (uint16_t)arg;
-			break;
+	int status;
+
+	bt_shell_init(argc, argv, &opt);
+	bt_shell_set_menu(&main_menu);
+
+	if (verbose_option)
+		verbose = true;
+	if (security_level_option) {
+		if (strcmp(security_level_option, "low") == 0)
+			sec = BT_SECURITY_LOW;
+		else if (strcmp(security_level_option, "medium") == 0)
+			sec = BT_SECURITY_MEDIUM;
+		else if (strcmp(security_level_option, "high") == 0)
+			sec = BT_SECURITY_HIGH;
+		else if (strcmp(security_level_option, "fips") == 0)
+			sec = BT_SECURITY_FIPS;
+		else {
+			error("Invalid security level");
+			return EXIT_FAILURE;
 		}
-		case 't':
-			if (strcmp(optarg, "random") == 0)
-				dst_type = BDADDR_LE_RANDOM;
-			else if (strcmp(optarg, "public") == 0)
-				dst_type = BDADDR_LE_PUBLIC;
-			else if (strcmp(optarg, "bredr") == 0)
-				dst_type = BDADDR_BREDR;
-			else {
-				fprintf(stderr,
-					"Allowed types: random, public, bredr\n");
-				return EXIT_FAILURE;
-			}
-			break;
-		case 'd':
-			if (str2ba(optarg, &dst_addr) < 0) {
-				fprintf(stderr, "Invalid remote address: %s\n",
-									optarg);
-				return EXIT_FAILURE;
-			}
+	}
+	if (mtu_option) {
+		int arg;
 
-			dst_addr_given = true;
-			break;
+		arg = atoi(mtu_option);
+		if (arg <= 0) {
+			error("Invalid MTU: %d", arg);
+			return EXIT_FAILURE;
+		}
 
-		case 'i':
-			dev_id = hci_devid(optarg);
-			if (dev_id < 0) {
-				perror("Invalid adapter");
-				return EXIT_FAILURE;
-			}
+		if (arg > UINT16_MAX) {
+			error("MTU too large: %d", arg);
+			return EXIT_FAILURE;
+		}
 
-			break;
-		default:
-			fprintf(stderr, "Invalid option: %c\n", opt);
+		mtu = (uint16_t)arg;
+	}
+	if (type_option) {
+		if (strcmp(type_option, "random") == 0)
+			dst_type = BDADDR_LE_RANDOM;
+		else if (strcmp(type_option, "public") == 0)
+			dst_type = BDADDR_LE_PUBLIC;
+		else if (strcmp(type_option, "bredr") == 0)
+			dst_type = BDADDR_BREDR;
+		else {
+			error("Allowed types: random, public, bredr");
 			return EXIT_FAILURE;
 		}
 	}
-
-	if (!argc) {
-		usage();
-		return EXIT_SUCCESS;
+	if (dst_addr_option) {
+		if (str2ba(dst_addr_option, &dst_addr) < 0) {
+			error("Invalid remote address: %s", dst_addr_option);
+			return EXIT_FAILURE;
+		}
+	} else {
+		error("Destination address required!");
+		return EXIT_FAILURE;
 	}
-
-	argc -= optind;
-	argv += optind;
-	optind = 0;
-
-	if (argc) {
-		usage();
-		return EXIT_SUCCESS;
+	if (index_option) {
+		dev_id = hci_devid(index_option);
+		if (dev_id < 0) {
+			error("Invalid adapter");
+			return EXIT_FAILURE;
+		}
 	}
 
 	if (dev_id == -1)
 		bacpy(&src_addr, BDADDR_ANY);
 	else if (hci_devba(dev_id, &src_addr) < 0) {
-		perror("Adapter not available");
+		error("Adapter not available");
 		return EXIT_FAILURE;
 	}
 
-	if (!dst_addr_given) {
-		fprintf(stderr, "Destination address required!\n");
-		return EXIT_FAILURE;
-	}
-
-	mainloop_init();
-
 	fd = l2cap_att_connect(&src_addr, &dst_addr, dst_type, sec);
 	if (fd < 0)
 		return EXIT_FAILURE;
@@ -1591,20 +1329,15 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (mainloop_add_fd(fileno(stdin),
-				EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR,
-				prompt_read_cb, cli, NULL) < 0) {
-		fprintf(stderr, "Failed to initialize console\n");
-		return EXIT_FAILURE;
-	}
-
-	print_prompt();
-
-	mainloop_run_with_signal(signal_cb, NULL);
+	bt_shell_attach(fileno(stdin));
+	update_prompt();
+	shell_running = true;
+	status = bt_shell_run();
+	shell_running = false;
 
-	printf("\n\nShutting down...\n");
+	print("Shutting down...");
 
 	client_destroy(cli);
 
-	return EXIT_SUCCESS;
+	return status;
 }
-- 
2.34.1

