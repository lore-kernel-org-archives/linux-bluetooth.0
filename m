Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix coding style issues in mgmt code
Date: Wed, 22 Feb 2012 13:21:16 +0200
Message-Id: <1329909677-17311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In this case we need to use braces in both branches.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e8f890d..7cb52df 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -952,9 +952,9 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 		if (!!cp->val != test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 			changed = true;
 
-		if (cp->val)
+		if (cp->val) {
 			set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
-		else {
+		} else {
 			clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 		}
@@ -987,9 +987,9 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
-	if (cp->val)
+	if (cp->val) {
 		scan = SCAN_PAGE;
-	else {
+	} else {
 		scan = 0;
 
 		if (test_bit(HCI_ISCAN, &hdev->flags) &&
-- 
1.7.9

