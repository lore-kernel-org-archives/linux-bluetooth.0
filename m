Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 6/9] Set state to "connecting" when AG connects.
Date: Mon, 22 Aug 2011 17:30:44 +0200
Message-Id: <1314027047-5476-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This state is used by media.c to trigger pulseaudio configuration.
---
 audio/gateway.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 425ad16..c3c4019 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -284,6 +284,8 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 		goto fail;
 	}
 
+	change_state(dev, GATEWAY_STATE_CONNECTING);
+
 	sk = g_io_channel_unix_get_fd(chan);
 
 	gw->rfcomm = g_io_channel_ref(chan);
-- 
1.7.1

