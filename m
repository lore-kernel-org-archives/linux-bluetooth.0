Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 2/2] audio: fix missing io channel unref if error
Date: Tue, 13 Mar 2012 10:26:12 +0100
Message-Id: <1331630772-11438-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331630772-11438-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331630772-11438-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

In the unlikely case of service record allocation error, the io channel
should be dereferenced.
---
 audio/manager.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 0e09f2f..ddefd41 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -763,20 +763,23 @@ static int gateway_server_init(struct audio_adapter *adapter)
 	record = hfp_hs_record(chan);
 	if (!record) {
 		error("Unable to allocate new service record");
-		return -1;
+		goto failed;
 	}
 
 	if (add_record_to_server(&src, record) < 0) {
 		error("Unable to register HFP HS service record");
 		sdp_record_free(record);
-		g_io_channel_unref(adapter->hfp_hs_server);
-		adapter->hfp_hs_server = NULL;
-		return -1;
+		goto failed;
 	}
 
 	adapter->hfp_hs_record_id = record->handle;
 
 	return 0;
+
+failed:
+	g_io_channel_unref(adapter->hfp_hs_server);
+	adapter->hfp_hs_server = NULL;
+	return -1;
 }
 
 static int audio_probe(struct btd_device *device, GSList *uuids)
-- 
1.7.7.6

