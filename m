Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Fix Device UUIDs property list being sent empty
Date: Mon, 19 Sep 2011 10:22:50 -0300
Message-Id: <1316438570-10054-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When creating a new device, the UUIDs list is updated in the device
probing function. This patch moves the function call which emit the
signal after the device driver probing.
---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1a0136b..4d6aa98 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1644,7 +1644,6 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 		goto done;
 	}
 
-	services_changed(device);
 	device_set_temporary(device, FALSE);
 
 	for (l = services; l; l = l->next) {
@@ -1672,6 +1671,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	g_slist_free(uuids);
 
+	services_changed(device);
 	create_device_reply(device, req);
 
 	store_services(device);
-- 
1.7.6.1

