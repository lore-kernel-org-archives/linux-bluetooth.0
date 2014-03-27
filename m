Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 3/3] Bluetooth: Keep msec in DISCOV_LE_TIMEOUT
Date: Thu, 27 Mar 2014 20:55:21 +0100
Message-ID: <1395950121-12263-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395950121-12263-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395950121-12263-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To be consistent, lets use msec for this timeout as well.

Note: This define value is a minimum scan time taken from BT Core spec 4.0,
Vol 3, Part C, chapter 9.2.6

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/mgmt.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7d75544..93d20cc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1210,7 +1210,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
  */
 #define DISCOV_LE_SCAN_WIN		0x12
 #define DISCOV_LE_SCAN_INT		0x12
-#define DISCOV_LE_TIMEOUT		msecs_to_jiffies(10240)
+#define DISCOV_LE_TIMEOUT		10240	/* msec */
 #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b97477f..d0be229 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3369,7 +3369,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
-		timeout = DISCOV_LE_TIMEOUT;
+		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-- 
1.8.4

