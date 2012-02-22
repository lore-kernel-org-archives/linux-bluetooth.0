Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: mgmt: Fix clearing of hdev->eir
Date: Wed, 22 Feb 2012 16:02:42 +0200
Message-Id: <1329919363-23660-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
References: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hdev->eir buffer needs to be cleared when clearing the EIR data.
Otherwise subsequent attempts at setting the EIR to something valid
again may fail because the code thinks that the EIR hasn't changed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bdaadb2..08c657d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3400,6 +3400,8 @@ static int clear_eir(struct hci_dev *hdev)
 	if (!(hdev->features[6] & LMP_EXT_INQ))
 		return 0;
 
+	memset(hdev->eir, 0, sizeof(hdev->eir));
+
 	memset(&cp, 0, sizeof(cp));
 
 	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
-- 
1.7.9

