Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/2] tools/btgatt-server: Free and early return if device name has length 0.
Date: Mon, 17 Nov 2014 08:08:11 -0800
Message-Id: <1416240492-6122-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the write callback for the device name characteristic, we should
check early if the value is being truncated completely and free the
value and return. Otherwise, the realloc call might correctly return
NULL if called with a length of 0, which would be incorrectly treated as
an error.
---
 tools/btgatt-server.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 2b89be1..c603b30 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -160,6 +160,14 @@ static void gap_device_name_write_cb(struct gatt_db_attribute *attrib,
 
 	PRLOG("GAP Device Name Write called\n");
 
+	/* If the value is being completely truncated, clean up and return */
+	if (!(offset + len)) {
+		free(server->device_name);
+		server->device_name = NULL;
+		server->name_len = 0;
+		goto done;
+	}
+
 	/* Implement this as a variable length attribute value. */
 	if (offset > server->name_len) {
 		error = BT_ATT_ERROR_INVALID_OFFSET;
-- 
2.1.0.rc2.206.gedb03e5

