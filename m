Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] neard: Set device class in device object
Date: Wed, 21 Nov 2012 12:59:23 +0100
Message-Id: <1353499163-18479-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As soon as we have info related to a new device,
device object will be created if it does not exist yet.

Change check_device() to use this device object and
remove call to adapter_remove_device() in it.
---
 plugins/neard.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 963c8e4..5c9e032 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -39,7 +39,6 @@
 #include "manager.h"
 #include "device.h"
 #include "eir.h"
-#include "storage.h"
 #include "agent.h"
 #include "hcid.h"
 #include "event.h"
@@ -260,28 +259,23 @@ static void bonding_complete(struct btd_adapter *adapter,
 		error("D-Bus send failed");
 }
 
-static int check_device(struct btd_adapter *adapter, const char *address)
+static int check_device(struct btd_device *device)
 {
-	struct btd_device *device;
-
-	device = adapter_find_device(adapter, address);
+	if (!device)
+		return -ENOENT;
 
 	/* If already paired */
-	if (device && device_is_paired(device)) {
+	if (device_is_paired(device)) {
 		DBG("already paired");
 		return 1;
 	}
 
 	/* Pairing in progress... */
-	if (device && device_is_bonding(device, NULL)) {
+	if (device_is_bonding(device, NULL)) {
 		DBG("pairing in progress");
 		return -EINPROGRESS;
 	}
 
-	/* If we have unpaired device hanging around, purge it */
-	if (device)
-		adapter_remove_device(adapter, device, TRUE);
-
 	return 0;
 }
 
@@ -291,6 +285,7 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 {
 	struct eir_data eir_data;
 	char remote_address[18];
+	struct btd_device *device;
 	int ret;
 
 	DBG("size %zu", size);
@@ -304,7 +299,9 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 
 	DBG("hci%u remote:%s", adapter_get_dev_id(adapter), remote_address);
 
-	ret = check_device (adapter, remote_address);
+	device = adapter_get_device(adapter, remote_address);
+
+	ret = check_device(device);
 	if (ret != 0) {
 		eir_data_free(&eir_data);
 		return ret;
@@ -312,8 +309,7 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 
 	/* store OOB data */
 	if (eir_data.class != 0)
-		write_remote_class(adapter_get_address(adapter),
-					&eir_data.addr, eir_data.class);
+		device_set_class(device, eir_data.class);
 
 	/* TODO handle incomplete name? */
 	if (eir_data.name)
@@ -461,6 +457,7 @@ static int process_nokia_com_bt(struct btd_adapter *adapter, void *data,
 {
 	uint8_t *marker;
 	struct nokia_com_bt nokia;
+	struct btd_device *device;
 	int ret;
 	char remote_address[18];
 
@@ -499,7 +496,9 @@ static int process_nokia_com_bt(struct btd_adapter *adapter, void *data,
 	ba2str(&nokia.address, remote_address);
 	DBG("hci%u remote:%s", adapter_get_dev_id(adapter), remote_address);
 
-	ret = check_device(adapter, remote_address);
+	device = adapter_get_device(adapter, remote_address);
+
+	ret = check_device(device);
 	if (ret != 0) {
 		g_free(nokia.name);
 		return ret;
@@ -514,8 +513,7 @@ static int process_nokia_com_bt(struct btd_adapter *adapter, void *data,
 	}
 
 	if (nokia.cod != 0)
-		write_remote_class(adapter_get_address(adapter), remote,
-								nokia.cod);
+		device_set_class(device, nokia.cod);
 
 	if (nokia.pin_len > 0) {
 		/* TODO
-- 
1.7.9.5

