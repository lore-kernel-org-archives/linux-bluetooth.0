Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] Make proper use of user_data when using bt_io_listen
Date: Tue, 21 Jun 2011 10:00:17 +0300
Message-Id: <1308639617-28882-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes the user_data from server pointer to service driver pointer
since the former is not really used in the callback but the latter is.
---
 plugins/bluetooth.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 851daa2..fe508f4 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -459,7 +459,7 @@ static int request_service_authorization(struct bluetooth_service *service,
 
 static void confirm_event(GIOChannel *io, void *user_data)
 {
-	struct bluetooth_service *service;
+	struct bluetooth_service *service = user_data;
 	GError *err = NULL;
 	char address[18];
 	uint8_t channel;
@@ -477,12 +477,6 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	info("bluetooth: New connection from: %s, channel %u", address,
 			channel);
 
-	service = find_service(NULL, channel);
-	if (service == NULL) {
-		error("bluetooth: Unable to find service");
-		goto drop;
-	}
-
 	if (service->driver->service != OBEX_OPP) {
 		if (request_service_authorization(service, io, address) < 0)
 			goto drop;
@@ -510,7 +504,7 @@ static GIOChannel *start(struct obex_server *server,
 	GError *err = NULL;
 
 	io = bt_io_listen(BT_IO_RFCOMM, NULL, confirm_event,
-				server, NULL, &err,
+				service, NULL, &err,
 				BT_IO_OPT_CHANNEL, service->channel,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
-- 
1.7.5.4

