Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	johan.hedberg@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: vhci: Ignore return code of nonseekable_open()
Date: Wed, 28 Mar 2012 11:48:42 +0200
Message-Id: <1332928122-10919-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The comment in ./fs/open.c clearly states that nonseekable_open() will
never fail. Therefore, we can safely ignore the return code. This is the
recommended way to deal with nonseekable_open().
Our current code looks like nonseekable_open() is checked for the return
code. However, if we check the return code, we must also kfree() our
private data if the open fails. To avoid this overhead and to avoid
confusion, we simply drop the return code and return 0.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
See the UHID discussion for more information. Marcel suggested to also fix vhci
so here is the patch ;)

 drivers/bluetooth/hci_vhci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 2ed6ab1..d8a2a4f 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -260,8 +260,9 @@ static int vhci_open(struct inode *inode, struct file *file)
 	}
 
 	file->private_data = data;
+	nonseekable_open(inode, file);
 
-	return nonseekable_open(inode, file);
+	return 0;
 }
 
 static int vhci_release(struct inode *inode, struct file *file)
-- 
1.7.9.4
