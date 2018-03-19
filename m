Return-Path: <paulmcquad@gmail.com>
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: trailing statements
Date: Mon, 19 Mar 2018 11:32:21 +0000
Message-Id: <20180319113222.6725-3-paulmcquad@gmail.com>
In-Reply-To: <20180319113222.6725-1-paulmcquad@gmail.com>
References: <20180319113222.6725-1-paulmcquad@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

trailing statements should be on next line

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/bluetooth/hci_ll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 1b4417a623a4..06d859d82de8 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -567,7 +567,8 @@ static int read_local_version(struct hci_dev *hdev)
 	version = le16_to_cpu(ver->lmp_subver);
 
 out:
-	if (err) bt_dev_err(hdev, "Failed to read TI version info: %d", err);
+	if (err)
+	bt_dev_err(hdev, "Failed to read TI version info: %d", err);
 	kfree_skb(skb);
 	return err ? err : version;
 }
-- 
2.16.2
