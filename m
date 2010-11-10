Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Fix possible memory leak of the GIOChannel in the attribute server
Date: Wed, 10 Nov 2010 19:56:00 -0200
Message-Id: <1289426161-10045-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 1fc1c18..f644091 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -609,6 +609,20 @@ int attrib_server_init(void)
 		return -1;
 	}
 
+	record = server_record_new();
+	if (record == NULL) {
+		error("Unable to create GATT service record");
+		goto failed;
+	}
+
+	if (add_record_to_server(BDADDR_ANY, record) < 0) {
+		error("Failed to register GATT service record");
+		sdp_record_free(record);
+		goto failed;
+	}
+
+	sdp_handle = record->handle;
+
 	/* LE socket */
 	le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
 					NULL, NULL, &gerr,
@@ -623,21 +637,13 @@ int attrib_server_init(void)
 		/* Doesn't have LE support, continue */
 	}
 
-	record = server_record_new();
-	if (record == NULL) {
-		error("Unable to create GATT service record");
-		return -1;
-	}
-
-	if (add_record_to_server(BDADDR_ANY, record) < 0) {
-		error("Failed to register GATT service record");
-		sdp_record_free(record);
-		return -1;
-	}
+	return 0;
 
-	sdp_handle = record->handle;
+failed:
+	g_io_channel_unref(l2cap_io);
+	l2cap_io = NULL;
 
-	return 0;
+	return -1;
 }
 
 void attrib_server_exit(void)
-- 
1.7.3.2

