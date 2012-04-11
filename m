Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 7/7] media: Increase hardcoded incoming MTU
Date: Wed, 11 Apr 2012 08:57:18 +0200
Message-Id: <1334127438-27617-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

When multiple SCO links are active, the packet size typically doubles.
---
 audio/transport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 7bf7309..672fa52 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -356,7 +356,7 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 	if (fd < 0)
 		goto fail;
 
-	imtu = 48;
+	imtu = 96;
 	omtu = 48;
 
 	media_transport_set_fd(transport, fd, imtu, omtu);
@@ -461,7 +461,7 @@ static void gateway_resume_complete(struct audio_device *dev, GError *err,
 	if (fd < 0)
 		goto fail;
 
-	imtu = 48;
+	imtu = 96;
 	omtu = 48;
 
 	media_transport_set_fd(transport, fd, imtu, omtu);
-- 
1.7.7.6

