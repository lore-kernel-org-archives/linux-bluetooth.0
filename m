Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] bluetooth: vhci: Clean up coding style fix
Date: Tue, 2 Jun 2015 10:50:15 +0000
Message-ID: <20150602105003.GA2880@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

>From : Prasanna Karthik <mkarthi3@visteon.com>

fix spaces required around that '=3D' reported by checkpatch

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/hci_vhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 6653473..78653db 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -366,7 +366,7 @@ static const struct file_operations vhci_fops =3D {
 	.llseek		=3D no_llseek,
 };
=20
-static struct miscdevice vhci_miscdev=3D {
+static struct miscdevice vhci_miscdev =3D {
 	.name	=3D "vhci",
 	.fops	=3D &vhci_fops,
 	.minor	=3D VHCI_MINOR,
--=20
1.7.0.4
