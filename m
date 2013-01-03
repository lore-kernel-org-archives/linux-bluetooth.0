Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH] attrib-server: Fix invalid device access
Date: Thu,  3 Jan 2013 15:57:18 -0300
Message-Id: <1357239438-10309-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the device is not found, the channel attach must fail.
---
 src/attrib-server.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 15622e4..4a25743 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1131,10 +1131,17 @@ guint attrib_channel_attach(GAttrib *attrib)
 	ba2str(&channel->dst, addr);
 
 	device = adapter_find_device(server->adapter, addr);
-	if (device == NULL || device_is_bonded(device) == FALSE) {
+	if (device == NULL) {
+		error("Device not found");
+		g_free(channel);
+
+		return 0;
+	}
+
+	if (device_is_bonded(device) == FALSE) {
 		char *filename;
 
-		filename = btd_device_get_storage_path(channel->device, "ccc");
+		filename = btd_device_get_storage_path(device, "ccc");
 		unlink(filename);
 		g_free(filename);
 	}
-- 
1.7.9.5

