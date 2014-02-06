Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 5/6] android/a2dp: Disconnect headset on IPC failure
Date: Thu, 6 Feb 2014 18:54:09 +0100
Message-ID: <1391709250-8047-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391709250-8047-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391709250-8047-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case audio IPC is suddenly disconnected (most likely due to crash of
mediaserver process) we should disconnect headset since it is no longer
associated with valid setup and cannot be used properly.
---
 android/a2dp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 8eabfeb..f67a593 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1515,6 +1515,7 @@ static gboolean audio_retry_register(void *data)
 
 static void audio_disconnected(void *data)
 {
+	GSList *l;
 	bool restart;
 
 	DBG("");
@@ -1526,6 +1527,12 @@ static void audio_disconnected(void *data)
 
 	bt_audio_unregister();
 
+	for (l = devices; l; l = g_slist_next(l)) {
+		struct a2dp_device *dev = l->data;
+
+		avdtp_shutdown(dev->session);
+	}
+
 	if (!restart)
 		return;
 
-- 
1.8.5.3

