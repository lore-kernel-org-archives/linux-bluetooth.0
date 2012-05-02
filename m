Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH BlueZ v1] audio: Reset hfp and hs handle before connection
Date: Wed, 02 May 2012 17:06:30 +0530
Message-id: <1335958590-9249-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When bluez initiates headset connection  hfp and hs handle is saved
each time when initiating connection. So at some point if hf service
is removed in remote headset then bluez connects to hs service. But
because of previously stored hfp handle bluez thinks that connection
made to hs service is hfp connection and waits for at commands.
Eventually bluez connection state will be incorrectly set.
---
 audio/headset.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index f15951d..fb10c36 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1464,9 +1464,11 @@ static int headset_set_channel(struct headset *headset,
 
 	if (svc == HANDSFREE_SVCLASS_ID) {
 		headset->hfp_handle = record->handle;
+		headset->hsp_handle = 0;
 		DBG("Discovered Handsfree service on channel %d", ch);
 	} else {
 		headset->hsp_handle = record->handle;
+		headset->hfp_handle = 0;
 		DBG("Discovered Headset service on channel %d", ch);
 	}
 
-- 
1.7.1

