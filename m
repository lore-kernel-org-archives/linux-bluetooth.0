Return-Path: <cyrus@holtmann.org>
Message-ID: <1347019318.26781.2.camel@sirocco.hadess.net>
Subject: [PATCH 1/2] input: Add helper function to request disconnect
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 07 Sep 2012 13:01:58 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


---
 profiles/input/device.c | 8 ++++++++
 profiles/input/device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index f1e1af0..c42f137 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1308,3 +1308,11 @@ int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst)
 
 	return 0;
 }
+
+void input_device_request_disconnect(struct fake_input *fake)
+{
+	if (fake == NULL || fake->idev == NULL)
+		return;
+
+	device_request_disconnect(fake->idev->device, NULL);
+}
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 509a353..ff52967 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -49,3 +49,4 @@ int input_device_unregister(const char *path, const char *uuid);
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
 int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst);
+void input_device_request_disconnect(struct fake_input *fake);
-- 
1.7.12


