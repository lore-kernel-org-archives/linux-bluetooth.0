Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Fix not storing tty id on pnatd plugin
Date: Mon, 16 Aug 2010 14:13:11 +0300
Message-Id: <1281957191-6964-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1281957191-6964-1-git-send-email-luiz.dentz@gmail.com>
References: <1281957191-6964-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

The code used to create the port stored the id in a local variable
instead of storing it in the client data which is used to release the
port once disconnected.
---
 plugins/pnat.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/plugins/pnat.c b/plugins/pnat.c
index f9136a4..3f5222f 100644
--- a/plugins/pnat.c
+++ b/plugins/pnat.c
@@ -238,7 +238,7 @@ static gboolean create_tty(struct dun_server *server)
 {
 	struct dun_client *client = &server->client;
 	struct rfcomm_dev_req req;
-	int dev, sk = g_io_channel_unix_get_fd(client->io);
+	int sk = g_io_channel_unix_get_fd(client->io);
 
 	memset(&req, 0, sizeof(req));
 	req.dev_id = -1;
@@ -251,13 +251,14 @@ static gboolean create_tty(struct dun_server *server)
 			BT_IO_OPT_DEST_CHANNEL, &req.channel,
 			BT_IO_OPT_INVALID);
 
-	dev = ioctl(sk, RFCOMMCREATEDEV, &req);
-	if (dev < 0) {
+	client->tty_id = ioctl(sk, RFCOMMCREATEDEV, &req);
+	if (client->tty_id < 0) {
 		error("Can't create RFCOMM TTY: %s", strerror(errno));
 		return FALSE;
 	}
 
-	snprintf(client->tty_name, PATH_MAX - 1, "/dev/rfcomm%d", dev);
+	snprintf(client->tty_name, PATH_MAX - 1, "/dev/rfcomm%d",
+							client->tty_id);
 
 	client->tty_tries = TTY_TRIES;
 
-- 
1.7.0.4

