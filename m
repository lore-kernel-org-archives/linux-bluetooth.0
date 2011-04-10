Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, hadess@hadess.net, dforsi@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/4] Make adapter API accept binary pincodes
Date: Sun, 10 Apr 2011 19:11:15 +0200
Message-Id: <1302455477-27664-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
References: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add pin-length argument to adapter API to allow passing binary pins
containing \0 characters to the hci handler.
---
 src/adapter.c |    4 ++--
 src/adapter.h |    2 +-
 src/event.c   |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 83f3217..14516ac 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3701,9 +3701,9 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 }
 
 int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							const char *pin)
+							const char *pin, size_t pinlen)
 {
-	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin, pin ? strlen(pin) : 0);
+	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin, pinlen);
 }
 
 int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
diff --git a/src/adapter.h b/src/adapter.h
index fd2fc12..b507506 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -273,7 +273,7 @@ int btd_adapter_disconnect_device(struct btd_adapter *adapter,
 int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 
 int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							const char *pin);
+							const char *pin, size_t pinlen);
 int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							gboolean success);
 int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
diff --git a/src/event.c b/src/event.c
index 4ca1be5..248fb78 100644
--- a/src/event.c
+++ b/src/event.c
@@ -111,13 +111,13 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 	device_get_address(device, &dba);
 
 	if (derr) {
-		err = btd_adapter_pincode_reply(adapter, &dba, NULL);
+		err = btd_adapter_pincode_reply(adapter, &dba, NULL, 0);
 		if (err < 0)
 			goto fail;
 		return;
 	}
 
-	err = btd_adapter_pincode_reply(adapter, &dba, pincode);
+	err = btd_adapter_pincode_reply(adapter, &dba, pincode, pincode ? strlen(pincode) : 0);
 	if (err < 0)
 		goto fail;
 
@@ -142,7 +142,7 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
 	memset(pin, 0, sizeof(pin));
 	pinlen = read_pin_code(sba, dba, pin);
 	if (pinlen > 0) {
-		btd_adapter_pincode_reply(adapter, dba, pin);
+		btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
 		return 0;
 	}
 
-- 
1.7.4.4

