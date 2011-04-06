Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix Out Of Band pairing when mgmt interface is disabled
Date: Wed, 6 Apr 2011 13:01:59 +0200
Message-ID: <1302087719-18197-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use kernel stored remote Out Of Band data only if management interface
is enabled. Otherwise HCI_OP_REMOTE_OOB_DATA_NEG_REPLY was sent to
controller even if remote Out Of Band data was present in bluetoothd.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9062e1b..7a3103e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2498,6 +2498,9 @@ static inline void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
+	if (!test_bit(HCI_MGMT, &hdev->flags))
+		goto unlock;
+
 	data = hci_find_remote_oob_data(hdev, &ev->bdaddr);
 	if (data) {
 		struct hci_cp_remote_oob_data_reply cp;
@@ -2516,6 +2519,7 @@ static inline void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 									&cp);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
1.7.0.4

