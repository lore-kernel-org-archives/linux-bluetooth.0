Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] Bluetooth: Make mgmt_new_ltk() return void
Date: Tue, 15 Oct 2013 14:26:29 -0700
Message-Id: <1381872389-34389-10-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_new_ltk() function is not used and
so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/mgmt.c             | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5d8d322..0a3a10a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1125,7 +1125,7 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 
 /* HCI info for socket */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1ed0b3e..90d9353 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4382,7 +4382,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
 {
 	struct mgmt_ev_new_long_term_key ev;
 
@@ -4401,8 +4401,7 @@ int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
 	memcpy(ev.key.rand, key->rand, sizeof(key->rand));
 	memcpy(ev.key.val, key->val, sizeof(key->val));
 
-	return mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev),
-			  NULL);
+	mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
 static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
-- 
1.8.3.1

