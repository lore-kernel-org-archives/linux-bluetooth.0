Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 13/19] headset: Remove header declared but not defined
Date: Thu, 12 Apr 2012 20:33:04 +0530
Message-id: <1334243001-17016-14-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/headset.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/headset.h b/audio/headset.h
index 99eeca8..465c2d6 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -86,7 +86,6 @@ gboolean headset_get_rfcomm_initiator(struct audio_device *dev);
 void headset_set_rfcomm_initiator(struct audio_device *dev,
 							gboolean initiator);
 
-void headset_set_authorized(struct audio_device *dev);
 int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *chan);
 int headset_connect_sco(struct audio_device *dev, GIOChannel *io);
 
-- 
1.7.4.1

