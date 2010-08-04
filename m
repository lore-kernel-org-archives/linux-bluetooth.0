Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: [PATCH 5/7] Fix in logic to write EIR when SDP records are changed. 
Date: Wed,  4 Aug 2010 10:14:48 -0700
Message-Id: <1280942088-14546-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Whenever SDP service record is added/deleted/modified check for whether
class of device needs to be updated as well. If the update is
needed, proceed as before: new EIR will be written subsequently.
If the class of device is already present, just update EIR and return.
---
 src/adapter.c |   69 ++++++++++++++++++++++++++++++--------------------------
 1 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4615326..b735bdd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -206,6 +206,34 @@ void clear_found_devices_list(struct btd_adapter *adapter)
 	adapter->found_devices = NULL;
 }
 
+static void update_ext_inquiry_response(struct btd_adapter *adapter)
+{
+	uint8_t fec = 0, data[240];
+	struct hci_dev *dev = &adapter->dev;
+	int dd;
+
+	if (!(dev->features[6] & LMP_EXT_INQ))
+		return;
+
+	memset(data, 0, sizeof(data));
+
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0)
+		return;
+
+	if (dev->ssp_mode > 0)
+		create_ext_inquiry_response((char *) dev->name,
+						adapter->tx_power,
+						adapter->services, data);
+
+	if (hci_write_ext_inquiry_response(dd, fec, data,
+						HCI_REQ_TIMEOUT) < 0)
+		error("Can't write extended inquiry response: %s (%d)",
+						strerror(errno), errno);
+
+	hci_close_dev(dd);
+}
+
 static int adapter_set_service_classes(struct btd_adapter *adapter,
 							uint8_t value)
 {
@@ -216,11 +244,16 @@ static int adapter_set_service_classes(struct btd_adapter *adapter,
 	adapter->wanted_cod &= 0x00ffff;
 	adapter->wanted_cod |= (value << 16);
 
-	/* If we already have the CoD we want or the cache is enabled or an
-	 * existing CoD write is in progress just bail out */
-	if (adapter->current_cod == adapter->wanted_cod ||
-			adapter->cache_enable || adapter->pending_cod)
+	/* If the cache is enabled or an existing CoD write is in progress
+	 * just bail out */
+	if (adapter->cache_enable || adapter->pending_cod)
+		return 0;
+
+	/* If we already have the CoD we want, update EIR and return */
+	if (adapter->current_cod == adapter->wanted_cod) {
+		update_ext_inquiry_response(adapter);
 		return 0;
+	}
 
 	DBG("Changing service classes to 0x%06x", adapter->wanted_cod);
 
@@ -818,34 +851,6 @@ static DBusMessage *set_pairable_timeout(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static void update_ext_inquiry_response(struct btd_adapter *adapter)
-{
-	uint8_t fec = 0, data[240];
-	struct hci_dev *dev = &adapter->dev;
-	int dd;
-
-	if (!(dev->features[6] & LMP_EXT_INQ))
-		return;
-
-	memset(data, 0, sizeof(data));
-
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return;
-
-	if (dev->ssp_mode > 0)
-		create_ext_inquiry_response((char *) dev->name,
-						adapter->tx_power,
-						adapter->services, data);
-
-	if (hci_write_ext_inquiry_response(dd, fec, data,
-						HCI_REQ_TIMEOUT) < 0)
-		error("Can't write extended inquiry response: %s (%d)",
-						strerror(errno), errno);
-
-	hci_close_dev(dd);
-}
-
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status)
 {
 	uint8_t class[3];
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
