Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] event: Remove not used btd_event_remote_class
Date: Mon, 8 Oct 2012 14:11:28 +0200
Message-ID: <1349698288-15112-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon@janc.net.pl>

This was used in hciops only. With mgmt interface remote CoD is
received in EIR from Device Found/Connected events.

---
 src/event.c |   22 ----------------------
 src/event.h |    1 -
 2 files changed, 23 deletions(-)

diff --git a/src/event.c b/src/event.c
index 84c7f88..0ebab19 100644
--- a/src/event.c
+++ b/src/event.c
@@ -280,28 +280,6 @@ void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
 		dev->legacy = legacy;
 }
 
-void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
-{
-	struct btd_adapter *adapter;
-	struct btd_device *device;
-	uint32_t old_class = 0;
-
-	read_remote_class(local, peer, &old_class);
-
-	if (old_class == class)
-		return;
-
-	write_remote_class(local, peer, class);
-
-	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
-		return;
-
-	if (!device)
-		return;
-
-	device_set_class(device, class);
-}
-
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 {
 	struct btd_adapter *adapter;
diff --git a/src/event.h b/src/event.h
index 6d001dd..6adf1f5 100644
--- a/src/event.h
+++ b/src/event.h
@@ -27,7 +27,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type
 					int8_t rssi, uint8_t confirm_name,
 					uint8_t *data, uint8_t data_len);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
-void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 						char *name, uint32_t class);
-- 
1.7.9.5

