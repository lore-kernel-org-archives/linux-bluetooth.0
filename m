Return-Path: <mkarthi3@visteon.com>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] net: bluetooth: clean up af_bluetooth code
Date: Tue, 17 Nov 2015 11:06:53 +0000
Message-ID: <20151117110649.GA4222@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Fix error reported by checkpatch.
ERROR:"foo* bar" should be "foo *bar"

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 net/bluetooth/af_bluetooth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index a3bffd1..5e9fee9 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -671,7 +671,7 @@ static const struct file_operations bt_fops =3D {
 };
=20
 int bt_procfs_init(struct net *net, const char *name,
-		   struct bt_sock_list* sk_list,
+		   struct bt_sock_list *sk_list,
 		   int (* seq_show)(struct seq_file *, void *))
 {
 	sk_list->custom_seq_show =3D seq_show;
@@ -687,7 +687,7 @@ void bt_procfs_cleanup(struct net *net, const char *nam=
e)
 }
 #else
 int bt_procfs_init(struct net *net, const char *name,
-		   struct bt_sock_list* sk_list,
+		   struct bt_sock_list *sk_list,
 		   int (* seq_show)(struct seq_file *, void *))
 {
 	return 0;
--=20
1.9.1
