Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 3/3] Bluetooth: Fix wrong packet type count increment
Date: Thu, 22 Apr 2010 03:51:39 -0300
Message-Id: <1271919099-22107-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1271919099-22107-2-git-send-email-gustavo@padovan.org>
References: <1271919099-22107-1-git-send-email-gustavo@padovan.org>
 <1271919099-22107-2-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 drivers/bluetooth/hci_vhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index bb0aefd..3aa7b2a 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -157,7 +157,7 @@ static inline ssize_t vhci_put_user(struct vhci_data *data,
 		break;
 
 	case HCI_SCODATA_PKT:
-		data->hdev->stat.cmd_tx++;
+		data->hdev->stat.sco_tx++;
 		break;
 	};
 
-- 
1.7.0.4
