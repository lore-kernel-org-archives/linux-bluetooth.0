Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 6/8] Fix connecting to the local adapter when receiving new keys
Date: Fri, 19 Aug 2011 21:09:27 -0300
Message-Id: <1313798969-8772-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases, we receive a key for when the local adapter is
the responder and one key for when the local adapter is
the initiator of the connection, so one key might have both address
equal to the local adapter.
---
 src/event.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/event.c b/src/event.c
index 6d276f4..fb7d102 100644
--- a/src/event.c
+++ b/src/event.c
@@ -215,6 +215,9 @@ void btd_event_bonding_complete(bdaddr_t *local, bdaddr_t *peer,
 
 	create = status ? FALSE : TRUE;
 
+	if (bacmp(local, peer) == 0)
+		return;
+
 	if (!get_adapter_and_device(local, peer, &adapter, &device, create))
 		return;
 
@@ -430,9 +433,17 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	int ret;
+	int ret, diff;
 
-	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
+	diff = bacmp(local, peer);
+
+	/*
+	 * If local and peer addresses are equal it means that this key is a
+	 * "slave" key, and it should be stored, but the device must not be
+	 * created.
+	 */
+	if (diff && !get_adapter_and_device(local, peer,
+						&adapter, &device, TRUE))
 		return -ENODEV;
 
 	DBG("storing link key of type 0x%02x", key_type);
@@ -456,7 +467,7 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 		break;
 	}
 
-	if (ret == 0) {
+	if (ret == 0 && diff) {
 		device_set_bonded(device, TRUE);
 
 		if (device_is_temporary(device))
-- 
1.7.6

