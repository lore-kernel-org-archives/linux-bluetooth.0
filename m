Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Date: Fri, 8 May 2009 15:59:14 -0700
Subject: bluetooth: module_refcount is not decreased when connection times
 out
Message-ID: <477F20668A386D41ADCC57781B1F704301E62956E5@SC-VEXCH1.marvell.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>



Hi,

The module refcount is increased by hci_dev_hold() call in hci_conn_add() i=
n hci_conn.c, and it is decreased by hci_dev_put() call in "del_conn" (hci_=
sysfs.c).

In case connection timeout happens, hci_dev_put() is never called.

Procedure to reproduce the issue:

# hciconfig hci0 up
# lsmod | grep btusb				-> "used by" refcount =3D 1

# hcitool cc <non-exisiting bdaddr>		-> will get timeout

# lsmod | grep btusb				-> "used by" refcount =3D 2
# hciconfig hci0 down
# lsmod | grep btusb				-> "used by" refcount =3D 1
# rmmod btusb					-> ERROR: Module btusb is in use


Regards,

Bing
