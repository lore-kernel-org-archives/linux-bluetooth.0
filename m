Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 05/10] android/health: Add channel connect
Date: Fri, 27 Jun 2014 18:16:06 +0300
Message-Id: <1403882171-16308-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Connect channel on incoming connection callback
---
 android/health.c | 194 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 113 insertions(+), 81 deletions(-)

diff --git a/android/health.c b/android/health.c
index d7534ab..b7c24fd 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1107,14 +1107,127 @@ static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 	DBG("Not Implemeneted");
 }
 
+static struct health_device *create_device(struct health_app *app,
+							const uint8_t *addr)
+{
+	struct health_device *dev;
+
+	if (!app)
+		return NULL;
+
+	/* create device and push it to devices queue */
+	dev = new0(struct health_device, 1);
+	if (!dev)
+		return NULL;
+
+	android2bdaddr(addr, &dev->dst);
+	dev->channels = queue_new();
+	if (!dev->channels) {
+		free_health_device(dev);
+		return NULL;
+	}
+
+	if (!queue_push_tail(app->devices, dev)) {
+		free_health_device(dev);
+		return NULL;
+	}
+
+	dev->app_id = app->id;
+
+	return dev;
+}
+
+static struct health_device *get_device(struct health_app *app,
+							const uint8_t *addr)
+{
+	struct health_device *dev;
+	bdaddr_t bdaddr;
+
+	android2bdaddr(addr, &bdaddr);
+	dev = queue_find(app->devices, match_dev_by_addr, &bdaddr);
+	if (dev)
+		return dev;
+
+	return create_device(app, addr);
+}
+
+static struct health_channel *create_channel(struct health_app *app,
+						uint8_t mdep_index,
+						struct health_device *dev)
+{
+	struct mdep_cfg *mdep;
+	struct health_channel *channel;
+	uint8_t index;
+	static unsigned int channel_id = 1;
+
+	DBG("mdep %u", mdep_index);
+
+	if (!dev || !app)
+		return NULL;
+
+	index = mdep_index + 1;
+	mdep = queue_find(app->mdeps, match_mdep_by_id, INT_TO_PTR(index));
+	if (!mdep)
+		return NULL;
+
+	/* create channel and push it to device */
+	channel = new0(struct health_channel, 1);
+	if (!channel)
+		return NULL;
+
+	channel->mdep_id = mdep->id;
+	channel->type = mdep->channel_type;
+	channel->id = channel_id++;
+	channel->dev = dev;
+
+	if (!queue_push_tail(dev->channels, channel)) {
+		free_health_channel(channel);
+		return NULL;
+	}
+
+	return channel;
+}
+
+static struct health_channel *connect_channel(struct mcap_mcl *mcl,
+								uint8_t mdepid)
+{
+	struct health_app *app;
+	struct health_device *device;
+	struct health_channel *channel = NULL;
+	bdaddr_t addr;
+
+	mcap_mcl_get_addr(mcl, &addr);
+
+	/* TODO: Search app for mdepid */
+
+	if (mdepid == MDEP_ECHO) {
+		/* For echo service take last app */
+		app = queue_peek_tail(apps);
+		if (!app)
+			return NULL;
+
+		device = get_device(app, (uint8_t *) &addr);
+		if (!device)
+			return NULL;
+
+		channel = create_channel(app, mdepid, device);
+	}
+
+	return channel;
+}
+
 static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 				uint16_t mdlid, uint8_t *conf, void *data)
 {
 	GError *gerr = NULL;
+	struct health_channel *channel;
 
 	DBG("Data channel request: mdepid %u mdlid %u", mdepid, mdlid);
 
 	/* TODO: find / create device */
+	channel = connect_channel(mcl, mdepid);
+	if (!channel)
+		return MCAP_MDL_BUSY;
 
 	if (mdepid == MDEP_ECHO) {
 		switch (*conf) {
@@ -1511,92 +1624,11 @@ static int connect_mcl(struct health_channel *channel)
 						search_cb, channel, NULL, 0);
 }
 
-static struct health_device *create_device(struct health_app *app,
-							const uint8_t *addr)
-{
-	struct health_device *dev;
-
-	if (!app)
-		return NULL;
-
-	/* create device and push it to devices queue */
-	dev = new0(struct health_device, 1);
-	if (!dev)
-		return NULL;
-
-	android2bdaddr(addr, &dev->dst);
-	dev->channels = queue_new();
-	if (!dev->channels) {
-		free_health_device(dev);
-		return NULL;
-	}
-
-	if (!queue_push_tail(app->devices, dev)) {
-		free_health_device(dev);
-		return NULL;
-	}
-
-	dev->app_id = app->id;
-
-	return dev;
-}
-
 static struct health_app *get_app(uint16_t app_id)
 {
 	return queue_find(apps, match_app_by_id, INT_TO_PTR(app_id));
 }
 
-static struct health_device *get_device(struct health_app *app,
-							const uint8_t *addr)
-{
-	struct health_device *dev;
-	bdaddr_t bdaddr;
-
-	android2bdaddr(addr, &bdaddr);
-	dev = queue_find(app->devices, match_dev_by_addr, &bdaddr);
-	if (dev)
-		return dev;
-
-	return create_device(app, addr);
-}
-
-static struct health_channel *create_channel(struct health_app *app,
-						uint8_t mdep_index,
-						struct health_device *dev)
-{
-	struct mdep_cfg *mdep;
-	struct health_channel *channel;
-	uint8_t index;
-	static unsigned int channel_id = 1;
-
-	DBG("mdep %u", mdep_index);
-
-	if (!dev || !app)
-		return NULL;
-
-	index = mdep_index + 1;
-	mdep = queue_find(app->mdeps, match_mdep_by_id, INT_TO_PTR(index));
-	if (!mdep)
-		return NULL;
-
-	/* create channel and push it to device */
-	channel = new0(struct health_channel, 1);
-	if (!channel)
-		return NULL;
-
-	channel->mdep_id = mdep->id;
-	channel->type = mdep->channel_type;
-	channel->id = channel_id++;
-	channel->dev = dev;
-
-	if (!queue_push_tail(dev->channels, channel)) {
-		free_health_channel(channel);
-		return NULL;
-	}
-
-	return channel;
-}
-
 static struct health_channel *get_channel(struct health_app *app,
 						uint8_t mdep_index,
 						struct health_device *dev)
-- 
1.8.3.2

