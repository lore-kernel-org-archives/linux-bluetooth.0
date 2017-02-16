Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 3/7] src/device: Added function to set connection parameters
Date: Thu, 16 Feb 2017 18:03:11 +0000
Message-Id: <20170216180315.30531-4-eu@felipetonello.com>
In-Reply-To: <20170216180315.30531-1-eu@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function allows plugins to set the connection parameters of the
respective btd_device object.

It is useful for GAP Peripheral Preferred Connection Parameters
characteristic for example.
---
 src/device.c | 16 ++++++++++++++++
 src/device.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/src/device.c b/src/device.c
index 8693eb826b54..d4aa7f90561e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6122,3 +6122,19 @@ void btd_device_cleanup(void)
 {
 	btd_service_remove_state_cb(service_state_cb_id);
 }
+
+void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
+					uint16_t max_interval, uint16_t latency,
+					uint16_t timeout)
+{
+	btd_assert(device != NULL);
+
+	adapter_store_conn_param(device->adapter, &device->bdaddr,
+					device->bdaddr_type, min_interval,
+					max_interval, latency,
+					timeout);
+	adapter_load_conn_param(device->adapter, &device->bdaddr,
+					device->bdaddr_type, min_interval,
+					max_interval, latency,
+					timeout);
+}
diff --git a/src/device.h b/src/device.h
index 3cab366eeaea..88076d2d196d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -163,3 +163,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services);
 
 void btd_device_init(void);
 void btd_device_cleanup(void);
+
+void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
+					uint16_t max_interval, uint16_t latency,
+					uint16_t timeout);
-- 
2.11.1

