Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 2/6] audio: Fix crash on gateway close
Date: Tue, 25 Sep 2012 16:55:42 +0200
Message-Id: <1348584946-13895-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1348584946-13895-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348584946-13895-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

gateway_close() can be called multiple times and thus the code must
handle the case where device->gateway is already NULL.

This issue can be easily reproduced if a device is removed (unpaired)
while HFP gateway is connected.
---
 audio/gateway.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/audio/gateway.c b/audio/gateway.c
index 45b25a1..93a70ba 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -566,6 +566,9 @@ int gateway_close(struct audio_device *device)
 	struct gateway *gw = device->gateway;
 	int sock;
 
+	if (gw == NULL)
+		return 0;
+
 	if (gw->rfcomm) {
 		sock = g_io_channel_unix_get_fd(gw->rfcomm);
 		shutdown(sock, SHUT_RDWR);
-- 
1.7.11.4

