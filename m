Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Fix calling g_io_channel_shutdown twice for a gateway connection
Date: Tue, 25 Oct 2011 11:26:35 +0300
Message-Id: <1319531195-32637-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This happens in the following circumstance:

bluetoothd[30869]: audio/manager.c:hf_io_cb() Authorization denied!

(bluetoothd:30869): GLib-WARNING **: Invalid file descriptor.

Reported by Daniel Wagner <wagi@monom.org>
---
 audio/manager.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 818451c..3103824 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -607,7 +607,6 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 	if (perr < 0) {
 		DBG("Authorization denied!");
 		gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
-		goto drop;
 	}
 
 	return;
-- 
1.7.6.4

