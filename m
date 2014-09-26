Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 2/2] tools/btgatt-client: Use shared/gatt att state callback mechanism
Date: Fri, 26 Sep 2014 11:46:47 +0200
Message-Id: <1411724807-4842-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this btgatt-tester can detect if att connection is invalid due
to link disconnection or att protocol procedure timeout. There is no
point in diffirentiating these two reasons as result is the same - att
connection is not valid.
---
 tools/btgatt-client.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index d900e08..9b9224e 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -71,9 +71,9 @@ static void print_prompt(void)
 	fflush(stdout);
 }
 
-static void att_disconnect_cb(void *user_data)
+static void att_stale_cb(void *user_data)
 {
-	printf("Device disconnected\n");
+	printf("Att is stale. Terminating.\n");
 
 	mainloop_quit();
 }
@@ -122,13 +122,6 @@ static struct client *client_create(int fd, uint16_t mtu)
 		return NULL;
 	}
 
-	if (!bt_att_register_disconnect(att, att_disconnect_cb, NULL, NULL)) {
-		fprintf(stderr, "Failed to set ATT disconnect handler\n");
-		bt_att_unref(att);
-		free(cli);
-		return NULL;
-	}
-
 	cli->fd = fd;
 	cli->gatt = bt_gatt_client_new(att, mtu);
 	if (!cli->gatt) {
@@ -147,6 +140,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 	bt_gatt_client_set_ready_handler(cli->gatt, ready_cb, cli, NULL);
 	bt_gatt_client_set_service_changed(cli->gatt, service_changed_cb, cli,
 									NULL);
+	bt_gatt_client_set_stale_handler(cli->gatt, att_stale_cb, cli, NULL);
 
 	/* bt_gatt_client already holds a reference */
 	bt_att_unref(att);
-- 
1.9.1

