Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] HDP: Remove extra debug statements
Date: Tue, 24 Jun 2014 15:07:40 +0300
Message-Id: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

DBG() includes function name by default, so including it is not needed.
---
 profiles/health/hdp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 4f90380..65800fa 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -91,7 +91,7 @@ static struct hdp_channel *hdp_channel_ref(struct hdp_channel *chan)
 
 	chan->ref++;
 
-	DBG("health_channel_ref(%p): ref=%d", chan, chan->ref);
+	DBG("(%p): ref=%d", chan, chan->ref);
 	return chan;
 }
 
@@ -115,7 +115,7 @@ static void hdp_channel_unref(struct hdp_channel *chan)
 		return;
 
 	chan->ref --;
-	DBG("health_channel_unref(%p): ref=%d", chan, chan->ref);
+	DBG("(%p): ref=%d", chan, chan->ref);
 
 	if (chan->ref > 0)
 		return;
@@ -136,7 +136,7 @@ static struct hdp_create_dc *hdp_create_data_ref(struct hdp_create_dc *dc_data)
 {
 	dc_data->ref++;
 
-	DBG("hdp_create_data_ref(%p): ref=%d", dc_data, dc_data->ref);
+	DBG("(%p): ref=%d", dc_data, dc_data->ref);
 
 	return dc_data;
 }
@@ -145,7 +145,7 @@ static void hdp_create_data_unref(struct hdp_create_dc *dc_data)
 {
 	dc_data->ref--;
 
-	DBG("hdp_create_data_unref(%p): ref=%d", dc_data, dc_data->ref);
+	DBG("(%p): ref=%d", dc_data, dc_data->ref);
 
 	if (dc_data->ref > 0)
 		return;
@@ -993,7 +993,7 @@ static void hdp_mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
 {
 	/* struct hdp_device *dev = data; */
 
-	DBG("hdp_mcap_mdl_closed_cb");
+	DBG("");
 
 	/* Nothing to do */
 }
@@ -1005,7 +1005,8 @@ static void hdp_mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 	char *path;
 	GSList *l;
 
-	DBG("hdp_mcap_mdl_deleted_cb");
+	DBG("");
+
 	l = g_slist_find_custom(dev->channels, mdl, cmp_chan_mdl);
 	if (l == NULL)
 		return;
@@ -1023,7 +1024,8 @@ static void hdp_mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 {
 	struct hdp_device *dev = data;
 
-	DBG("hdp_mcap_mdl_aborted_cb");
+	DBG("");
+
 	if (dev->ndc == NULL)
 		return;
 
@@ -2232,7 +2234,7 @@ struct hdp_device *health_device_ref(struct hdp_device *hdp_dev)
 {
 	hdp_dev->ref++;
 
-	DBG("health_device_ref(%p): ref=%d", hdp_dev, hdp_dev->ref);
+	DBG("(%p): ref=%d", hdp_dev, hdp_dev->ref);
 
 	return hdp_dev;
 }
@@ -2241,7 +2243,7 @@ void health_device_unref(struct hdp_device *hdp_dev)
 {
 	hdp_dev->ref--;
 
-	DBG("health_device_unref(%p): ref=%d", hdp_dev, hdp_dev->ref);
+	DBG("(%p): ref=%d", hdp_dev, hdp_dev->ref);
 
 	if (hdp_dev->ref > 0)
 		return;
-- 
1.8.3.2

