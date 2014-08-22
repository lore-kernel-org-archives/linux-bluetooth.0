Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/3] android/health: Cache MDL file desciptor
Date: Fri, 22 Aug 2014 12:10:07 +0300
Message-Id: <1408698607-23815-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1408698607-23815-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1408698607-23815-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS expects to close all data channels before sending delete confirmation
to peer. But file descriptor passed over IPC to hal needs to be closed.
Due to timing issue IPC notification is triggering after sending
confirmation. So cache fd and shutdown on channel free will solve the issue.
---
 android/health.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/health.c b/android/health.c
index f49110a..29c1d15 100644
--- a/android/health.c
+++ b/android/health.c
@@ -102,6 +102,7 @@ struct health_channel {
 	struct mcap_mdl *mdl;
 	bool mdl_conn;
 	uint16_t mdl_id; /* MDL ID */
+	int fd;
 
 	uint16_t id; /* channel id */
 };
@@ -168,6 +169,9 @@ static void free_health_channel(void *data)
 	if (!channel)
 		return;
 
+	if (channel->fd >= 0)
+		shutdown(channel->fd, SHUT_RDWR);
+
 	unref_mdl(channel);
 	free(channel);
 }
@@ -1234,6 +1238,7 @@ static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 	}
 
 	info("health: MDL connected");
+	channel->fd = fd;
 	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
 
 	return;
@@ -1357,6 +1362,7 @@ static struct health_channel *create_channel(struct health_app *app,
 	channel->type = mdep->channel_type;
 	channel->id = channel_id++;
 	channel->dev = dev;
+	channel->fd = -1;
 
 	if (!queue_push_tail(dev->channels, channel)) {
 		free_health_channel(channel);
@@ -1547,6 +1553,7 @@ static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
 		if (channel->type != CHANNEL_TYPE_RELIABLE)
 			goto fail;
 
+	channel->fd = fd;
 	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
 
 	return;
-- 
1.9.1

