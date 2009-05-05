Return-Path: <cyrus@holtmann.org>
Subject: Re: BT git version triggers BUG: scheduling while atomic:
 swapper/0/0x10000100
From: Marcel Holtmann <marcel@holtmann.org>
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200905050323.42101.Hugo.Mildenberger@namir.de>
References: <200905050301.37528.Hugo.Mildenberger@namir.de>
	 <1241485973.3319.1.camel@localhost.localdomain>
	 <200905050323.42101.Hugo.Mildenberger@namir.de>
Content-Type: multipart/mixed; boundary="=-tn73CkV+R47GdOHsg4ga"
Date: Mon, 04 May 2009 18:56:53 -0700
Message-Id: <1241488613.3319.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-tn73CkV+R47GdOHsg4ga
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Hugo,

> > > When I tried to get a mobile phone connected to asterisk via bluetooth,
> > > the current git version of the linux bluetooth stack triggers a kernel
> > > bug:
> > >
> > > 	BUG: scheduling while atomic: swapper/0/0x10000100
> > >
> > > This is triggered the moment when asterisk tries to pair the phone and
> > > leaves at least the BT subsystem in an unusable state.
> >
> > are you running Linus' tree or bluetooth-testing.git? If your are not
> > running bluetooth-testing.git, then please try that one since it
> > includes a fix for it.
>
> I'm running bluetooth-testing.git and pulled that tree just an hour ago.

does the attached patch fixes your issue?

Regards

Marcel


--=-tn73CkV+R47GdOHsg4ga
Content-Disposition: attachment; filename="patch"
Content-Type: text/x-patch; name="patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 582d887..a05d45e 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -88,10 +88,13 @@ static struct device_type bt_link = {
 static void add_conn(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn, work_add);
+	struct hci_dev *hdev = conn->hdev;
 
 	/* ensure previous del is complete */
 	flush_work(&conn->work_del);
 
+	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
+
 	if (device_add(&conn->dev) < 0) {
 		BT_ERR("Failed to register connection device");
 		return;
@@ -154,12 +157,8 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 
 void hci_conn_add_sysfs(struct hci_conn *conn)
 {
-	struct hci_dev *hdev = conn->hdev;
-
 	BT_DBG("conn %p", conn);
 
-	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
-
 	queue_work(bt_workq, &conn->work_add);
 }
 

--=-tn73CkV+R47GdOHsg4ga--

