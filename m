Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 11/11] Remove the SMP Long Term Key when the device is removed
Date: Tue, 17 Jan 2012 20:28:50 -0300
Message-Id: <1326842930-31623-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 16855b1..8d02c2c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1088,6 +1088,7 @@ static void device_remove_stored(struct btd_device *device)
 	if (device_is_bonded(device)) {
 		delete_entry(&src, "linkkeys", addr);
 		delete_entry(&src, "aliases", addr);
+		delete_entry(&src, "longtermkeys", addr);
 		device_set_bonded(device, FALSE);
 		device->paired = FALSE;
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr);
-- 
1.7.8.1

