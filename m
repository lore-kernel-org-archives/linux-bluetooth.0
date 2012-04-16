Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] audio: Add missing debug message in authorization
Date: Mon, 16 Apr 2012 20:56:34 +0900
Message-id: <1334577394-577-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1334565413.16897.167.camel@aeonflux>
References: <1334565413.16897.167.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 audio/manager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index aa2547c..20453e6 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -604,7 +604,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 	perr = audio_device_request_authorization(device, server_uuid,
 						gateway_auth_cb, device);
 	if (perr < 0) {
-		DBG("Authorization denied!");
+		DBG("Authorization denied: %s", strerror(-perr));
 		gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
 	}
 
-- 
1.7.5.4

