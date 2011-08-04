Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/2] Minor style fix in audio/gateway.c
Date: Thu,  4 Aug 2011 15:31:14 +0200
Message-Id: <1312464674-18828-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1312464674-18828-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1312464674-18828-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 77aec59..e9485d0 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -158,16 +158,13 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 	if (cond & G_IO_NVAL)
 		return FALSE;
 
-	if (cond & (G_IO_ERR | G_IO_HUP)) {
-		DBG("sco connection is released");
-		g_io_channel_shutdown(gw->sco, TRUE, NULL);
-		g_io_channel_unref(gw->sco);
-		gw->sco = NULL;
-		change_state(dev, GATEWAY_STATE_CONNECTED);
-		return FALSE;
-	}
+	DBG("sco connection is released");
+	g_io_channel_shutdown(gw->sco, TRUE, NULL);
+	g_io_channel_unref(gw->sco);
+	gw->sco = NULL;
+	change_state(dev, GATEWAY_STATE_CONNECTED);
 
-	return TRUE;
+	return FALSE;
 }
 
 static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
-- 
1.7.1

