Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/3] tools: Fix test-client to use ERTM while on packet mode
Date: Thu,  2 Feb 2012 13:57:06 -0800
Message-Id: <1328219827-2611-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328219827-2611-1-git-send-email-luiz.dentz@gmail.com>
References: <1328219827-2611-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

OBEX should only be used with ERTM over L2CAP and set MTU properly
---
 tools/test-client.c |   60 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/tools/test-client.c b/tools/test-client.c
index 8484000..a28d43c 100644
--- a/tools/test-client.c
+++ b/tools/test-client.c
@@ -362,21 +362,51 @@ static GIOChannel *bluetooth_connect(GObexTransportType transport)
 		option = BT_IO_OPT_CHANNEL;
 	}
 
-	if (option_source)
-		io = bt_io_connect(type, conn_callback, GUINT_TO_POINTER(transport),
-				NULL, &err,
-				BT_IO_OPT_SOURCE, option_source,
-				BT_IO_OPT_DEST, option_dest,
-				option, option_channel,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-				BT_IO_OPT_INVALID);
-	else
-		io = bt_io_connect(type, conn_callback, GUINT_TO_POINTER(transport),
-				NULL, &err,
-				BT_IO_OPT_DEST, option_dest,
-				option, option_channel,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-				BT_IO_OPT_INVALID);
+	if (option_source) {
+		if (type == BT_IO_L2CAP) {
+			io = bt_io_connect(type, conn_callback,
+					GUINT_TO_POINTER(transport),
+					NULL, &err,
+					BT_IO_OPT_SOURCE, option_source,
+					BT_IO_OPT_DEST, option_dest,
+					option, option_channel,
+					BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
+					BT_IO_OPT_OMTU, option_omtu,
+					BT_IO_OPT_IMTU, option_imtu,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+		} else {
+			io = bt_io_connect(type, conn_callback,
+					GUINT_TO_POINTER(transport),
+					NULL, &err,
+					BT_IO_OPT_SOURCE, option_source,
+					BT_IO_OPT_DEST, option_dest,
+					option, option_channel,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+		}
+	} else {
+		if (type == BT_IO_L2CAP) {
+			io = bt_io_connect(type, conn_callback,
+					GUINT_TO_POINTER(transport),
+					NULL, &err,
+					BT_IO_OPT_DEST, option_dest,
+					option, option_channel,
+					BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
+					BT_IO_OPT_OMTU, option_omtu,
+					BT_IO_OPT_IMTU, option_imtu,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+		} else {
+			io = bt_io_connect(type, conn_callback,
+					GUINT_TO_POINTER(transport),
+					NULL, &err,
+					BT_IO_OPT_DEST, option_dest,
+					option, option_channel,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+		}
+	}
 
 	if (io != NULL)
 		return io;
-- 
1.7.7.6

