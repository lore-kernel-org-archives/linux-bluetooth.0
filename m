Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] sink: Add profile .connect and .disconnect
Date: Wed, 21 Nov 2012 14:10:16 +0200
Message-Id: <1353499818-10153-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
References: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the connection and disconnection hooks to the a2dp_sink btd_profile.
---
 profiles/audio/manager.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index eaae018..dad46a9 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -262,6 +262,62 @@ static int a2dp_source_disconnect(struct btd_device *dev,
 	return 0;
 }
 
+static int a2dp_sink_connect(struct btd_device *dev,
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
+	err = sink_connect(audio_dev, profile_cb, req);
+	if (err < 0) {
+		g_free(req);
+		return err;
+	}
+
+	return 0;
+}
+
+static int a2dp_sink_disconnect(struct btd_device *dev,
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
+	err = sink_disconnect(audio_dev, FALSE, profile_cb, req);
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
@@ -436,6 +492,10 @@ static struct btd_profile a2dp_sink_profile = {
 	.device_probe	= a2dp_sink_probe,
 	.device_remove	= audio_remove,
 
+	.auto_connect	= true,
+	.connect	= a2dp_sink_connect,
+	.disconnect	= a2dp_sink_disconnect,
+
 	.adapter_probe	= a2dp_sink_server_probe,
 };
 
-- 
1.7.11.7

