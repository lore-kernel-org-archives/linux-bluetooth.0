Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 4/4] Bluetooth: trivial: Use preferred method for NULL check
Date: Tue,  7 Aug 2012 18:05:06 +0300
Message-Id: <1344351906-27563-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use standard bluetooth way to check NULL pointer !var instead of
var == NULL.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/af_bluetooth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index a724f6c..a9ad589 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -620,7 +620,7 @@ static int bt_seq_open(struct inode *inode, struct file *file)
 	sk_list = PDE(inode)->data;
 	s = __seq_open_private(file, &bt_seq_ops,
 			       sizeof(struct bt_seq_state));
-	if (s == NULL)
+	if (!s)
 		return -ENOMEM;
 
 	s->l = sk_list;
@@ -642,7 +642,7 @@ int bt_procfs_init(struct module* module, struct net *net, const char *name,
 	sk_list->fops.release   = seq_release_private;
 
 	pde = proc_net_fops_create(net, name, 0, &sk_list->fops);
-	if (pde == NULL)
+	if (!pde)
 		return -ENOMEM;
 
 	pde->data = sk_list;
-- 
1.7.9.5

