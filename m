Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 2/2] Bluetooh: Fix hci_cc_read_local_ext_features()
Date: Fri, 30 Dec 2011 10:34:04 -0300
Message-Id: <1325252044-21134-2-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1325252044-21134-1-git-send-email-aguedespe@gmail.com>
References: <1325252044-21134-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Copy the Features value according to the Page number.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 net/bluetooth/hci_event.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 37c31c5..10152d2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -711,7 +711,14 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
-	memcpy(hdev->host_features, rp->features, 8);
+	switch (rp->page) {
+	case 0:
+		memcpy(hdev->features, rp->features, 8);
+		break;
+	case 1:
+		memcpy(hdev->host_features, rp->features, 8);
+		break;
+	}
 
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
 }
-- 
1.7.8.1

