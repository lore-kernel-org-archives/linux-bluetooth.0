Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 09/15] source: Add profile .connect and .disconnect
Date: Fri, 19 Oct 2012 17:39:26 +0200
Message-Id: <1350661172-18125-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the connection and disconnection hooks to the a2dp_source
btd_profile.
---
 audio/manager.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/audio/manager.c b/audio/manager.c
index c5d295e..77e3540 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -83,6 +83,12 @@ struct audio_adapter {
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
@@ -776,6 +782,79 @@ static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
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
+	err = source_disconnect(audio_dev, profile_cb, req);
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
@@ -1150,6 +1229,9 @@ static struct btd_profile a2dp_source_profile = {
 	.device_probe	= a2dp_source_probe,
 	.device_remove	= audio_remove,
 
+	.connect	= a2dp_source_connect,
+	.disconnect	= a2dp_source_disconnect,
+
 	.adapter_probe	= a2dp_source_server_probe,
 };
 
-- 
1.7.11.7

