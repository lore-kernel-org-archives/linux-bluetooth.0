Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH] Bluetooth: Fix incorrect bits for LE states
Date: Fri,  9 Feb 2018 18:26:02 +0100
Message-Id: <20180209172602.20250-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes incorrect checks for LE states.
Issues found when doing mgmt tests for scenario
when Linux Kernel should do connectable advertising
while connected.

Signed-off-by: Łukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
---
 net/bluetooth/hci_request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3394e6791673..66c0781773df 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -934,8 +934,8 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 		/* Slave connection state and connectable mode bit 38
 		 * and scannable bit 21.
 		 */
-		if (connectable && (!(hdev->le_states[4] & 0x01) ||
-				    !(hdev->le_states[2] & 0x40)))
+		if (connectable && (!(hdev->le_states[4] & 0x40) ||
+				    !(hdev->le_states[2] & 0x20)))
 			return false;
 	}
 
@@ -948,7 +948,7 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 		/* Master connection state and connectable mode bit 35 and
 		 * scannable 19.
 		 */
-		if (connectable && (!(hdev->le_states[4] & 0x10) ||
+		if (connectable && (!(hdev->le_states[4] & 0x08) ||
 				    !(hdev->le_states[2] & 0x08)))
 			return false;
 	}
-- 
2.14.1

