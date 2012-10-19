Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 11/15] input: Expose internal disconnection API
Date: Fri, 19 Oct 2012 17:39:28 +0200
Message-Id: <1350661172-18125-12-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Expose the same API exposed in D-Bus to disconnect devices.
---
 profiles/input/device.c | 20 ++++++++++++++++++++
 profiles/input/device.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 7df92e2..fbc3d6f 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -700,6 +700,26 @@ static DBusMessage *local_connect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile,
+							btd_profile_cb cb)
+{
+	struct input_device *idev;
+	int err;
+
+	idev = find_device_by_path(devices, device_get_path(dev));
+	if (!idev)
+		return -ENOENT;
+
+	err = connection_disconnect(idev, 0);
+	if (err < 0)
+		return err;
+
+	if (cb)
+		cb(profile, dev, 0);
+
+	return 0;
+}
+
 static DBusMessage *local_disconnect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
diff --git a/profiles/input/device.h b/profiles/input/device.h
index be1f830..d68798c 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -38,3 +38,5 @@ int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst);
 
 int input_device_connect(struct btd_device *dev, struct btd_profile *profile,
 							btd_profile_cb cb);
+int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile,
+							btd_profile_cb cb);
-- 
1.7.11.7

