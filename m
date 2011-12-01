Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 3/3] Bluetooth: trivial: correct check for LMP version
Date: Thu,  1 Dec 2011 14:33:28 +0200
Message-Id: <1322742808-8507-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322742808-8507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322742808-8507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make sure that code match exactly what comment says about pre 1.2
bluetooth version. Since this is HCI detail lmp_ver changed to hci_ver.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 445da8d..957cdd5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -498,7 +498,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 
 	/* CSR 1.1 dongles does not accept any bitfield so don't try to set
 	 * any event mask for pre 1.2 devices */
-	if (hdev->lmp_ver <= BLUETOOTH_VER_1_1)
+	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return;
 
 	events[4] |= 0x01; /* Flow Specification Complete */
-- 
1.7.4.1

