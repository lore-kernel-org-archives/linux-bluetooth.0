Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 3/3] android/gatt: Fix possible invalid read
Date: Tue, 20 May 2014 12:52:44 +0200
Message-Id: <1400583164-23776-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400583164-23776-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400583164-23776-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix dereferencing attrib before checking if not null.
---
 android/gatt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index dcb347b..4ff135b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -554,11 +554,12 @@ static void connection_cleanup(struct gatt_device *device)
 		device->att_io = NULL;
 	}
 
-	if (device->server_id > 0)
-		g_attrib_unregister(device->attrib, device->server_id);
-
 	if (device->attrib) {
 		GAttrib *attrib = device->attrib;
+
+		if (device->server_id > 0)
+			g_attrib_unregister(device->attrib, device->server_id);
+
 		device->attrib = NULL;
 		g_attrib_cancel_all(attrib);
 		g_attrib_unref(attrib);
-- 
1.9.3

