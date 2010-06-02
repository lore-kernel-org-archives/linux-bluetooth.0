Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 20/32] Release health link resources
Date: Wed,  2 Jun 2010 15:19:16 +0200
Message-Id: <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 70ffde5..19ff2f9 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -359,10 +359,32 @@ static uint8_t hdp_mcap_mdl_reconn_req_cb(struct mcap_mcl *mcl,
 	return MCAP_REQUEST_NOT_SUPPORTED;
 }
 
+static void health_link_free(struct hdp_link *hdpl)
+{
+	/*TODO: Release structures related with Data Channels */
+
+	if (hdpl->mcl) {
+		mcap_close_mcl(hdpl->mcl, FALSE);
+		mcap_mcl_unref(hdpl->mcl);
+		hdpl->mcl = NULL;
+	}
+
+	if (hdpl->path) {
+		g_free(hdpl->path);
+		hdpl->path = NULL;
+	}
+
+	hdpl->hdpi->hlink = g_slist_remove(hdpl->hdpi->hlink, hdpl);
+	g_free(hdpl);
+}
+
 static void health_link_path_unregister(void *data)
 {
-	/* struct hdp_link *hdpl = data */
-	/* TODO: Unregister hdp_link*/
+	struct hdp_link *hdpl = data;
+
+	debug("Unregistered interface %s on path %s", HEALTH_LINK, hdpl->path);
+
+	health_link_free(hdpl);
 }
 
 static GDBusMethodTable health_link_methods[] = {
@@ -399,7 +421,6 @@ static struct hdp_link *create_health_link(struct hdp_instance *hdpi,
 	g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
 				"Cant register the health link in the bus");
 
-	/* TODO create a function to free health link correctly */
 	/* MCAP will close the MCL and won't cache it if we didn't
 	* increase the MCL reference counter during the callback. */
 	mcap_mcl_unref(hdpl->mcl);
-- 
1.6.3.3

