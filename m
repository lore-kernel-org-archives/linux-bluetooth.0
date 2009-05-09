Return-Path: <cyrus@holtmann.org>
Subject: RE: bluetooth: module_refcount is not decreased when connection
 times out
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704301E6295717@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E62956E5@SC-VEXCH1.marvell.com>
	 <1241825239.4903.71.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301E6295717@SC-VEXCH1.marvell.com>
Content-Type: multipart/mixed; boundary="=-zk05iu8XSHyPm4XIi6ll"
Date: Fri, 08 May 2009 17:03:55 -0700
Message-Id: <1241827435.4903.76.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-zk05iu8XSHyPm4XIi6ll
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Bing,

> > > The module refcount is increased by hci_dev_hold() call in hci_conn_add() in hci_conn.c, and it is
> > decreased by hci_dev_put() call in "del_conn" (hci_sysfs.c).
> > >
> > > In case connection timeout happens, hci_dev_put() is never called.
> > 
> > can you test the attached patch for quickly. It should fix it.
>
> It seems that hdev is "put" twice with the patch, if the connection fails.
> 
> # hciconfig hci0 up
> # lsmod | grep btusb				-> "used by" refcount = 1
> 
> # hcitool cc <non-exisiting bdaddr>		-> will get timeout
> # lsmod | grep btusb				-> "used by" refcount = 0 (??)
> 
> # hcitool cc <non-exisiting bdaddr>		-> time out again
> # lsmod | grep btusb				-> "used by" refcount = 4294967295 (??)

the previous patch has one tiny bug. Is this one better?

Regards

Marcel


--=-zk05iu8XSHyPm4XIi6ll
Content-Disposition: attachment; filename="patch-fix-hci-dev-refcount-v2"
Content-Type: text/x-patch; name="patch-fix-hci-dev-refcount-v2"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 61309b2..85a1c6b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -292,6 +292,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	hci_conn_del_sysfs(conn);
 
+	hci_dev_put(hdev);
+
 	return 0;
 }
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index a05d45e..4cc3624 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -99,6 +99,8 @@ static void add_conn(struct work_struct *work)
 		BT_ERR("Failed to register connection device");
 		return;
 	}
+
+	hci_dev_hold(hdev);
 }
 
 /*
@@ -134,6 +136,7 @@ static void del_conn(struct work_struct *work)
 
 	device_del(&conn->dev);
 	put_device(&conn->dev);
+
 	hci_dev_put(hdev);
 }
 

--=-zk05iu8XSHyPm4XIi6ll--

