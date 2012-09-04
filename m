Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH] audio: Fix gateway probe always failing
Date: Tue,  4 Sep 2012 11:55:27 +0200
Message-Id: <1346752527-8761-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Commit 813b674bce1aab009e7f2d14d1825f603330563d introduced this trivial
bug which causes the failure of the gateway profile probe.
---
 audio/manager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 9ca8593..5c81957 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -706,7 +706,7 @@ static int ag_probe(struct btd_device *device, GSList *uuids)
 		return -1;
 	}
 
-	if (!audio_dev->gateway)
+	if (audio_dev->gateway)
 		return -EALREADY;
 
 	audio_dev->gateway = gateway_init(audio_dev);
-- 
1.7.7.6

