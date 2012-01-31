Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/6] device: Fix not setting the device as bonded when restoring it from the LTK
Date: Tue, 31 Jan 2012 14:10:49 -0300
Message-Id: <1328029853-21134-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index d39ca53..596ec0b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1025,6 +1025,11 @@ struct btd_device *device_create(DBusConnection *conn,
 		device_set_bonded(device, TRUE);
 	}
 
+	if (device_is_le(device) && has_longtermkeys(&src, &device->bdaddr)) {
+		device_set_paired(device, TRUE);
+		device_set_bonded(device, TRUE);
+	}
+
 	if (read_device_id(srcaddr, address, NULL, &vendor, &product, &version)
 									== 0) {
 		device_set_vendor(device, vendor);
-- 
1.7.8.1

