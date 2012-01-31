Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org, Andre Guedes <aguedespe@gmail.com>
Subject: [PATCH] Bluetooth: Use GFP_KERNEL in hci_add_adv_entry()
Date: Mon, 30 Jan 2012 23:31:28 -0300
Message-Id: <1327977088-32223-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is not called in interrupt context anymore, so it
should use GFP_KERNEL to allocate memory.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 net/bluetooth/hci_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 91166db..45e2d2a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1553,7 +1553,7 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	if (hci_find_adv_entry(hdev, &ev->bdaddr))
 		return 0;
 
-	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
 
-- 
1.7.9

