Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/17] Bluetooth: Make inquiry_cache_flush non-static
Date: Thu,  4 Apr 2013 20:21:03 -0300
Message-Id: <1365117675-2202-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to use HCI request framework in start_discovery, we'll need
to call inquiry_cache_flush in mgmt.c. Therefore, this patch makes
inquiry_cache_flush non-static

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0e7ee89..4713514 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -431,6 +431,7 @@ void hci_inquiry_cache_update_resolve(struct hci_dev *hdev,
 				      struct inquiry_entry *ie);
 bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 			      bool name_known, bool *ssp);
+void inquiry_cache_flush(struct hci_dev *hdev);
 
 /* ----- HCI Connections ----- */
 enum {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 43ea7e3..eecab8e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -630,7 +630,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	hdev->discovery.state = state;
 }
 
-static void inquiry_cache_flush(struct hci_dev *hdev)
+void inquiry_cache_flush(struct hci_dev *hdev)
 {
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *p, *n;
-- 
1.8.1.2

