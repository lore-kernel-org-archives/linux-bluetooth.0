Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5 v2] Bluetooth: Fix LE MTU reporting for HCIGETDEVINFO
Date: Fri, 19 Oct 2012 20:57:46 +0300
Message-Id: <1350669469-7719-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
References: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the use of le_mtu and le_pkts values in the
HCIGETDEVINFO ioctl for LE-only controllers.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dd05ed0..487308b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -990,10 +990,17 @@ int hci_get_dev_info(void __user *arg)
 	di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
 	di.flags    = hdev->flags;
 	di.pkt_type = hdev->pkt_type;
-	di.acl_mtu  = hdev->acl_mtu;
-	di.acl_pkts = hdev->acl_pkts;
-	di.sco_mtu  = hdev->sco_mtu;
-	di.sco_pkts = hdev->sco_pkts;
+	if (lmp_bredr_capable(hdev)) {
+		di.acl_mtu  = hdev->acl_mtu;
+		di.acl_pkts = hdev->acl_pkts;
+		di.sco_mtu  = hdev->sco_mtu;
+		di.sco_pkts = hdev->sco_pkts;
+	} else {
+		di.acl_mtu  = hdev->le_mtu;
+		di.acl_pkts = hdev->le_pkts;
+		di.sco_mtu  = 0;
+		di.sco_pkts = 0;
+	}
 	di.link_policy = hdev->link_policy;
 	di.link_mode   = hdev->link_mode;
 
-- 
1.7.10.4

