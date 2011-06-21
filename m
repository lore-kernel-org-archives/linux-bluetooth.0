Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] Fix crash introduced by f5279bfcedd669bc5d4e88cc1c59807c92226dfb
Date: Tue, 21 Jun 2011 11:37:34 +0300
Message-Id: <1308645454-2724-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1308645454-2724-1-git-send-email-luiz.dentz@gmail.com>
References: <1308645454-2724-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The callback function actually needs the bluetooth_service structure not
obex_service_driver.
---
 plugins/bluetooth.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index fe508f4..1037b24 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -459,10 +459,11 @@ static int request_service_authorization(struct bluetooth_service *service,
 
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
@@ -477,7 +478,13 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	info("bluetooth: New connection from: %s, channel %u", address,
 			channel);
 
-	if (service->driver->service != OBEX_OPP) {
+	service = find_service(driver, 0);
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

