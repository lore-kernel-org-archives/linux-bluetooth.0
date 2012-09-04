Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 3/3] audio: Handle error in gateway_request_stream()
Date: Tue,  4 Sep 2012 13:15:56 +0200
Message-Id: <1346757356-20341-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1346757356-20341-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1346757356-20341-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

gateway_request_stream() should check if the call to get_records() has
succeeded, and fail otherwise.
---
 audio/gateway.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 8603038..0603f12 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -846,9 +846,10 @@ unsigned int gateway_request_stream(struct audio_device *dev,
 	GError *err = NULL;
 	GIOChannel *io;
 
-	if (!gw->rfcomm)
-		get_records(dev);
-	else if (!gw->sco) {
+	if (!gw->rfcomm) {
+		if (get_records(dev) < 0)
+			return 0;
+	} else if (!gw->sco) {
 		io = bt_io_connect(sco_connect_cb, dev, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
-- 
1.7.7.6

