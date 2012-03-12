Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] Bluetooth: mgmt: Add missing endian conversion
Date: Mon, 12 Mar 2012 12:13:11 +0200
Message-Id: <1331547191-15307-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add missing endian conversion for page scan interval and window.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 97b5b6c..06b5df3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2523,13 +2523,18 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	if (cp->val) {
 		type = PAGE_SCAN_TYPE_INTERLACED;
-		acp.interval = 0x0024;	/* 22.5 msec page scan interval */
+
+		/* 22.5 msec page scan interval */
+		acp.interval = __constant_cpu_to_le16(0x0024);
 	} else {
 		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
-		acp.interval = 0x0800;	/* default 1.28 sec page scan */
+
+		/* default 1.28 sec page scan */
+		acp.interval = __constant_cpu_to_le16(0x0800);
 	}
 
-	acp.window = 0x0012;	/* default 11.25 msec page scan window */
+	/* default 11.25 msec page scan window */
+	acp.window = __constant_cpu_to_le16(0x0012);
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY, sizeof(acp),
 			   &acp);
-- 
1.7.9

