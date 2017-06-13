Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	John Keeping <john@metanate.com>
Subject: [PATCH v2 1/3] Bluetooth: make mgmt_status() public
Date: Tue, 13 Jun 2017 17:28:57 +0100
Message-Id: <20170613162859.25769-2-john@metanate.com>
In-Reply-To: <20170613162859.25769-1-john@metanate.com>
References: <20170613162859.25769-1-john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This function maps from HCI status codes to MGMT_STATUS_ values.  We
want to change the management function interface to take a MGMT_STATUS_
value rather than an HCI status so as to provide greater flexibility for
errors that do not result from HCI commands, which will involve moving
this mapping from mgmt.c into the callers.

Signed-off-by: John Keeping <john@metanate.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/mgmt.c             | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 95ccc1eef558..1c830730294c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1457,6 +1457,8 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
 
+u8 mgmt_status(u8 hci_status);
+
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1fba2a03f8ae..69b784fbe691 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -239,7 +239,7 @@ static u8 mgmt_status_table[] = {
 	MGMT_STATUS_CONNECT_FAILED,	/* MAC Connection Failed */
 };
 
-static u8 mgmt_status(u8 hci_status)
+u8 mgmt_status(u8 hci_status)
 {
 	if (hci_status < ARRAY_SIZE(mgmt_status_table))
 		return mgmt_status_table[hci_status];
-- 
2.12.2.648.g6730d8bc62.dirty
