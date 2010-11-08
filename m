Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Nov 2010 02:37:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez-4.78 broken for me
Message-ID: <20101108003740.GA7213@jh-x301>
References: <20101108003042.35493250@susi.home.s3e.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <20101108003042.35493250@susi.home.s3e.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stefan,

On Mon, Nov 08, 2010, Stefan Seyfried wrote:
> since I did upgrade to bluez-4.78, all I get when enabling the bluetooth
> adapter on my Thinkpad X200s is:
> 
> kernel: [248420.020080] usb 4-2: new full speed USB device using uhci_hcd and address 7
> kernel: [248420.179082] usb 4-2: New USB device found, idVendor=0a5c, idProduct=2145
> kernel: [248420.179087] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> kernel: [248420.179090] usb 4-2: Product: ThinkPad Bluetooth with Enhanced Data Rate II
> kernel: [248420.179094] usb 4-2: Manufacturer: Lenovo Computer Corp
> bluetoothd[4390]: Bluetooth deamon 4.78
> bluetoothd[4393]: Starting SDP server
> bluetoothd[4393]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
> bluetoothd[4393]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
> bluetoothd[4393]: HCI dev 0 registered
> bluetoothd[4393]: HCI dev 0 up
> bluetoothd[4393]: Starting security manager 0
> bluetoothd[4393]: Parsing /etc/bluetooth/serial.conf failed: No such file or directory
> bluetoothd[4393]: Adapter /org/bluez/4390/hci0 has been enabled
> bluetoothd[4393]: Unable to find matching adapter
> bluetoothd[4393]: No matching adapter found
> bluetoothd[4393]: Unable to find matching adapter
> bluetoothd[4393]: No matching adapter found
> bluetoothd[4393]: Unable to find matching adapter
> bluetoothd[4393]: No matching adapter found
> bluetoothd[4393]: Unable to find matching adapter

You really should enable debug logs (-d switch) to get more info about
which code paths are being traveresed here (since there are many places
which can cause those log messages). However, my suspicion goes to a
possible mismatch in the adapter address upon initialization and later
lookups. Could you try if the attached patch fixes the issue? Thanks.

Johan

--7AUc2qLy4jB3hD7Z
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Revert-Cache-adapter-address-for-quick-lookup.patch"

>From 045cbbe3d50119388afc04abbde514e88138c08a Mon Sep 17 00:00:00 2001
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Mon, 8 Nov 2010 02:33:50 +0200
Subject: [PATCH] Revert "Cache adapter address for quick lookup"

This reverts commit a352058752e541539b09e55124d411a534cc14af.
---
 plugins/hciops.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index c7be417..73a7455 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -56,12 +56,10 @@ static guint child_io_id = 0;
 static guint ctl_io_id = 0;
 
 #define SK(index) devs[(index)].sk
-#define BDADDR(index) devs[(index)].bdaddr
 
 static int max_dev = -1;
 static struct dev_info {
 	int sk;
-	bdaddr_t bdaddr;
 } *devs = NULL;
 
 static int ignore_device(struct hci_dev_info *di)
@@ -1312,8 +1310,6 @@ static void device_devup_setup(int index)
 	if (ignore_device(&di))
 		return;
 
-	bacpy(&BDADDR(index), &di.bdaddr);
-
 	/* Set page timeout */
 	if ((main_opts.flags & (1 << HCID_SET_PAGETO))) {
 		write_page_timeout_cp cp;
@@ -1939,7 +1935,9 @@ static int hciops_write_eir_data(int index, uint8_t *data)
 
 static int hciops_read_bdaddr(int index, bdaddr_t *bdaddr)
 {
-	bacpy(bdaddr, &BDADDR(index));
+	if (hci_read_bd_addr(SK(index), bdaddr, HCI_REQ_TIMEOUT) < 0)
+		return -errno;
+
 	return 0;
 }
 
-- 
1.7.1


--7AUc2qLy4jB3hD7Z--
