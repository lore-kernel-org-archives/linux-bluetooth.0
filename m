Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/6] bluetooth: add getsockname() entry in the bluetooth driver
Date: Tue, 28 May 2013 14:45:19 -0300
Message-Id: <1369763123-17949-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
References: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 obexd/plugins/bluetooth.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index b9e9c91..07baf90 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -431,10 +431,29 @@ static int bluetooth_getpeername(GIOChannel *io, char **name)
 	return 0;
 }
 
+static int bluetooth_getsockname(GIOChannel *io, char **name)
+{
+	GError *gerr = NULL;
+	char address[18];
+
+	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE, address, BT_IO_OPT_INVALID);
+
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return -EINVAL;
+	}
+
+	*name = g_strdup(address);
+
+	return 0;
+}
+
 static struct obex_transport_driver driver = {
 	.name = "bluetooth",
 	.start = bluetooth_start,
 	.getpeername = bluetooth_getpeername,
+	.getsockname = bluetooth_getsockname,
 	.stop = bluetooth_stop
 };
 
-- 
1.8.1.4

