Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/9] avdtp: Convert avdtp_get to accept audio_device
Date: Wed, 5 Dec 2012 11:10:16 +0100
Message-ID: <1354702224-15895-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use addresses taken from btd_dev reference in audio_device to get
session source and destination.
---
 profiles/audio/avdtp.c     |    7 ++++++-
 profiles/audio/avdtp.h     |    2 +-
 profiles/audio/sink.c      |    2 +-
 profiles/audio/source.c    |    2 +-
 profiles/audio/transport.c |    3 +--
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index e38c95b..9ff2168 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2363,9 +2363,14 @@ static struct avdtp *avdtp_get_internal(const bdaddr_t *src, const bdaddr_t *dst
 	return session;
 }
 
-struct avdtp *avdtp_get(bdaddr_t *src, bdaddr_t *dst)
+struct avdtp *avdtp_get(struct audio_device *device)
 {
 	struct avdtp *session;
+	const bdaddr_t *src;
+	const bdaddr_t *dst;
+
+	src = adapter_get_address(device_get_adapter(device->btd_dev));
+	dst = device_get_address(device->btd_dev);
 
 	session = avdtp_get_internal(src, dst);
 
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index cdf39bf..9117e89 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -213,7 +213,7 @@ struct avdtp_sep_ind {
 typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
 
-struct avdtp *avdtp_get(bdaddr_t *src, bdaddr_t *dst);
+struct avdtp *avdtp_get(struct audio_device *device);
 
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 466c0a8..d964c3c 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -348,7 +348,7 @@ int sink_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 	struct pending_request *pending;
 
 	if (!sink->session)
-		sink->session = avdtp_get(&dev->src, &dev->dst);
+		sink->session = avdtp_get(dev);
 
 	if (!sink->session) {
 		DBG("Unable to get a session");
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 157a4e8..eea2661 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -348,7 +348,7 @@ int source_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 	struct pending_request *pending;
 
 	if (!source->session)
-		source->session = avdtp_get(&dev->src, &dev->dst);
+		source->session = avdtp_get(dev);
 
 	if (!source->session) {
 		DBG("Unable to get a session");
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 610aca3..859900d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -381,11 +381,10 @@ static guint resume_a2dp(struct media_transport *transport,
 {
 	struct a2dp_transport *a2dp = transport->data;
 	struct media_endpoint *endpoint = transport->endpoint;
-	struct audio_device *device = transport->device;
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
 
 	if (a2dp->session == NULL) {
-		a2dp->session = avdtp_get(&device->src, &device->dst);
+		a2dp->session = avdtp_get(transport->device);
 		if (a2dp->session == NULL)
 			return 0;
 	}
-- 
1.7.9.5

