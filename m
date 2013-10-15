Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Introduce flag for limited discoverable mode
Date: Tue, 15 Oct 2013 06:33:53 -0700
Message-Id: <1381844037-24424-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new flag that can be set when in limited discoverable mode. This
flag will cause the limited discoverable bit in the class of device
value to bet set.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/mgmt.c        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b096f5f..f4650a8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -125,6 +125,7 @@ enum {
 	HCI_ADVERTISING,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
+	HCI_LIMITED_DISCOVERABLE,
 	HCI_LINK_SECURITY,
 	HCI_PERIODIC_INQ,
 	HCI_FAST_CONNECTABLE,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 285d571..d5eaa28 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -724,6 +724,9 @@ static void update_class(struct hci_request *req)
 	cod[1] = hdev->major_class;
 	cod[2] = get_service_classes(hdev);
 
+	if (test_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags))
+		cod[1] |= 0x20;
+
 	if (memcmp(cod, hdev->dev_class, 3) == 0)
 		return;
 
-- 
1.8.3.1

