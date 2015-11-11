Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt-client: Fix warning when removing services
Date: Wed, 11 Nov 2015 15:40:56 +0200
Message-Id: <1447249256-10581-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings caused by not resetting id to 0:

GLib-CRITICAL **: Source ID 145 was not found when attempting to remove it
GLib-CRITICAL **: Source ID 151 was not found when attempting to remove it
GLib-CRITICAL **: Source ID 155 was not found when attempting to remove it
GLib-CRITICAL **: Source ID 162 was not found when attempting to remove it
---
 src/gatt-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 20a5ae6..39f6646 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1654,6 +1654,7 @@ static gboolean set_chrcs_ready(gpointer user_data)
 {
 	struct service *service = user_data;
 
+	service->idle_id = 0;
 	notify_chrcs(service);
 
 	return FALSE;
-- 
2.4.3

