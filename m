Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] neard: Move device object checking into separate helper
Date: Mon, 19 Nov 2012 16:03:56 +0100
Message-ID: <1353337438-21865-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
References: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will also be used by 'nokia.com:bt' handler.
---
 plugins/neard.c |   47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 1576be5..8319445 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -248,13 +248,38 @@ static void bonding_complete(struct btd_adapter *adapter,
 		error("D-Bus send failed");
 }
 
+static int check_device(struct btd_adapter *adapter, const char *address)
+{
+	struct btd_device *device;
+
+	device = adapter_find_device(adapter, address);
+
+	/* If already paired */
+	if (device && device_is_paired(device)) {
+		DBG("already paired");
+		return 1;
+	}
+
+	/* Pairing in progress... */
+	if (device && device_is_bonding(device, NULL)) {
+		DBG("pairing in progress");
+		return -EINPROGRESS;
+	}
+
+	/* If we have unpaired device hanging around, purge it */
+	if (device)
+		adapter_remove_device(adapter, device, TRUE);
+
+	return 0;
+}
+
 /* returns 1 if pairing is not needed */
 static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 							bdaddr_t *remote)
 {
-	struct btd_device *device;
 	struct eir_data eir_data;
 	char remote_address[18];
+	int ret;
 
 	DBG("size %zu", size);
 
@@ -267,26 +292,12 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 
 	DBG("hci%u remote:%s", adapter_get_dev_id(adapter), remote_address);
 
-	device = adapter_find_device(adapter, remote_address);
-
-	/* If already paired do nothing */
-	if (device && device_is_paired(device)) {
-		DBG("already paired");
+	ret = check_device (adapter, remote_address);
+	if (ret != 0) {
 		eir_data_free(&eir_data);
-		return 1;
+		return ret;
 	}
 
-	/* Pairing in progress... */
-	if (device && device_is_bonding(device, NULL)) {
-		DBG("pairing in progress");
-		eir_data_free(&eir_data);
-		return -EINPROGRESS;
-	}
-
-	/* If we have unpaired device hanging around, purge it */
-	if (device)
-		adapter_remove_device(adapter, device, TRUE);
-
 	/* store OOB data */
 	if (eir_data.class != 0)
 		write_remote_class(adapter_get_address(adapter),
-- 
1.7.9.5

