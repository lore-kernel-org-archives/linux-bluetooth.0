Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/6] bluetooth: add .getpeername support
Date: Fri, 25 Nov 2011 13:33:44 +0200
Message-Id: <1322220828-10226-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1322220828-10226-1-git-send-email-luiz.dentz@gmail.com>
References: <1322220828-10226-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/bluetooth.c |   17 +++++++++++++++++
 src/transport.h     |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 7d5aedb..61561d4 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -562,9 +562,26 @@ static void bluetooth_stop(void *data)
 	g_slist_free_full(ios, stop);
 }
 
+static int bluetooth_getpeername(GIOChannel *io, char **name)
+{
+	GError *gerr = NULL;
+	char address[18];
+
+	bt_io_get(io, BT_IO_RFCOMM, &gerr,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_INVALID);
+	if (gerr)
+		return -EINVAL;
+
+	*name = g_strdup(address);
+
+	return 0;
+}
+
 static struct obex_transport_driver driver = {
 	.name = "bluetooth",
 	.start = bluetooth_start,
+	.getpeername = bluetooth_getpeername,
 	.stop = bluetooth_stop
 };
 
diff --git a/src/transport.h b/src/transport.h
index 320fafb..b81615b 100644
--- a/src/transport.h
+++ b/src/transport.h
@@ -25,6 +25,7 @@ struct obex_transport_driver {
 	const char *name;
 	uint16_t service;
 	void *(*start) (struct obex_server *server, int *err);
+	int (*getpeername) (GIOChannel *io, char **name);
 	void (*stop) (void *data);
 };
 
-- 
1.7.7.3

