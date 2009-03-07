Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
Subject: [PATCH 1/2] Propagata hci_register_sysfs() error
Date: Sat,  7 Mar 2009 23:10:28 +0100
Message-Id: <1236463829-19977-1-git-send-email-erik.andren@gmail.com>
In-Reply-To: <1>
References: <1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently if the hci_register_sysfs() function fails, the error is not propagated. Make it so.

Signed-off-by: Erik Andrén <erik.andren@gmail.com>
---
 net/bluetooth/hci_core.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cd06151..9c98f6e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -842,7 +842,7 @@ EXPORT_SYMBOL(hci_free_dev);
 int hci_register_dev(struct hci_dev *hdev)
 {
 	struct list_head *head = &hci_dev_list, *p;
-	int i, id = 0;
+	int i, err, id = 0;
 
 	BT_DBG("%p name %s type %d owner %p", hdev, hdev->name, hdev->type, hdev->owner);
 
@@ -855,7 +855,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	list_for_each(p, &hci_dev_list) {
 		if (list_entry(p, struct hci_dev, list)->id != id)
 			break;
-		head = p; id++;
+		head = p;
+		id++;
 	}
 
 	sprintf(hdev->name, "hci%d", id);
@@ -898,7 +899,9 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	write_unlock_bh(&hci_dev_list_lock);
 
-	hci_register_sysfs(hdev);
+	err = hci_register_sysfs(hdev);
+	if (err < 0)
+		return err;
 
 	hci_notify(hdev, HCI_DEV_REG);
 
-- 
1.5.6.3

