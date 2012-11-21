Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] source: Add profile .connect and .disconnect
Date: Wed, 21 Nov 2012 14:10:15 +0200
Message-Id: <1353499818-10153-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
References: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the connection and disconnection hooks to the a2dp_source
btd_profile.
---
 profiles/audio/manager.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 2f36efd..eaae018 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -74,6 +74,12 @@ struct audio_adapter {
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
@@ -176,6 +182,86 @@ static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
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
+	if (req->cb)
+		req->cb(req->profile, req->device, err);
+
+	g_free(req);
+}
+
+static int a2dp_source_connect(struct btd_device *dev,
+						struct btd_profile *profile,
+						btd_profile_cb cb)
+{
+	const gchar *path = device_get_path(dev);
+	struct audio_device *audio_dev;
+	struct profile_req *req;
+	int err;
+
+	DBG("path %s", path);
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
+	const gchar *path = device_get_path(dev);
+	struct audio_device *audio_dev;
+	struct profile_req *req;
+	int err;
+
+	DBG("path %s", path);
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
@@ -335,6 +421,10 @@ static struct btd_profile a2dp_source_profile = {
 	.device_probe	= a2dp_source_probe,
 	.device_remove	= audio_remove,
 
+	.auto_connect	= true,
+	.connect	= a2dp_source_connect,
+	.disconnect	= a2dp_source_disconnect,
+
 	.adapter_probe	= a2dp_source_server_probe,
 };
 
-- 
1.7.11.7

