Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 02/26] Bluetooth: trivial: Remove empty line
Date: Fri, 17 Aug 2012 17:32:57 +0300
Message-Id: <1345214001-7053-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 28bab9d..42c00d18 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -268,7 +268,6 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 		BT_ERR("Unknown device type %d", hdev->dev_type);
 		break;
 	}
-
 }
 
 static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)
-- 
1.7.9.5

