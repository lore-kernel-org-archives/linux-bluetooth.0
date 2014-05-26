Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 01/26] android/a2dp: Fix removing device on incoming connection
Date: Mon, 26 May 2014 15:16:27 +0200
Message-ID: <1401110212-11526-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connection state is not changed for incoming connection, i.e. during
discovery device is still in disconnected state and in case connection
fails for some reason, device won't be removed due to triggered state
change disconnected->disconnected which is silently ignored.

This patch fixes this problem by changing device state to connecting
immediately after signalling channel is connected. This allows device
to be removed properly in case something fails and is also consistent
with behaviour of Bluedroid.

In addition there's new flag added to device which stores information
whether we're initiator of connection. This is required because before
fix this property was decided based on HAL state which we can't now
use since it will be always connecting for both incoming and outgoing
connections.
---
 android/a2dp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 452fdab..10141d1 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -81,6 +81,7 @@ struct a2dp_endpoint {
 
 struct a2dp_device {
 	bdaddr_t	dst;
+	bool		is_int;
 	uint8_t		state;
 	GIOChannel	*io;
 	struct avdtp	*session;
@@ -183,13 +184,14 @@ static void a2dp_device_remove(struct a2dp_device *dev)
 	a2dp_device_free(dev);
 }
 
-static struct a2dp_device *a2dp_device_new(const bdaddr_t *dst)
+static struct a2dp_device *a2dp_device_new(const bdaddr_t *dst, bool is_int)
 {
 	struct a2dp_device *dev;
 
 	dev = g_new0(struct a2dp_device, 1);
 	bacpy(&dev->dst, dst);
 	devices = g_slist_prepend(devices, dev);
+	dev->is_int = is_int;
 
 	return dev;
 }
@@ -547,7 +549,7 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 	}
 
 	/* Proceed to stream setup if initiator */
-	if (dev->state == HAL_A2DP_STATE_CONNECTING) {
+	if (dev->is_int) {
 		int perr;
 
 		perr = avdtp_discover(dev->session, discover_cb, dev);
@@ -585,7 +587,7 @@ static void bt_a2dp_connect(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	dev = a2dp_device_new(&dst);
+	dev = a2dp_device_new(&dst, true);
 	if (!a2dp_device_connect(dev, signaling_connect_cb)) {
 		a2dp_device_remove(dev);
 		status = HAL_STATUS_FAILED;
@@ -738,7 +740,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
-	dev = a2dp_device_new(&dst);
+	dev = a2dp_device_new(&dst, true);
+	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTING);
 	signaling_connect_cb(chan, err, dev);
 }
 
-- 
1.9.3

