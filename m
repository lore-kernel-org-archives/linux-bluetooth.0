Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] neard: Set device class in device object
Date: Fri, 16 Nov 2012 10:35:48 +0100
Message-Id: <1353058548-8698-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As soon as we have info related to a new device,
device object will be created if it does not exist yet.
So removing adapter_remove_device().
---
 plugins/neard.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 8f8381c..ff754c3 100644
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
@@ -267,30 +266,30 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 
 	DBG("hci%u remote:%s", adapter_get_dev_id(adapter), remote_address);
 
-	device = adapter_find_device(adapter, remote_address);
+	device = adapter_get_device(adapter, remote_address);
+	if (!device) {
+		DBG("failed to create device object");
+		eir_data_free(&eir_data);
+		return -ENOMEM;
+	}
 
 	/* If already paired do nothing */
-	if (device && device_is_paired(device)) {
+	if (device_is_paired(device)) {
 		DBG("already paired");
 		eir_data_free(&eir_data);
 		return 1;
 	}
 
 	/* Pairing in progress... */
-	if (device && device_is_bonding(device, NULL)) {
+	if (device_is_bonding(device, NULL)) {
 		DBG("pairing in progress");
 		eir_data_free(&eir_data);
 		return -EINPROGRESS;
 	}
 
-	/* If we have unpaired device hanging around, purge it */
-	if (device)
-		adapter_remove_device(adapter, device, TRUE);
-
 	/* store OOB data */
 	if (eir_data.class != 0)
-		write_remote_class(adapter_get_address(adapter),
-					&eir_data.addr, eir_data.class);
+		device_set_class(device, eir_data.class);
 
 	/* TODO handle incomplete name? */
 	if (eir_data.name)
-- 
1.7.9.5

