Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 4/5] android/health: Implement mdl reconnect
Date: Fri, 27 Jun 2014 00:30:45 +0300
Message-Id: <1403818246-20205-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MDL reconnection can be called only when it is already created, connected
and closed not deleted.
---
 android/health.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/android/health.c b/android/health.c
index 717e9a6..db3ae9c 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1147,6 +1147,59 @@ fail:
 	destroy_channel(channel);
 }
 
+static void reconnect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
+{
+	struct health_channel *channel = data;
+	uint8_t mode;
+	GError *err = NULL;
+
+	DBG("");
+
+	if (gerr) {
+		error("health: error reconnecting to MDL %s", gerr->message);
+		goto fail;
+	}
+
+	channel->mdl_id = mcap_mdl_get_mdlid(mdl);
+
+	if (channel->type == CHANNEL_TYPE_RELIABLE)
+		mode = L2CAP_MODE_ERTM;
+	else
+		mode = L2CAP_MODE_STREAMING;
+
+	if (!mcap_connect_mdl(channel->mdl, mode, channel->dev->dcpsm,
+						connect_mdl_cb, channel,
+						NULL, &err)) {
+		error("health: error connecting to mdl");
+		g_error_free(err);
+		goto fail;
+	}
+
+	return;
+
+fail:
+	/* TODO: mcap_mdl_abort */
+	destroy_channel(channel);
+}
+
+static int reconnect_mdl(struct health_channel *channel)
+{
+	GError *gerr = NULL;
+
+	DBG("");
+
+	if (!channel)
+		return -1;
+
+	if (!mcap_reconnect_mdl(channel->mdl, reconnect_mdl_cb, channel,
+								NULL, &gerr)){
+		error("health: reconnect failed %s", gerr->message);
+		destroy_channel(channel);
+	}
+
+	return 0;
+}
+
 static void create_mdl_cb(struct mcap_mdl *mdl, uint8_t type, GError *gerr,
 								gpointer data)
 {
@@ -1563,6 +1616,13 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 		/* create mdl if it does not exists */
 		if (!channel->mdl && get_mdep(channel) < 0)
 			goto fail;
+
+		/* reconnect mdl if it exists */
+		if (channel->mdl && !channel->mdl_conn) {
+			if (reconnect_mdl(channel) < 0)
+				goto fail;
+		}
+
 	}
 
 	rsp.channel_id = channel->id;
-- 
1.9.1

