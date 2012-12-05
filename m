Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/9] avdtp: Convert avdtp_is_connected to accept audio_device
Date: Wed, 5 Dec 2012 11:10:17 +0100
Message-ID: <1354702224-15895-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use addresses taken from btd_dev reference in audio_device to get
session source and destination.
---
 profiles/audio/avdtp.c  |    7 ++++++-
 profiles/audio/avdtp.h  |    2 +-
 profiles/audio/device.c |    7 +++----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 9ff2168..deb8d26 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3201,10 +3201,15 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 	}
 }
 
-gboolean avdtp_is_connected(const bdaddr_t *src, const bdaddr_t *dst)
+gboolean avdtp_is_connected(struct audio_device *device)
 {
 	struct avdtp_server *server;
 	struct avdtp *session;
+	const bdaddr_t *src;
+	const bdaddr_t *dst;
+
+	src = adapter_get_address(device_get_adapter(device->btd_dev));
+	dst = device_get_address(device->btd_dev);
 
 	server = find_server(servers, src);
 	if (!server)
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 9117e89..e014623 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -218,7 +218,7 @@ struct avdtp *avdtp_get(struct audio_device *device);
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
-gboolean avdtp_is_connected(const bdaddr_t *src, const bdaddr_t *dst);
+gboolean avdtp_is_connected(struct audio_device *device);
 
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 							void *data, int size);
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index fef2bea..ba1efec 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -323,14 +323,13 @@ gboolean audio_device_is_active(struct audio_device *dev,
 						const char *interface)
 {
 	if (!interface) {
-		if ((dev->sink || dev->source) &&
-				avdtp_is_connected(&dev->src, &dev->dst))
+		if ((dev->sink || dev->source) && avdtp_is_connected(dev))
 			return TRUE;
 	} else if (!strcmp(interface, AUDIO_SINK_INTERFACE) && dev->sink &&
-				avdtp_is_connected(&dev->src, &dev->dst))
+				avdtp_is_connected(dev))
 		return TRUE;
 	else if (!strcmp(interface, AUDIO_SOURCE_INTERFACE) && dev->source &&
-				avdtp_is_connected(&dev->src, &dev->dst))
+				avdtp_is_connected(dev))
 		return TRUE;
 	else if (!strcmp(interface, AUDIO_CONTROL_INTERFACE) && dev->control &&
 				control_is_active(dev))
-- 
1.7.9.5

