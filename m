Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 3/3] sink: Add profile .connect and .disconnect
Date: Tue, 20 Nov 2012 17:10:51 +0100
Message-Id: <1353427851-4165-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1353427851-4165-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1353427851-4165-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the connection and disconnection hooks to the a2dp_sink btd_profile.
---
 profiles/audio/manager.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 64df824..38e3c2b 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -261,6 +261,56 @@ static int a2dp_source_disconnect(struct btd_device *dev,
 	return 0;
 }
 
+static int a2dp_sink_connect(struct btd_device *dev,
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
@@ -480,6 +530,9 @@ static struct btd_profile a2dp_sink_profile = {
 	.device_probe	= a2dp_sink_probe,
 	.device_remove	= audio_remove,
 
+	.connect	= a2dp_sink_connect,
+	.disconnect	= a2dp_sink_disconnect,
+
 	.adapter_probe	= a2dp_sink_server_probe,
 };
 
-- 
1.7.11.7

