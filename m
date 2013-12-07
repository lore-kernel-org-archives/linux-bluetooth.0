Return-Path: <cyrus@holtmann.org>
Message-ID: <1386428021.32408.13.camel@nuvo>
Subject: [PATCH 2/2] input: Fix crash when SDP record isn't available
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 07 Dec 2013 15:53:41 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On startup, if the SDP cache has been removed but the pairing
information is still present, we'd crash trying to access inside a
NULL record struct.
---
 profiles/input/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 521aca8..62f6dbb 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -811,6 +811,9 @@ static struct input_device *input_device_new(struct btd_service *service)
 	struct input_device *idev;
 	char name[HCI_MAX_NAME_LENGTH + 1];
 
+	if (!rec)
+		return NULL;
+
 	idev = g_new0(struct input_device, 1);
 	bacpy(&idev->src, btd_adapter_get_address(adapter));
 	bacpy(&idev->dst, device_get_address(device));
-- 
1.8.4.2


