Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Correct type for ediv to __le16
Date: Fri,  9 Mar 2012 12:12:12 +0200
Message-Id: <1331287932-28824-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Correct type warnings reported by sparse to show that this
functions takes ediv argument in __le16 format.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    4 ++--
 net/bluetooth/hci_core.c         |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4af976c..9b12849 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -710,8 +710,8 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
 int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
-		int new_key, u8 authenticated, u8 tk[16], u8 enc_size, u16 ediv,
-		u8 rand[8]);
+		int new_key, u8 authenticated, u8 tk[16], u8 enc_size,
+		__le16 ediv, u8 rand[8]);
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 628b5b3..298ddbd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1378,7 +1378,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 }
 
 int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
-		int new_key, u8 authenticated, u8 tk[16], u8 enc_size, u16
+		int new_key, u8 authenticated, u8 tk[16], u8 enc_size, __le16
 		ediv, u8 rand[8])
 {
 	struct smp_ltk *key, *old_key;
-- 
1.7.9

