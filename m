Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 2/2] Fix: increment MDL and MCL reference counter in IO watchers.
Date: Mon, 22 Nov 2010 15:55:12 +0100
Message-Id: <1290437712-28991-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <AANLkTinQAeN8jyBmmPnw0tMWDfvOVamOU5+gBXLF-hTT@mail.gmail.com>
References: <AANLkTinQAeN8jyBmmPnw0tMWDfvOVamOU5+gBXLF-hTT@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a io_watcher is added to an MDL or an MCL channel, its reference
should be incremented because the watcher should keep its own
reference the the structure.

Also  a destroy function is added in order to decrement the reference
once the watcher is removed.
---
 health/mcap.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 8ecdc68..81fd8df 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -1638,8 +1638,11 @@ static void mcap_connect_mdl_cb(GIOChannel *chan, GError *conn_err,
 	}
 
 	mdl->state = MDL_CONNECTED;
-	mdl->wid = g_io_add_watch(mdl->dc, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-						(GIOFunc) mdl_event_cb, mdl);
+	mdl->wid = g_io_add_watch_full(mdl->dc, G_PRIORITY_DEFAULT,
+					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) mdl_event_cb,
+					mcap_mdl_ref(mdl),
+					(GDestroyNotify) mcap_mdl_unref);
 
 	cb(mdl, conn_err, user_data);
 }
@@ -1774,9 +1777,11 @@ static void mcap_connect_mcl_cb(GIOChannel *chan, GError *conn_err,
 							mcap_mcl_ref(mcl));
 	}
 
-	mcl->wid = g_io_add_watch(mcl->cc,
+	mcl->wid = g_io_add_watch_full(mcl->cc, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) mcl_control_cb, mcl);
+				(GIOFunc) mcl_control_cb,
+				mcap_mcl_ref(mcl),
+				(GDestroyNotify) mcap_mcl_unref);
 	connect_cb(mcl, gerr, data);
 }
 
@@ -1786,8 +1791,11 @@ static void set_mdl_properties(GIOChannel *chan, struct mcap_mdl *mdl)
 
 	mdl->state = MDL_CONNECTED;
 	mdl->dc = g_io_channel_ref(chan);
-	mdl->wid = g_io_add_watch(mdl->dc, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-						(GIOFunc) mdl_event_cb, mdl);
+	mdl->wid = g_io_add_watch_full(mdl->dc, G_PRIORITY_DEFAULT,
+					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) mdl_event_cb,
+					mcap_mdl_ref(mdl),
+					(GDestroyNotify) mcap_mdl_unref);
 
 	mcl->state = MCL_ACTIVE;
 	mcl->cb->mdl_connected(mdl, mcl->cb->user_data);
@@ -1919,9 +1927,11 @@ static void set_mcl_conf(GIOChannel *chan, struct mcap_mcl *mcl)
 		mcl->mi->mcls = g_slist_prepend(mcl->mi->mcls,
 							mcap_mcl_ref(mcl));
 
-	mcl->wid = g_io_add_watch(mcl->cc,
-			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-			(GIOFunc) mcl_control_cb, mcl);
+	mcl->wid = g_io_add_watch_full(mcl->cc, G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) mcl_control_cb,
+				mcap_mcl_ref(mcl),
+				(GDestroyNotify) mcap_mcl_unref);
 
 	/* Callback to report new MCL */
 	if (reconn)
-- 
1.7.1

