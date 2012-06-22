Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH] audio: permit concurrent use of AG and HF roles
Date: Fri, 22 Jun 2012 16:11:25 +0200
Message-Id: <1340374285-29720-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a device supports both HF and AG roles, then if a SCO connection related
to AG profile happens, the connection is rejected because HF is not connected.
One consequence is pulseaudio failing to load bluetooth module.
---
 audio/main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/audio/main.c b/audio/main.c
index 5c751af..a48c8b8 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -102,7 +102,7 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 	if (device->headset) {
 		if (headset_get_state(device) < HEADSET_STATE_CONNECTED) {
 			DBG("Refusing SCO from non-connected headset");
-			goto drop;
+			goto gateway;
 		}
 
 		if (!headset_get_hfp_active(device)) {
@@ -115,7 +115,11 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 			goto drop;
 
 		headset_set_state(device, HEADSET_STATE_PLAYING);
-	} else if (device->gateway) {
+		goto connect;
+	}
+
+gateway:
+	if (device->gateway) {
 		if (!gateway_is_connected(device)) {
 			DBG("Refusing SCO from non-connected AG");
 			goto drop;
@@ -126,6 +130,7 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 	} else
 		goto drop;
 
+connect:
 	sk = g_io_channel_unix_get_fd(chan);
 	fcntl(sk, F_SETFL, 0);
 
-- 
1.7.9.5

