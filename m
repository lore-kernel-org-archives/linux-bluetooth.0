Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Aug 2011 17:22:45 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: [patch] bluetooth: unlock if allocation fails in hci_blacklist_add()
Message-ID: <20110803142244.GL3839@shale.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

There was a small typo here so we never actually hit the goto which
would call hci_dev_unlock_bh().

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index baaf5eb..56943ad 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1326,7 +1326,7 @@ int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
 	if (!entry) {
-		return -ENOMEM;
+		err = -ENOMEM;
 		goto err;
 	}
 
