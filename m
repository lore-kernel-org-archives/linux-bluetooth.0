Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: MGMT stop discovery LE support
Date: Fri, 13 Jan 2012 18:03:52 -0300
Message-Id: <1326488632-16759-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1326488632-16759-1-git-send-email-andre.guedes@openbossa.org>
References: <1326488632-16759-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to MGMT stop discovery command so now we are
able to cancel LE-based discovery procedures.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 05e6c1f..a8b60dc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2000,6 +2000,15 @@ static int stop_discovery(struct sock *sk, u16 index)
 		goto unlock;
 	}
 
+	if (hdev->discovery.state == DISCOVERY_LE_SCAN) {
+		err = hci_cancel_le_scan(hdev);
+		if (err < 0)
+			mgmt_pending_remove(cmd);
+		else
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
+		goto unlock;
+	}
+
 	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_PENDING);
 	if (!e) {
 		mgmt_pending_remove(cmd);
-- 
1.7.8.3

