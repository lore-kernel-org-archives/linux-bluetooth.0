Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Consider DISCOVERY_LE_SCAN state in hci_discovery_active
Date: Fri, 13 Jan 2012 18:03:51 -0300
Message-Id: <1326488632-16759-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1326488632-16759-1-git-send-email-andre.guedes@openbossa.org>
References: <1326488632-16759-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ae765c4..6d6d3db 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -384,6 +384,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
 	struct discovery_state *discov = &hdev->discovery;
 
 	if (discov->state == DISCOVERY_INQUIRY ||
+					discov->state == DISCOVERY_LE_SCAN ||
 					discov->state == DISCOVERY_RESOLVING)
 		return true;
 
-- 
1.7.8.3

