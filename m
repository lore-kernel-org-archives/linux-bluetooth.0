Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] emulator/bthost: Add support to set auth_req for bthost
Date: Mon, 19 May 2014 12:53:41 +0200
Message-ID: <1400496822-28557-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes possible to set Authentication_Requirements to be used
in io_capa_request_reply when replying for io_capa_request_evt.
---
 emulator/bthost.c | 8 +++++++-
 emulator/bthost.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 1e3123a..298edcf 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -206,6 +206,7 @@ struct bthost {
 	uint8_t pin[16];
 	uint8_t pin_len;
 	uint8_t io_capability;
+	uint8_t auth_req;
 	bool reject_user_confirm;
 	void *smp_data;
 	bool conn_init;
@@ -997,7 +998,7 @@ static void evt_io_cap_request(struct bthost *bthost, const void *data,
 	memcpy(cp.bdaddr, ev->bdaddr, 6);
 	cp.capability = bthost->io_capability;
 	cp.oob_data = 0x00;
-	cp.authentication = 0x00;
+	cp.authentication = bthost->auth_req;
 
 	send_command(bthost, BT_HCI_CMD_IO_CAPABILITY_REQUEST_REPLY,
 							&cp, sizeof(cp));
@@ -2146,6 +2147,11 @@ void bthost_set_io_capability(struct bthost *bthost, uint8_t io_capability)
 	bthost->io_capability = io_capability;
 }
 
+void bthost_set_auth_req(struct bthost *bthost, uint8_t auth_req)
+{
+	bthost->auth_req = auth_req;
+}
+
 void bthost_set_reject_user_confirm(struct bthost *bthost, bool reject)
 {
 	bthost->reject_user_confirm = reject;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 4933b33..b00bcd6 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -87,6 +87,7 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 void bthost_set_pin_code(struct bthost *bthost, const uint8_t *pin,
 							uint8_t pin_len);
 void bthost_set_io_capability(struct bthost *bthost, uint8_t io_capability);
+void bthost_set_auth_req(struct bthost *bthost, uint8_t auth_req);
 void bthost_set_reject_user_confirm(struct bthost *bthost, bool reject);
 
 typedef void (*bthost_rfcomm_connect_cb) (uint16_t handle, uint16_t cid,
-- 
1.9.3

