Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <8616e2cf0501302048435f028b@mail.gmail.com>
From: Roderick Taylor <roderick.d.taylor@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Trouble with USB hub.
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 31 Jan 2005 12:48:16 +0800

Hi,

I am having trouble with my CSR based bluetooth dongle and my USB hub.
I am using FC2, kernel version 2.6.10-1.9_FC2

/var/log/messages 
says

Jan 31 11:32:22 localhost kernel: usb 1-2.1: new full speed USB device
using ehci_hcd and address 7
Jan 31 11:32:23 localhost hcid[2895]: HCI dev 0 registered
Jan 31 11:32:23 localhost hcid[5297]: Can't init device hci0.
Input/output error(5)
Jan 31 11:32:23 localhost kernel: hci_usb_intr_rx_submit: hci0 intr rx
submit failed urb cff4db94 err -28

hciconfig hci0 up
says the same thing

Can't init device hci0. Input/output error(5)

The dongle works fine if I don't use the hub.  

In this case /var/log/messages says

Jan 31 11:39:11 localhost kernel: usb 3-3: new full speed USB device
using ohci_hcd and address 2
Jan 31 11:39:12 localhost hcid[2895]: HCI dev 0 registered
Jan 31 11:39:13 localhost hcid[2895]: HCI dev 0 up
Jan 31 11:39:13 localhost hcid[2895]: Starting security manager 0

hci0:   Type: USB
        BD Address: 00:02:72:80:5D:27 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:119 acl:0 sco:0 events:15 errors:0
        TX bytes:302 acl:0 sco:0 commands:14 errors:0

Rod


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
