Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Hedin <hedin@hiervard.ru>
To: bluez-users@lists.sf.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200405150903.23338.hedin@hiervard.ru>
Subject: [Bluez-users] BT3030
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 15 May 2004 09:03:23 +0700

Here is my `dmesg` log after I load my modules after connecting the dongle:

usb 1-1: new full speed USB device using address 3
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: HCI USB driver ver 2.5
usbcore: registered new driver hci_usb
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
bcm203x_probe: Mini driver request failed
bcm203x: probe of 1-1:1.0 failed with error -5
usbcore: registered new driver bcm203x

It fails with and doesn't appear in `hcitool dev` list. What's wrong with it? 
Where to look


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
