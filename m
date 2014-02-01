Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove __packed from struct smp_ltk
Date: Fri, 31 Jan 2014 18:42:18 -0800
Message-Id: <1391222538-34065-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The struct smp_ltk does not need to be packed and so remove __packed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6854384b1f25..4e878780fa01 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -101,7 +101,7 @@ struct smp_ltk {
 	__le16 ediv;
 	u8 rand[8];
 	u8 val[16];
-} __packed;
+};
 
 struct link_key {
 	struct list_head list;
-- 
1.8.5.3

