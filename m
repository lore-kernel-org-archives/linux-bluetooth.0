Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] Bluetooth: Remove unneeded flag
Date: Tue, 14 May 2013 11:44:17 +0300
Message-Id: <1368521057-20931-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1368521057-20931-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20130507114116.GA11873@x220>
 <1368521057-20931-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove HCI_LINK_KEYS flag since using HCI_MGMT is enough for test that
user space expects the kernel managing link keys.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h | 1 -
 net/bluetooth/mgmt.c        | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e0512aa..3c592cf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -107,7 +107,6 @@ enum {
 	HCI_MGMT,
 	HCI_PAIRABLE,
 	HCI_SERVICE_CACHE,
-	HCI_LINK_KEYS,
 	HCI_DEBUG_KEYS,
 	HCI_UNREGISTER,
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8567764..5cd3aee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1736,8 +1736,6 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_link_keys_clear(hdev);
 
-	set_bit(HCI_LINK_KEYS, &hdev->dev_flags);
-
 	if (cp->debug_keys)
 		set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
 	else
-- 
1.8.1.2

