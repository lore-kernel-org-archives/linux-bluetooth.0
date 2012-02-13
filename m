Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: DISCOVERY_STOPPED state
Date: Mon, 13 Feb 2012 15:41:02 -0300
Message-Id: <1329158462-28914-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1329158462-28914-1-git-send-email-andre.guedes@openbossa.org>
References: <1329158462-28914-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are not supposed to send mgmt_discovering events if we are
transiting from DISCOVERY_STARTING to DISCOVERY_STOPPED state.
It doesn't make sense to send mgmt_discovering event once
discovery procedure has not been even started.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9ada164..dc31e7d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -380,7 +380,8 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
-		mgmt_discovering(hdev, 0);
+		if (hdev->discovery.state != DISCOVERY_STARTING)
+			mgmt_discovering(hdev, 0);
 		break;
 	case DISCOVERY_STARTING:
 		break;
-- 
1.7.9

