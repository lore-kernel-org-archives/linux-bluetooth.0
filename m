Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 4/8] Fix state to "playing" on SCO establishment
Date: Fri, 26 Aug 2011 17:39:34 +0200
Message-Id: <1314373178-11337-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index c5f21e6..7bab77c 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -261,6 +261,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) sco_io_cb, dev);
+
+	change_state(dev, GATEWAY_STATE_PLAYING);
 }
 
 static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
-- 
1.7.1

