Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] bluetooth: bt3c_cs: clean up obsolete functions
Date: Fri, 11 Sep 2015 15:02:36 +0000
Message-ID: <20150911150226.GA12951@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

simple_strtoul is obsolete, use kstrtoul instead reported by checkpatch.

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/bt3c_cs.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 7aab654..33b09be 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -453,7 +453,8 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 {
 	char *ptr =3D (char *) firmware;
 	char b[9];
-	unsigned int iobase, size, addr, fcs, tmp;
+	unsigned int iobase, tmp;
+	unsigned long size, addr, fcs;
 	int i, err =3D 0;
=20
 	iobase =3D info->p_dev->resource[0]->start;
@@ -478,15 +479,18 @@ static int bt3c_load_firmware(struct bt3c_info *info,
=20
 		memset(b, 0, sizeof(b));
 		memcpy(b, ptr + 2, 2);
-		size =3D simple_strtoul(b, NULL, 16);
+		if (kstrtoul(b, 16, &size) < 0)
+			return -EINVAL;
=20
 		memset(b, 0, sizeof(b));
 		memcpy(b, ptr + 4, 8);
-		addr =3D simple_strtoul(b, NULL, 16);
+		if (kstrtoul(b, 16, &addr) < 0)
+			return -EINVAL;
=20
 		memset(b, 0, sizeof(b));
 		memcpy(b, ptr + (size * 2) + 2, 2);
-		fcs =3D simple_strtoul(b, NULL, 16);
+		if (kstrtoul(b, 16, &fcs) < 0)
+			return -EINVAL;
=20
 		memset(b, 0, sizeof(b));
 		for (tmp =3D 0, i =3D 0; i < size; i++) {
--=20
1.7.0.4
