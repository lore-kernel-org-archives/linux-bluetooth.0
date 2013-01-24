Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH v0 1/6] Bluetooth: Update the uuid list in reverse order
Date: Thu, 24 Jan 2013 11:27:54 +0530
Message-id: <1359007079-11724-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
References: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we add uuid in the list head, then initially added uuid's might
get lost because of the possibility of Max limit 240 reaches before
reaching the end of the list parsing.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
Tested-by: Chan-yeol Park <chanyeol.park@samsung.com>
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
1.7.9.5

