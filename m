Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/3] Bluetooth: trivial: correct check for LMP version
Date: Wed, 30 Nov 2011 10:44:55 +0200
Message-Id: <1322642695-5784-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322642695-5784-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322642695-5784-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make sure that code match exactly what comment says about pre 1.2
LMP version.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 60651fa..27b1ede 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -498,7 +498,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 
 	/* CSR 1.1 dongles does not accept any bitfield so don't try to set
 	 * any event mask for pre 1.2 devices */
-	if (hdev->lmp_ver <= BLUETOOTH_VER_1_1)
+	if (hdev->lmp_ver < BLUETOOTH_VER_1_2)
 		return;
 
 	events[4] |= 0x01; /* Flow Specification Complete */
-- 
1.7.4.1

