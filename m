Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] tools/btgatt-server: Add signed write support
Date: Mon, 23 Feb 2015 20:14:01 +0200
Message-Id: <1424715241-4980-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424715241-4980-1-git-send-email-luiz.dentz@gmail.com>
References: <1424715241-4980-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for signed write which can be used after setting the
signing key using set-sign-key.
---
 tools/btgatt-server.c | 83 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 4d7ea6c..09a123c 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -77,6 +77,7 @@ static bool verbose = false;
 
 struct server {
 	int fd;
+	struct bt_att *att;
 	struct gatt_db *db;
 	struct bt_gatt_server *gatt;
 
@@ -539,7 +540,6 @@ static void populate_db(struct server *server)
 static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 {
 	struct server *server;
-	struct bt_att *att;
 	size_t name_len = strlen(test_device_name);
 
 	server = new0(struct server, 1);
@@ -548,18 +548,19 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 		return NULL;
 	}
 
-	att = bt_att_new(fd);
-	if (!att) {
+	server->att = bt_att_new(fd);
+	if (!server->att) {
 		fprintf(stderr, "Failed to initialze ATT transport layer\n");
 		goto fail;
 	}
 
-	if (!bt_att_set_close_on_unref(att, true)) {
+	if (!bt_att_set_close_on_unref(server->att, true)) {
 		fprintf(stderr, "Failed to set up ATT transport layer\n");
 		goto fail;
 	}
 
-	if (!bt_att_register_disconnect(att, att_disconnect_cb, NULL, NULL)) {
+	if (!bt_att_register_disconnect(server->att, att_disconnect_cb, NULL,
+									NULL)) {
 		fprintf(stderr, "Failed to set ATT disconnect handler\n");
 		goto fail;
 	}
@@ -581,7 +582,7 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 		goto fail;
 	}
 
-	server->gatt = bt_gatt_server_new(server->db, att, mtu);
+	server->gatt = bt_gatt_server_new(server->db, server->att, mtu);
 	if (!server->gatt) {
 		fprintf(stderr, "Failed to create GATT server\n");
 		goto fail;
@@ -590,7 +591,7 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 	server->hr_visible = hr_visible;
 
 	if (verbose) {
-		bt_att_set_debug(att, att_debug_cb, "att: ", NULL);
+		bt_att_set_debug(server->att, att_debug_cb, "att: ", NULL);
 		bt_gatt_server_set_debug(server->gatt, gatt_debug_cb,
 							"server: ", NULL);
 	}
@@ -599,7 +600,6 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 	srand(time(NULL));
 
 	/* bt_gatt_server already holds a reference */
-	bt_att_unref(att);
 	populate_db(server);
 
 	return server;
@@ -607,7 +607,7 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 fail:
 	gatt_db_unref(server->db);
 	free(server->device_name);
-	bt_att_unref(att);
+	bt_att_unref(server->att);
 	free(server);
 
 	return NULL;
@@ -972,6 +972,69 @@ static void cmd_services(struct server *server, char *cmd_str)
 	gatt_db_foreach_service(server->db, NULL, print_service, server);
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
+		"\t -c, --sign-key <remote csrk>\tRemote CSRK\n"
+		"e.g.:\n"
+		"\tset-sign-key -c D8515948451FEA320DC05A2E88308188\n");
+}
+
+static bool remote_counter(uint32_t *sign_cnt, void *user_data)
+{
+	static uint32_t cnt = 0;
+
+	if (*sign_cnt < cnt)
+		return false;
+
+	cnt++;
+
+	return true;
+}
+
+static void cmd_set_sign_key(struct server *server, char *cmd_str)
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
+			bt_att_set_remote_key(server->att, key, remote_counter,
+									server);
+	} else
+		set_sign_key_usage();
+}
+
 static void cmd_help(struct server *server, char *cmd_str);
 
 typedef void (*command_func_t)(struct server *server, char *cmd_str);
@@ -985,6 +1048,8 @@ static struct {
 	{ "notify", cmd_notify, "\tSend handle-value notification" },
 	{ "heart-rate", cmd_heart_rate, "\tHide/Unhide Heart Rate Service" },
 	{ "services", cmd_services, "\tEnumerate all services" },
+	{ "set-sign-key", cmd_set_sign_key,
+			"\tSet remote signing key for signed write command"},
 	{ }
 };
 
-- 
2.1.0

