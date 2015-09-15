Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 5/5] audio/transport: Fix emitting volume changed too soon
Date: Tue, 15 Sep 2015 15:41:33 +0300
Message-Id: <1442320893-31536-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1442320893-31536-1-git-send-email-luiz.dentz@gmail.com>
References: <1442320893-31536-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The volume should start at maximum (127) but at that point there is no
reason to notify the remote since there is no stream ongoing so no
changes can be applied.
---
 profiles/audio/transport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 7e3d1e6..4121e52 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -827,7 +827,6 @@ static int media_transport_init_sink(struct media_transport *transport)
 	transport->destroy = destroy_a2dp;
 
 	a2dp->volume = 127;
-	avrcp_set_volume(transport->device, a2dp->volume, true);
 	transport->source_watch = source_add_state_cb(service,
 							source_state_changed,
 							transport);
-- 
2.4.3

