Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ 4/4] Fix disallow entering in sniff mode while SCO is open
Date: Tue, 24 Jan 2012 14:58:56 +0200
Message-Id: <1327409936-6709-5-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1327409936-6709-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1327409936-6709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some Bluetooth controllers do not handle well entering sniff mode
requests while SCO channel is active, which may result in instability
in firmware.

This patch disallows entering sniff mode while SCO channel is open, and
restores link policy settings back to its default value when SCO is
closed.

The real problem is in firmware but this workaround helps to avoid
related to it problems.
---
 audio/headset.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 819e0f8..2e5193d 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -581,6 +581,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	DBG("SCO socket opened for headset %s", dev->path);
 
+	manager_allow_sniff(dev, FALSE);
+
 	sk = g_io_channel_unix_get_fd(chan);
 
 	DBG("SCO fd=%d", sk);
@@ -1243,6 +1245,8 @@ static void close_sco(struct audio_device *device)
 		g_io_channel_shutdown(hs->sco, TRUE, NULL);
 		g_io_channel_unref(hs->sco);
 		hs->sco = NULL;
+
+		manager_allow_sniff(device, TRUE);
 	}
 
 	if (hs->sco_id) {
-- 
1.7.5.4

