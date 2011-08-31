Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 3/4] Fix state to "playing" on SCO establishment
Date: Wed, 31 Aug 2011 17:48:51 +0200
Message-Id: <1314805732-30418-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index ee33d79..7b6c535 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -255,6 +255,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) sco_io_cb, dev);
 
+	change_state(dev, GATEWAY_STATE_PLAYING);
 	run_connect_cb(dev, NULL);
 }
 
-- 
1.7.1

