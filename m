Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd v2] Fix crash introduced by f5279bfcedd669bc5d4e88cc1c59807c92226dfb
Date: Tue, 21 Jun 2011 13:37:12 +0300
Message-Id: <1308652632-2028-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The callback function actually needs the bluetooth_service structure not
obex_service_driver.
---
 plugins/bluetooth.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index fe508f4..b126717 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -126,21 +126,15 @@ failed:
 }
 
 static struct bluetooth_service *find_service(
-					struct obex_service_driver *driver,
-					uint8_t channel)
+					struct obex_service_driver *driver)
 {
 	GSList *l;
 
 	for (l = any->services; l; l = l->next) {
 		struct bluetooth_service *service = l->data;
 
-		if (driver != NULL && service->driver != driver)
-			continue;
-
-		if (channel != 0 && service->driver->channel != channel)
-			continue;
-
-		return service;
+		if (service->driver == driver)
+			return service;
 	}
 
 	return NULL;
@@ -158,7 +152,7 @@ static void register_record(struct obex_server *server)
 		struct bluetooth_service *service;
 		char *xml;
 
-		service = find_service(driver, 0);
+		service = find_service(driver);
 		if (service == NULL) {
 			service = g_new0(struct bluetooth_service, 1);
 			service->driver = driver;
@@ -459,10 +453,11 @@ static int request_service_authorization(struct bluetooth_service *service,
 
 static void confirm_event(GIOChannel *io, void *user_data)
 {
-	struct bluetooth_service *service = user_data;
+	struct bluetooth_service *service;
 	GError *err = NULL;
 	char address[18];
 	uint8_t channel;
+	struct obex_service_driver *driver = user_data;
 
 	bt_io_get(io, BT_IO_RFCOMM, &err,
 			BT_IO_OPT_DEST, address,
@@ -477,7 +472,13 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	info("bluetooth: New connection from: %s, channel %u", address,
 			channel);
 
-	if (service->driver->service != OBEX_OPP) {
+	service = find_service(driver);
+	if (service == NULL) {
+		error("bluetooth: Unable to find service");
+		goto drop;
+	}
+
+	if (driver->service != OBEX_OPP) {
 		if (request_service_authorization(service, io, address) < 0)
 			goto drop;
 
-- 
1.7.5.4

