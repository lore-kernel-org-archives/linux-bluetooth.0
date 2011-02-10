Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] hfp: gateway_suspend_stream should trigger a state change
Date: Thu, 10 Feb 2011 11:41:01 +0100
Message-Id: <1297334461-23077-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

When gateway_suspend_stream is called it should change the
gateway state machine from PLAYING to CONNECTED.
---
 audio/gateway.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 43a4b02..ec0ec5d 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -707,4 +707,5 @@ void gateway_suspend_stream(struct audio_device *dev)
 	gw->sco = NULL;
 	gw->sco_start_cb = NULL;
 	gw->sco_start_cb_data = NULL;
+	change_state(dev, GATEWAY_STATE_CONNECTED);
 }
-- 
1.7.4

