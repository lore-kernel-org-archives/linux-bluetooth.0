Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 7/9] Fix invalid state at SCO disconnect in gateway
Date: Mon, 22 Aug 2011 17:30:45 +0200
Message-Id: <1314027047-5476-8-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If SCO disconnects after RFCOMM, do not change state to connected.
---
 audio/gateway.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index c3c4019..d41bbc3 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -191,7 +191,9 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 	g_io_channel_shutdown(gw->sco, TRUE, NULL);
 	g_io_channel_unref(gw->sco);
 	gw->sco = NULL;
-	change_state(dev, GATEWAY_STATE_CONNECTED);
+
+	if (gw->rfcomm)
+		change_state(dev, GATEWAY_STATE_CONNECTED);
 
 	return FALSE;
 }
-- 
1.7.1

