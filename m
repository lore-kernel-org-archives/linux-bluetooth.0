Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] tools/btgatt-client: Add signed write support
Date: Mon, 23 Feb 2015 20:14:00 +0200
Message-Id: <1424715241-4980-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424715241-4980-1-git-send-email-luiz.dentz@gmail.com>
References: <1424715241-4980-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for signed write which can be used after setting the
signing key using set-sign-key.
---
 tools/btgatt-client.c | 99 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 15 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index e59d5db..03fe76b 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -64,6 +64,7 @@ static bool verbose = false;
 
 struct client {
 	int fd;
+	struct bt_att *att;
 	struct gatt_db *db;
 	struct bt_gatt_client *gatt;
 };
@@ -169,7 +170,6 @@ static void service_removed_cb(struct gatt_db_attribute *attr, void *user_data)
 static struct client *client_create(int fd, uint16_t mtu)
 {
 	struct client *cli;
-	struct bt_att *att;
 
 	cli = new0(struct client, 1);
 	if (!cli) {
@@ -177,24 +177,25 @@ static struct client *client_create(int fd, uint16_t mtu)
 		return NULL;
 	}
 
-	att = bt_att_new(fd);
-	if (!att) {
+	cli->att = bt_att_new(fd);
+	if (!cli->att) {
 		fprintf(stderr, "Failed to initialze ATT transport layer\n");
-		bt_att_unref(att);
+		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
 	}
 
-	if (!bt_att_set_close_on_unref(att, true)) {
+	if (!bt_att_set_close_on_unref(cli->att, true)) {
 		fprintf(stderr, "Failed to set up ATT transport layer\n");
-		bt_att_unref(att);
+		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
 	}
 
-	if (!bt_att_register_disconnect(att, att_disconnect_cb, NULL, NULL)) {
+	if (!bt_att_register_disconnect(cli->att, att_disconnect_cb, NULL,
+								NULL)) {
 		fprintf(stderr, "Failed to set ATT disconnect handler\n");
-		bt_att_unref(att);
+		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
 	}
@@ -203,16 +204,16 @@ static struct client *client_create(int fd, uint16_t mtu)
 	cli->db = gatt_db_new();
 	if (!cli->db) {
 		fprintf(stderr, "Failed to create GATT database\n");
-		bt_att_unref(att);
+		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
 	}
 
-	cli->gatt = bt_gatt_client_new(cli->db, att, mtu);
+	cli->gatt = bt_gatt_client_new(cli->db, cli->att, mtu);
 	if (!cli->gatt) {
 		fprintf(stderr, "Failed to create GATT client\n");
 		gatt_db_unref(cli->db);
-		bt_att_unref(att);
+		bt_att_unref(cli->att);
 		free(cli);
 		return NULL;
 	}
@@ -221,7 +222,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 								NULL, NULL);
 
 	if (verbose) {
-		bt_att_set_debug(att, att_debug_cb, "att: ", NULL);
+		bt_att_set_debug(cli->att, att_debug_cb, "att: ", NULL);
 		bt_gatt_client_set_debug(cli->gatt, gatt_debug_cb, "gatt: ",
 									NULL);
 	}
@@ -231,7 +232,6 @@ static struct client *client_create(int fd, uint16_t mtu)
 									NULL);
 
 	/* bt_gatt_client already holds a reference */
-	bt_att_unref(att);
 	gatt_db_unref(cli->db);
 
 	return cli;
@@ -240,6 +240,8 @@ static struct client *client_create(int fd, uint16_t mtu)
 static void client_destroy(struct client *cli)
 {
 	bt_gatt_client_unref(cli->gatt);
+	bt_att_unref(cli->att);
+	free(cli);
 }
 
 static void print_uuid(const bt_uuid_t *uuid)
@@ -625,12 +627,14 @@ static void write_value_usage(void)
 	printf("Usage: write-value [options] <value_handle> <value>\n"
 		"Options:\n"
 		"\t-w, --without-response\tWrite without response\n"
+		"\t-s, --signed-write\tSigned write command\n"
 		"e.g.:\n"
 		"\twrite-value 0x0001 00 01 00\n");
 }
 
 static struct option write_value_options[] = {
 	{ "without-response",	0, 0, 'w' },
+	{ "signed-write",	0, 0, 's' },
 	{ }
 };
 
@@ -655,6 +659,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 	int length;
 	uint8_t *value = NULL;
 	bool without_response = false;
+	bool signed_write = false;
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
 		printf("GATT client not initialized\n");
@@ -669,12 +674,15 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 
 	optind = 0;
 	argv[0] = "write-value";
-	while ((opt = getopt_long(argc, argv, "+w", write_value_options,
+	while ((opt = getopt_long(argc, argv, "+ws", write_value_options,
 								NULL)) != -1) {
 		switch (opt) {
 		case 'w':
 			without_response = true;
 			break;
+		case 's':
+			signed_write = true;
+			break;
 		default:
 			write_value_usage();
 			return;
@@ -728,7 +736,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 
 	if (without_response) {
 		if (!bt_gatt_client_write_without_response(cli->gatt, handle,
-							false, value, length)) {
+						signed_write, value, length)) {
 			printf("Failed to initiate write without response "
 								"procedure\n");
 			goto done;
@@ -1043,6 +1051,65 @@ static void cmd_get_sec_level(struct client *cli, char *cmd_str)
 		printf("Security level: %u\n", level);
 }
 
+static bool convert_sign_key(char *optarg, uint8_t key[16])
+{
+	int i;
+
+	if (strlen(optarg) != 32) {
+		printf("sign-key length is invalid\n");
+		return false;
+	}
+
+	for (i = 0; i < 16; i++) {
+		if (sscanf(optarg + (i * 2), "%2hhx", &key[i]) != 1)
+			return false;
+	}
+
+	return true;
+}
+
+static void set_sign_key_usage(void)
+{
+	printf("Usage: set-sign-key [options]\nOptions:\n"
+		"\t -c, --sign-key <csrk>\tCSRK\n"
+		"e.g.:\n"
+		"\tset-sign-key -c D8515948451FEA320DC05A2E88308188\n");
+}
+
+static bool local_counter(uint32_t *sign_cnt, void *user_data)
+{
+	static uint32_t cnt = 0;
+
+	*sign_cnt = cnt++;
+
+	return true;
+}
+
+static void cmd_set_sign_key(struct client *cli, char *cmd_str)
+{
+	char *argv[3];
+	int argc = 0;
+	uint8_t key[16];
+
+	memset(key, 0, 16);
+
+	if (!parse_args(cmd_str, 2, argv, &argc)) {
+		set_sign_key_usage();
+		return;
+	}
+
+	if (argc != 2) {
+		set_sign_key_usage();
+		return;
+	}
+
+	if (!strcmp(argv[0], "-c") || !strcmp(argv[0], "--sign-key")) {
+		if (convert_sign_key(argv[1], key))
+			bt_att_set_local_key(cli->att, key, local_counter, cli);
+	} else
+		set_sign_key_usage();
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -1071,6 +1138,8 @@ static struct {
 					"Set security level on le connection"},
 	{ "get-sec-level", cmd_get_sec_level,
 					"Get security level on le connection"},
+	{ "set-sign-key", cmd_set_sign_key,
+				"\tSet signing key for signed write command"},
 	{ }
 };
 
-- 
2.1.0

