Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 2/3] audio: fix missing io channel shutdown
Date: Tue, 13 Mar 2012 14:19:55 +0100
Message-Id: <1331644796-14314-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331644796-14314-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331644796-14314-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Channel must be explicitly shut down because otherwise the reference
counter never reaches zero, due to the server installed by bt_io_listen.
---
 audio/manager.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index f15893d..67941ac 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -761,6 +761,7 @@ static int gateway_server_init(struct audio_adapter *adapter)
 	if (add_record_to_server(&src, record) < 0) {
 		error("Unable to register HFP HS service record");
 		sdp_record_free(record);
+		g_io_channel_shutdown(adapter->hfp_hs_server, TRUE, NULL);
 		g_io_channel_unref(adapter->hfp_hs_server);
 		adapter->hfp_hs_server = NULL;
 		return -1;
@@ -994,6 +995,7 @@ static void gateway_server_remove(struct btd_adapter *adapter)
 	}
 
 	if (adp->hfp_hs_server) {
+		g_io_channel_shutdown(adp->hfp_hs_server, TRUE, NULL);
 		g_io_channel_unref(adp->hfp_hs_server);
 		adp->hfp_hs_server = NULL;
 	}
-- 
1.7.7.6

