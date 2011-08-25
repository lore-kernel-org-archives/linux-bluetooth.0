Return-Path: <cyrus@holtmann.org>
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [Patch Bluez] HFP gateway: fix failure on very first GSM connection
Date: Thu, 25 Aug 2011 12:09:05 +0200
Message-Id: <1314266945-6149-1-git-send-email-arnaud.mouiche@invoxia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix the very first incoming connection from a GSM device
(playing the gateway role), when 'device->gateway' is NULL (when we didn't
perform a SDP browse request yet)

we add the service with 'btd_device_add_uuid(device->btd_dev, remote_uuid)'
but we provide HFP_HS_UUID as remote_uuid. Consequently, the HFP headset
service is activated instead the gateway service.

Note: I failed to know which UUID is the good one to provide for
audio_device_request_authorization()

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 audio/manager.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 911af45..b356ed0 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -575,8 +575,8 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 		return;
 	}
 
-	server_uuid = HFP_AG_UUID;
-	remote_uuid = HFP_HS_UUID;
+	server_uuid = HFP_HS_UUID;
+	remote_uuid = HFP_AG_UUID;
 
 	device = manager_get_device(&src, &dst, TRUE);
 	if (!device)
-- 
1.7.0.4

