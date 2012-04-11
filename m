Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v0 3/6] Bluetooth: Remove unused HCI event handling
Date: Wed, 11 Apr 2012 08:48:49 +0200
Message-Id: <1334126932-27327-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Function hci_num_comp_pkts_evt() doesn't need to handle SCO connections
unless SCO flow control is explicitly enabled, as described in the
Bluetooth Core Specification, Volume 4, Part B, section 7.7.19.

Even in the unlikely case that the hardware supports this feature, the
kernel does not enable it.

Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
---
 net/bluetooth/hci_event.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bb6d802..78f0d58 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2538,12 +2538,6 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 			}
 			break;
 
-		case SCO_LINK:
-			hdev->sco_cnt += count;
-			if (hdev->sco_cnt > hdev->sco_pkts)
-				hdev->sco_cnt = hdev->sco_pkts;
-			break;
-
 		default:
 			BT_ERR("Unknown type %d conn %p", conn->type, conn);
 			break;
-- 
1.7.7.6

