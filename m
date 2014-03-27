Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unnecessary NULL check in hci_inquiry_cache_update
Date: Thu, 27 Mar 2014 13:51:24 +0200
Message-Id: <1395921084-13605-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The ssp parameter is supposed to be a mandatory one and there are no
callers that would pass NULL to this function. Removing this unnecessary
NULL check also makes (false positive) static analyzer warnings go away.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c6189d9b6c09..7cf511cb1171 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2032,7 +2032,7 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 
 	ie = hci_inquiry_cache_lookup(hdev, &data->bdaddr);
 	if (ie) {
-		if (ie->data.ssp_mode && ssp)
+		if (ie->data.ssp_mode)
 			*ssp = true;
 
 		if (ie->name_state == NAME_NEEDED &&
-- 
1.9.0

