Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 2/3] audio: Fix gateway in connecting state forever
Date: Tue,  4 Sep 2012 13:15:55 +0200
Message-Id: <1346757356-20341-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1346757356-20341-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1346757356-20341-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If bt_search_service() fails the state should be left unchanged.
Otherwise the gateway state is set forever to GATEWAY_STATE_CONNECTING.

This issue can be easily reproduced if a connection attempt is done
very soon after startup.
---
 audio/gateway.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 77a8cb0..8603038 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -526,11 +526,18 @@ fail:
 static int get_records(struct audio_device *device)
 {
 	uuid_t uuid;
+	int err;
 
-	change_state(device, GATEWAY_STATE_CONNECTING);
 	sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
-	return bt_search_service(&device->src, &device->dst, &uuid,
-				get_record_cb, device, NULL);
+
+	err = bt_search_service(&device->src, &device->dst, &uuid,
+						get_record_cb, device, NULL);
+	if (err < 0)
+		return err;
+
+	change_state(device, GATEWAY_STATE_CONNECTING);
+
+	return 0;
 }
 
 static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
-- 
1.7.7.6

