Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/3] tools: Fix test-server to use ERTM while on packet mode
Date: Thu,  2 Feb 2012 13:57:07 -0800
Message-Id: <1328219827-2611-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328219827-2611-1-git-send-email-luiz.dentz@gmail.com>
References: <1328219827-2611-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

OBEX should only be used with ERTM over L2CAP and set MTU properly
---
 tools/test-server.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/test-server.c b/tools/test-server.c
index 07d1328..74d553a 100644
--- a/tools/test-server.c
+++ b/tools/test-server.c
@@ -331,9 +331,20 @@ static guint bluetooth_listen(void)
 		option = BT_IO_OPT_CHANNEL;
 	}
 
-	io = bt_io_listen(type, bluetooth_accept, NULL, NULL, NULL, &err,
-				option, option_channel,
-				BT_IO_OPT_INVALID);
+	if (type == BT_IO_L2CAP)
+		io = bt_io_listen(type, bluetooth_accept, NULL, NULL,
+					NULL, &err,
+					option, option_channel,
+					BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
+					BT_IO_OPT_OMTU, option_omtu,
+					BT_IO_OPT_IMTU, option_imtu,
+					BT_IO_OPT_INVALID);
+	else
+		io = bt_io_listen(type, bluetooth_accept, NULL, NULL,
+					NULL, &err,
+					option, option_channel,
+					BT_IO_OPT_INVALID);
+
 	if (io == NULL) {
 		g_printerr("%s\n", err->message);
 		g_error_free(err);
-- 
1.7.7.6

