Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: trivial: Correct endian conversion
Date: Fri,  9 Mar 2012 11:59:15 +0200
Message-Id: <1331287155-27588-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Correct endian conversion reported by sparse

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ad50b76..306451d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3388,7 +3388,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 	struct hci_conn *conn;
 	struct smp_ltk *ltk;
 
-	BT_DBG("%s handle %d", hdev->name, cpu_to_le16(ev->handle));
+	BT_DBG("%s handle %d", hdev->name, __le16_to_cpu(ev->handle));
 
 	hci_dev_lock(hdev);
 
-- 
1.7.9

