Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/6] gatt: Fix not freeing GError on failure
Date: Tue, 27 May 2014 12:15:30 +0200
Message-Id: <1401185734-23672-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/gatt/gas.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index d240450..b51b4a8 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -329,6 +329,11 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		DBG("MTU Exchange: Requesting %d", imtu);
 	}
 
+	if (gerr) {
+		error("Could not acquire att imtu and cid: %s", gerr->message);
+		g_error_free(gerr);
+	}
+
 	if (device_get_appearance(gas->device, &app) < 0) {
 		bt_uuid_t uuid;
 
-- 
1.9.3

