Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 2/3] a2dp: return NotSupported error if no server found
Date: Tue, 14 Feb 2012 10:06:33 +0100
Message-Id: <1329210394-31405-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329210394-31405-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329210394-31405-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

With both sink and sources disabled, the A2DP server is not even
registered in audio_manager_init. When trying to register the endpoint,
this should result in the same error as if the server existed but the
profile was disabled.
---
 audio/a2dp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index bbb91ce..623a0bc 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1589,7 +1589,7 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 	server = find_server(servers, src);
 	if (server == NULL) {
 		if (err)
-			*err = -EINVAL;
+			*err = -EPROTONOSUPPORT;
 		return NULL;
 	}
 
-- 
1.7.6.5

