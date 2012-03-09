Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Add missing endian conversion
Date: Fri,  9 Mar 2012 17:05:49 +0200
Message-Id: <1331305549-3066-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add missing endian conversion for page scan interval and window.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 97b5b6c..06d2eaf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2523,13 +2523,18 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	if (cp->val) {
 		type = PAGE_SCAN_TYPE_INTERLACED;
-		acp.interval = 0x0024;	/* 22.5 msec page scan interval */
+
+		/* 22.5 msec page scan interval */
+		acp.interval = cpu_to_le16(0x0024);
 	} else {
 		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
-		acp.interval = 0x0800;	/* default 1.28 sec page scan */
+
+		/* default 1.28 sec page scan */
+		acp.interval = cpu_to_le16(0x0800);
 	}
 
-	acp.window = 0x0012;	/* default 11.25 msec page scan window */
+	/* default 11.25 msec page scan window */
+	acp.window = cpu_to_le16(0x0012);
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY, sizeof(acp),
 			   &acp);
-- 
1.7.9

