Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 5/8] Set state to "connecting" on connection requested
Date: Fri, 26 Aug 2011 17:39:35 +0200
Message-Id: <1314373178-11337-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change will become necessary when
integrating the Audio interface which rely on
state change to confirm that connection
has started successfully.
---
 audio/gateway.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 7bab77c..353473b 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -503,8 +503,6 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	}
 
 	g_io_channel_unref(io);
-
-	change_state(dev, GATEWAY_STATE_CONNECTING);
 	return;
 
 fail:
@@ -530,6 +528,7 @@ static int get_records(struct audio_device *device)
 {
 	uuid_t uuid;
 
+	change_state(device, GATEWAY_STATE_CONNECTING);
 	sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
 	return bt_search_service(&device->src, &device->dst, &uuid,
 				get_record_cb, device, NULL);
-- 
1.7.1

