Return-Path: <cyrus@holtmann.org>
Message-ID: <1339889563.20079.6.camel@sirocco.config>
Subject: [PATCH 1/3] input: Add helper function to request disconnect
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 17 Jun 2012 01:32:43 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.c |    7 +++++++
 input/device.h |    1 +
 2 files changed, 8 insertions(+)

diff --git a/input/device.c b/input/device.c
index 0e3f4a9..8fdd4e0 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1306,3 +1306,10 @@ int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst)
 
 	return 0;
 }
+
+void input_device_request_disconnect(struct fake_input *fake)
+{
+	if (fake == NULL || fake->idev == NULL)
+		return;
+	device_request_disconnect(fake->idev->device, NULL);
+}
diff --git a/input/device.h b/input/device.h
index 509a353..ff52967 100644
--- a/input/device.h
+++ b/input/device.h
@@ -49,3 +49,4 @@ int input_device_unregister(const char *path, const char *uuid);
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
 int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst);
+void input_device_request_disconnect(struct fake_input *fake);
-- 
1.7.10


