Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 4/4] audio: do not disconnect on gateway SCO failure
Date: Thu, 15 Dec 2011 11:01:07 +0100
Message-Id: <1323943267-14576-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Failure on BlueZ-initiated SCO requests should not drop the RFCOMM
connection to the gateway. Instead, considering the stream as suspended
should be enough.
---
 audio/gateway.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 9b1aab3..f28b14d 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -255,7 +255,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	if (err) {
 		error("sco_connect_cb(): %s", err->message);
-		gateway_close(dev);
+		gateway_suspend_stream(dev);
 		return;
 	}
 
-- 
1.7.6.4

