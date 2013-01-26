Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9 v3] Bluetooth: Store UUIDs in the same order that they were added
Date: Sat, 26 Jan 2013 12:08:36 +0200
Message-Id: <1359194924-3151-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
References: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should be encoding UUIDs to the EIR data in the same order that they
were added to the kernel, i.e. each UUID should be added to the end of
the UUIDs list. This patch fixes the issue by using list_add_tail
instead of list_add for storing the UUIDs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e7f944f..4fd45a3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1330,7 +1330,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	memcpy(uuid->uuid, cp->uuid, 16);
 	uuid->svc_hint = cp->svc_hint;
 
-	list_add(&uuid->list, &hdev->uuids);
+	list_add_tail(&uuid->list, &hdev->uuids);
 
 	err = update_class(hdev);
 	if (err < 0)
-- 
1.7.10.4

