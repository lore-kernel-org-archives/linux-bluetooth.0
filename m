Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/7] input: Fix connecting new trusted sixaxis device
Date: Wed,  8 Jan 2014 01:02:25 +0100
Message-Id: <1389139348-3552-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
References: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If sixaxis device was trusted before first connection over Bluetooth
connection might get accepted before device services were discovered.
This results in conection to PSM19 not being added to idev. To fix
this channel for PSM19 is also added to SDP complete callback so that
both channels are added.
---
 profiles/input/server.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index d85d6a9..3814eaf 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -101,9 +101,6 @@ static void sixaxis_browse_sdp(const bdaddr_t *src, const bdaddr_t *dst,
 	struct btd_device *device;
 	struct sixaxis_data *data;
 
-	if (psm != L2CAP_PSM_HIDP_CTRL)
-		return;
-
 	device = btd_adapter_find_device(adapter_find(src), dst);
 	if (!device)
 		return;
@@ -112,7 +109,9 @@ static void sixaxis_browse_sdp(const bdaddr_t *src, const bdaddr_t *dst,
 	data->chan = g_io_channel_ref(chan);
 	data->psm = psm;
 
-	device_discover_services(device);
+	if (psm == L2CAP_PSM_HIDP_CTRL)
+		device_discover_services(device);
+
 	device_wait_for_svc_complete(device, sixaxis_sdp_cb, data);
 }
 
-- 
1.8.5.2

