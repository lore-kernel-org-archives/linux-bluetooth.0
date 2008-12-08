Return-Path: <cyrus@holtmann.org>
Message-ID: <493D6E2F.7000406@yahoo.com>
Date: Mon, 08 Dec 2008 19:57:51 +0100
From: Alban Browaeys <prahal@yahoo.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add parent dev in rfcomm tty sysfs registration
Content-Type: multipart/mixed;
 boundary="------------000608020506080806060305"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000608020506080806060305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is an attempt at getting the parent device to be bound to the sysfs 
entry of rfcomm tty.
This let hal detect it properly when connecting. No more.

Thus one have to :
$ rfcomm connect 0
after adding his configuration for the device to connect to in 
/etc/bluetooth/rfcomm.conf
One need a patch to hal (for to add the address and channel data to the 
hald/linux/device.c serial handler) and an fdi for  to add the  
capabilities  to get  the serial line to be recognized as a modem by 
NetworkManager.

Maybe it could be achieved at bind. Though this would either requires a 
change to rfcomm to get the sysfs data available at bind and not connect 
or to have hal poll bluez (I don't know yet if udev send event at rfcomm 
bind /dev/rfcommX creation so if polling could be avoided).


Also this does not address the lack of presence of rfcomm tty in 
/sys/devices. This I am too lost in the different device_move to know if 
it is registered in /sys/devices then moved to /sys/class/bluetooth or 
if something is missing for to get the entries in /sys/devices . Tty 
available documentation implying it should be automatic lead me to think 
device_move is the key of this issue.

So it is not a panacea but with this at least it becomes "possible" to 
get something out of hal and with a single script that rfcomm connect to 
get the bluetooth serial device in NetworkManager.

Greetings
Alban

--------------000608020506080806060305
Content-Type: text/x-patch;
 name="rfcomm_addparentdev_insysfs_registration.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rfcomm_addparentdev_insysfs_registration.diff"

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index d3340dd..c553acf 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -205,6 +205,7 @@ static DEVICE_ATTR(channel, S_IRUGO, show_channel, NULL);
 static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 {
 	struct rfcomm_dev *dev;
+	struct device * hdev;
 	struct list_head *head = &rfcomm_dev_list, *p;
 	int err = 0;
 
@@ -306,7 +307,12 @@ out:
 		return err;
 	}
 
-	dev->tty_dev = tty_register_device(rfcomm_tty_driver, dev->id, NULL);
+	hdev = rfcomm_get_device(dev);
+
+	printk("HDEV : %p", hdev);
+
+	dev->tty_dev = tty_register_device(rfcomm_tty_driver, dev->id, hdev);
+	//dev->tty_dev = tty_register_device(rfcomm_tty_driver, dev->id, NULL);
 
 	if (IS_ERR(dev->tty_dev)) {
 		err = PTR_ERR(dev->tty_dev);

--------------000608020506080806060305--

