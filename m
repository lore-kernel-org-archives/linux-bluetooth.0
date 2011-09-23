Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 3/3] Minor style fix
Date: Fri, 23 Sep 2011 14:59:25 +0200
Message-Id: <1316782765-24147-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1316782765-24147-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1316782765-24147-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index b98dfba..19c7ee3 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -755,7 +755,6 @@ struct gateway *gateway_init(struct audio_device *dev)
 		return NULL;
 
 	return g_new0(struct gateway, 1);
-
 }
 
 gboolean gateway_is_connected(struct audio_device *dev)
-- 
1.7.4.1

