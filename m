Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth: module_refcount is not decreased when connection
 times out
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704301E62956E5@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E62956E5@SC-VEXCH1.marvell.com>
Content-Type: multipart/mixed; boundary="=-B6ApV2hNFH1KyHDMPQOO"
Date: Fri, 08 May 2009 16:27:19 -0700
Message-Id: <1241825239.4903.71.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-B6ApV2hNFH1KyHDMPQOO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Bing,

> The module refcount is increased by hci_dev_hold() call in hci_conn_add() in hci_conn.c, and it is decreased by hci_dev_put() call in "del_conn" (hci_sysfs.c).
> 
> In case connection timeout happens, hci_dev_put() is never called.

can you test the attached patch for quickly. It should fix it.

Regards

Marcel


--=-B6ApV2hNFH1KyHDMPQOO
Content-Disposition: attachment; filename="patch-fix-hci-dev-refcount"
Content-Type: text/x-patch; name="patch-fix-hci-dev-refcount"; charset="UTF-8"
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
index a05d45e..cd84cd4 100644
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
@@ -120,7 +122,7 @@ static void del_conn(struct work_struct *work)
 	flush_work(&conn->work_add);
 
 	if (!device_is_registered(&conn->dev))
-		return;
+		goto done;
 
 	while (1) {
 		struct device *dev;
@@ -134,6 +136,8 @@ static void del_conn(struct work_struct *work)
 
 	device_del(&conn->dev);
 	put_device(&conn->dev);
+
+done:
 	hci_dev_put(hdev);
 }
 

--=-B6ApV2hNFH1KyHDMPQOO--

