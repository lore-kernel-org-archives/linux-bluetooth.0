Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, hadess@hadess.net, padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/5] Add length argument to hci pincode reply
Date: Thu,  5 May 2011 21:17:16 +0200
Message-Id: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a new "length" argument to the hci pincode reply to allow
sending binary pins including \0 characters.
---
 plugins/hciops.c  |   10 +++++-----
 plugins/mgmtops.c |    9 ++++-----
 src/adapter.c     |    3 ++-
 src/adapter.h     |    3 ++-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 2c49e35..b125699 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3415,7 +3415,8 @@ static int hciops_remove_bonding(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int hciops_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
+static int hciops_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin,
+								size_t pin_len)
 {
 	struct dev_info *dev = &devs[index];
 	char addr[18];
@@ -3426,14 +3427,13 @@ static int hciops_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
 
 	if (pin) {
 		pin_code_reply_cp pr;
-		size_t len = strlen(pin);
 
-		dev->pin_length = len;
+		dev->pin_length = pin_len;
 
 		memset(&pr, 0, sizeof(pr));
 		bacpy(&pr.bdaddr, bdaddr);
-		memcpy(pr.pin_code, pin, len);
-		pr.pin_len = len;
+		memcpy(pr.pin_code, pin, pin_len);
+		pr.pin_len = pin_len;
 		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
 						OCF_PIN_CODE_REPLY,
 						PIN_CODE_REPLY_CP_SIZE, &pr);
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 9e1cfac..ce0ec2d 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -494,7 +494,8 @@ static void mgmt_connect_failed(int sk, uint16_t index, void *buf, size_t len)
 	btd_event_bonding_complete(&info->bdaddr, &ev->bdaddr, ev->status);
 }
 
-static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
+static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin,
+								size_t pin_len)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_pin_code_reply)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -502,7 +503,7 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
 	char addr[18];
 
 	ba2str(bdaddr, addr);
-	DBG("index %d addr %s pin %s", index, addr, pin ? pin : "<none>");
+	DBG("index %d addr %s pinlen %lu", index, addr, pin_len);
 
 	memset(buf, 0, sizeof(buf));
 
@@ -519,9 +520,7 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin)
 		buf_len = sizeof(*hdr) + sizeof(*cp);
 	} else {
 		struct mgmt_cp_pin_code_reply *cp;
-		size_t pin_len;
 
-		pin_len = strlen(pin);
 		if (pin_len > 16)
 			return -EINVAL;
 
@@ -569,7 +568,7 @@ static void mgmt_pin_code_request(int sk, uint16_t index, void *buf, size_t len)
 	err = btd_event_request_pin(&info->bdaddr, &ev->bdaddr);
 	if (err < 0) {
 		error("btd_event_request_pin: %s", strerror(-err));
-		mgmt_pincode_reply(index, &ev->bdaddr, NULL);
+		mgmt_pincode_reply(index, &ev->bdaddr, NULL, 0);
 	}
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index f068335..b7016c4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3545,7 +3545,8 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							const char *pin)
 {
-	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin);
+	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin,
+							pin ? strlen(pin) : 0);
 }
 
 int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
diff --git a/src/adapter.h b/src/adapter.h
index 9406b9b..e08068c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -201,7 +201,8 @@ struct btd_adapter_ops {
 	int (*read_local_features) (int index, uint8_t *features);
 	int (*disconnect) (int index, bdaddr_t *bdaddr);
 	int (*remove_bonding) (int index, bdaddr_t *bdaddr);
-	int (*pincode_reply) (int index, bdaddr_t *bdaddr, const char *pin);
+	int (*pincode_reply) (int index, bdaddr_t *bdaddr, const char *pin,
+							size_t pin_len);
 	int (*confirm_reply) (int index, bdaddr_t *bdaddr, gboolean success);
 	int (*passkey_reply) (int index, bdaddr_t *bdaddr, uint32_t passkey);
 	int (*enable_le) (int index);
-- 
1.7.5

