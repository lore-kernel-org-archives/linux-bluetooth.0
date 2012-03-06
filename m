Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check FINDING state in interleaved discovery
Date: Tue,  6 Mar 2012 19:37:06 -0300
Message-Id: <1331073426-11427-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to do interleaved discovery we should be in DISCOVERY_
FINDING state. Otherwise, discovery should be stopped.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6a817da..c995c79 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1101,7 +1101,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		schedule_delayed_work(&hdev->adv_work, ADV_CLEAR_TIMEOUT);
 
-		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED) {
+		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
+				hdev->discovery.state == DISCOVERY_FINDING) {
 			mgmt_interleaved_discovery(hdev);
 		} else {
 			hci_dev_lock(hdev);
-- 
1.7.9.2

