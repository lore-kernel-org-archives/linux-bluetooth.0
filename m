Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: Fix missing update of pend_le_reports
Date: Thu,  3 Jul 2014 19:33:47 +0300
Message-Id: <1404405231-16390-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
References: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When calling Remove Device for an entry using HCI_AUTO_CONN_REPORT we
need to decrement the pend_le_reports value correspondingly. This patch
fixes one such missing action in the Remove Device command handler.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c01cc5e37a6f..02a4d31fee30 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5198,6 +5198,9 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
+		if (params->auto_connect == HCI_AUTO_CONN_REPORT)
+			hdev->pend_le_reports--;
+
 		hci_pend_le_conn_del(hdev, &cp->addr.bdaddr, addr_type);
 		list_del(&params->list);
 		kfree(params);
-- 
1.9.3

