Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 11/12] audio: Remove unwanted code from manager
Date: Wed, 23 May 2012 21:27:31 +0530
Message-id: <1337788652-23697-12-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here the variable adp never be NULL, so no need to check it
against NULL.
---
 audio/manager.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 9c7d0d3..fb7af98 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -852,8 +852,6 @@ static struct audio_adapter *audio_adapter_get(struct btd_adapter *adapter)
 	adp = find_adapter(adapters, adapter);
 	if (!adp) {
 		adp = audio_adapter_create(adapter);
-		if (!adp)
-			return NULL;
 		adapters = g_slist_append(adapters, adp);
 	} else
 		audio_adapter_ref(adp);
-- 
1.7.4.1

