Return-Path: <cyrus@holtmann.org>
From: Martin Kampas <martin.kampas@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Martin Kampas <martin.kampas@tieto.com>
Subject: [PATCH] obex-client-tool: Set the length header
Date: Tue, 22 Apr 2014 07:08:00 +0200
Message-Id: <1398143280-21017-1-git-send-email-martin.kampas@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

At least 'put' to other device with obexd v0.48 does not work without
this.
---
 tools/obex-client-tool.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/obex-client-tool.c b/tools/obex-client-tool.c
index 54dbcbb..7207c77 100644
--- a/tools/obex-client-tool.c
+++ b/tools/obex-client-tool.c
@@ -135,11 +135,19 @@ static void cmd_put(int argc, char **argv)
 		return;
 	}
 
+	struct stat st;
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		g_printerr("fstat: %s\n", strerror(errno));
+		return;
+	}
+
 	data = g_new0(struct transfer_data, 1);
 	data->fd = fd;
 
 	g_obex_put_req(obex, put_data_cb, transfer_complete, data, &err,
 						G_OBEX_HDR_NAME, argv[1],
+						G_OBEX_HDR_LENGTH, st.st_size,
 						G_OBEX_HDR_INVALID);
 	if (err != NULL) {
 		g_printerr("put failed: %s\n", err->message);
-- 
1.9.2

