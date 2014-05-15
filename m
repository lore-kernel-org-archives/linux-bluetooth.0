Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] Add device type info to device info(btd_device)
Date: Thu, 15 May 2014 15:25:38 +0530
Message-id: <1400147738-23861-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add device type information whether LE or BR/EDR or
LE/BR/EDR to device info, which can be further
exposed as a device property.

Signed-off-by: Bharat Panda <bharat.panda@samsung.com>
---
 src/adapter.c |    6 ++++++
 src/device.c  |   11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index f5abfe3..5154448 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4355,6 +4355,12 @@ static void update_found_devices(struct btd_adapter *adapter,
 					!(eir_data.flags & EIR_BREDR_UNSUP))
 		device_set_bredr_support(dev, true);
 
+	if (eir_data.flags & (EIR_BREDR_UNSUP))
+		device_set_le_support(dev, true);
+
+	if (eir_data.flags & (EIR_CONTROLLER | EIR_SIM_HOST | (!EIR_BREDR_UNSUP)))
+		device_set_dual_mode_support(dev, true);
+
 	if (eir_data.name != NULL && eir_data.name_complete)
 		device_store_cached_name(dev, eir_data.name);
 
diff --git a/src/device.c b/src/device.c
index 41637b3..f88a1b1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -169,6 +169,7 @@ struct btd_device {
 	char		*path;
 	bool		bredr;
 	bool		le;
+	bool		dual_mode;
 	bool		pending_paired;		/* "Paired" waiting for SDP */
 	bool		svc_refreshed;
 	GSList		*svc_callbacks;
@@ -2472,6 +2473,16 @@ void device_set_bredr_support(struct btd_device *device, bool bredr)
 	device->bredr = bredr;
 }
 
+void device_set_le_support(struct btd_device *device, bool le)
+{
+	device->le= le;
+}
+
+void device_set_dual_mode_support(struct btd_device *device, bool dual_mode)
+{
+	device->dual_mode= dual_mode;
+}
+
 void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 {
 	if (bdaddr_type == BDADDR_BREDR)
-- 
1.7.9.5

