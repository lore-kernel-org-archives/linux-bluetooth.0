Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH] Bluetooth: Don't set Discoverty Type while stopping Discovery
Date: Thu, 5 Apr 2012 10:27:21 +0530
Message-ID: <1333601841-2301-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch prevents resetting of discovery type while stopping
discovery, which was sending wrong type information to management
interface of BlueZ when discovery failed.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/hci_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 286f3fc..9629645 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -386,7 +386,6 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	case DISCOVERY_STOPPED:
 		if (hdev->discovery.state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
-		hdev->discovery.type = 0;
 		break;
 	case DISCOVERY_STARTING:
 		break;
-- 
1.7.0.4

