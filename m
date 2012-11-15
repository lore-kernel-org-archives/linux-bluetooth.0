Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 7/8] source: Add profile .connect and .disconnect
Date: Thu, 15 Nov 2012 08:27:39 +0100
Message-Id: <1352964460-8531-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the connection and disconnection hooks to the a2dp_source
btd_profile.
---
 profiles/audio/manager.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index d7c1717..64df824 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -80,6 +80,12 @@ struct audio_adapter {
 	gint ref;
 };
 
+struct profile_req {
+	struct btd_device	*device;
+	struct btd_profile	*profile;
+	btd_profile_cb		cb;
+};
+
 static gboolean auto_connect = TRUE;
 static int max_connected_headsets = 1;
 static GKeyFile *config = NULL;
@@ -182,6 +188,79 @@ static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
+static struct profile_req *new_profile_request(struct btd_device *dev,
+						struct btd_profile *profile,
+						btd_profile_cb cb)
+{
+	struct profile_req *req;
+
+	req  = g_new0(struct profile_req, 1);
+	req->device = dev;
+	req->profile = profile;
+	req->cb = cb;
+
+	return req;
+}
+
+static void profile_cb(struct audio_device *dev, int err, void *data)
+{
+	struct profile_req *req = data;
+
+	req->cb(req->profile, req->device, err);
+
+	g_free(req);
+}
+
+static int a2dp_source_connect(struct btd_device *dev,
+						struct btd_profile *profile,
+						btd_profile_cb cb)
+{
+	struct audio_device *audio_dev;
+	struct profile_req *req;
+	int err;
+
+	audio_dev = get_audio_dev(dev);
+	if (!audio_dev) {
+		DBG("unable to get a device object");
+		return -1;
+	}
+
+	req = new_profile_request(dev, profile, cb);
+
+	err = source_connect(audio_dev, profile_cb, req);
+	if (err < 0) {
+		g_free(req);
+		return err;
+	}
+
+	return 0;
+}
+
+static int a2dp_source_disconnect(struct btd_device *dev,
+						struct btd_profile *profile,
+						btd_profile_cb cb)
+{
+	struct audio_device *audio_dev;
+	struct profile_req *req;
+	int err;
+
+	audio_dev = get_audio_dev(dev);
+	if (!audio_dev) {
+		DBG("unable to get a device object");
+		return -1;
+	}
+
+	req = new_profile_request(dev, profile, cb);
+
+	err = source_disconnect(audio_dev, FALSE, profile_cb, req);
+	if (err < 0) {
+		g_free(req);
+		return err;
+	}
+
+	return 0;
+}
+
 static struct audio_adapter *audio_adapter_ref(struct audio_adapter *adp)
 {
 	adp->ref++;
@@ -387,6 +466,9 @@ static struct btd_profile a2dp_source_profile = {
 	.device_probe	= a2dp_source_probe,
 	.device_remove	= audio_remove,
 
+	.connect	= a2dp_source_connect,
+	.disconnect	= a2dp_source_disconnect,
+
 	.adapter_probe	= a2dp_source_server_probe,
 };
 
-- 
1.7.11.7

