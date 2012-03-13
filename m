Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 3/3] audio: fix io channel shutdown on error
Date: Tue, 13 Mar 2012 14:19:56 +0100
Message-Id: <1331644796-14314-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331644796-14314-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331644796-14314-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

In the unlikely case of service record allocation error, the io channel
should be properly shut down.
---
 audio/manager.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 67941ac..7d6e69a 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -755,21 +755,24 @@ static int gateway_server_init(struct audio_adapter *adapter)
 	record = hfp_hs_record(chan);
 	if (!record) {
 		error("Unable to allocate new service record");
-		return -1;
+		goto failed;
 	}
 
 	if (add_record_to_server(&src, record) < 0) {
 		error("Unable to register HFP HS service record");
 		sdp_record_free(record);
-		g_io_channel_shutdown(adapter->hfp_hs_server, TRUE, NULL);
-		g_io_channel_unref(adapter->hfp_hs_server);
-		adapter->hfp_hs_server = NULL;
-		return -1;
+		goto failed;
 	}
 
 	adapter->hfp_hs_record_id = record->handle;
 
 	return 0;
+
+failed:
+	g_io_channel_shutdown(adapter->hfp_hs_server, TRUE, NULL);
+	g_io_channel_unref(adapter->hfp_hs_server);
+	adapter->hfp_hs_server = NULL;
+	return -1;
 }
 
 static int audio_probe(struct btd_device *device, GSList *uuids)
-- 
1.7.7.6

