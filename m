Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, hadess@hadess.net, padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/5] Make adapter API accept binary pincodes
Date: Thu,  5 May 2011 21:17:17 +0200
Message-Id: <1304623040-30461-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
References: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add pin-length argument to adapter API to allow passing binary pins
containing \0 characters to the hci handler.
---
 src/adapter.c |    4 ++--
 src/adapter.h |    2 +-
 src/event.c   |    7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b7016c4..67644b8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3543,10 +3543,10 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 }
 
 int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							const char *pin)
+					const char *pin, size_t pin_len)
 {
 	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin,
-							pin ? strlen(pin) : 0);
+								pin_len);
 }
 
 int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
diff --git a/src/adapter.h b/src/adapter.h
index e08068c..322a33b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -254,7 +254,7 @@ int btd_adapter_disconnect_device(struct btd_adapter *adapter,
 int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 
 int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							const char *pin);
+					const char *pin, size_t pin_len);
 int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							gboolean success);
 int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
diff --git a/src/event.c b/src/event.c
index d5bf967..c238392 100644
--- a/src/event.c
+++ b/src/event.c
@@ -111,13 +111,14 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 	device_get_address(device, &dba);
 
 	if (derr) {
-		err = btd_adapter_pincode_reply(adapter, &dba, NULL);
+		err = btd_adapter_pincode_reply(adapter, &dba, NULL, 0);
 		if (err < 0)
 			goto fail;
 		return;
 	}
 
-	err = btd_adapter_pincode_reply(adapter, &dba, pincode);
+	err = btd_adapter_pincode_reply(adapter, &dba, pincode,
+						pincode ? strlen(pincode) : 0);
 	if (err < 0)
 		goto fail;
 
@@ -140,7 +141,7 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
 	memset(pin, 0, sizeof(pin));
 	pinlen = read_pin_code(sba, dba, pin);
 	if (pinlen > 0) {
-		btd_adapter_pincode_reply(adapter, dba, pin);
+		btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
 		return 0;
 	}
 
-- 
1.7.5

