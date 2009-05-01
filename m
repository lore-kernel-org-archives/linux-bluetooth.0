Return-Path: <cyrus@holtmann.org>
Message-Id: <49FA604C020000BF000290B6@mailgw2.hevs.ch>
Date: Fri, 01 May 2009 02:37:00 +0200
From: "Marc Pignat" <Marc.Pignat@hevs.ch>
To: <marcel@holtmann.org>,<jkosina@suse.cz>
Cc: <ext-roger.quadros@nokia.com>,<linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Subject: bluetooth: Fix serialization when adding/deleting connections in =
hci_sysfs

add_conn and del_conn should be serialized, but flush_workqueue can't be =
used
by the worker thread on it's own queue, so use flush_work to serialize =
add_conn
and del_conn against each other.

Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
---

patch against 2.6.30-rc4.


diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index b7c5108..42695e3 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -89,8 +89,8 @@ static void add_conn(struct work_struct *work)
 {
 	struct hci_conn *conn =3D container_of(work, struct hci_conn, =
work_add);
=20
-	/* ensure previous add/del is complete */
-	flush_workqueue(bluetooth);
+	/* ensure previous del is complete */
+	flush_work(&conn->work_del);
=20
 	if (device_add(&conn->dev) < 0) {
 		BT_ERR("Failed to register connection device");
@@ -134,8 +134,8 @@ static void del_conn(struct work_struct *work)
 	struct hci_conn *conn =3D container_of(work, struct hci_conn, =
work_del);
 	struct hci_dev *hdev =3D conn->hdev;
=20
-	/* ensure previous add/del is complete */
-	flush_workqueue(bluetooth);
+	/* ensure previous add is complete */
+	flush_work(&conn->work_add);
=20
 	while (1) {
 		struct device *dev;
