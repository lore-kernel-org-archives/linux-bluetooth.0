Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050902020721.51217.qmail@web25004.mail.ukl.yahoo.com>
From: Clifford Graham <clifforg@yahoo.co.uk>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] VMWare 5.0 and those timeout messages
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
Date: Thu, 1 Sep 2005 19:07:20 -0700 (PDT)

Hello,

I have been having a lot of trouble getting a Broadcom
device working properly under Fedora 4 (Kernel 2.6.11)
in a VMWare 5.0 session.  I was wondering if anyone
had managed to get this working?  I found an article
in the archives from the beginning of the year with a
similar problem (see
http://sourceforge.net/mailarchive/message.php?msg_id=10640453).

I get the following messages in my /var/log/messages
file.

**************************************************
Sep  1 21:42:22 localhost hcid[2714]: Bluetooth HCI
daemon
Sep  1 21:42:22 localhost kernel: Bluetooth: Core ver
2.7
Sep  1 21:42:22 localhost kernel: NET: Registered
protocol family 31
Sep  1 21:42:22 localhost kernel: Bluetooth: HCI
device and connection manager initialized
Sep  1 21:42:22 localhost kernel: Bluetooth: HCI
socket layer initialized
Sep  1 21:42:39 localhost kernel: usb 1-1: new full
speed USB device using uhci_hcd and address 2
Sep  1 21:42:42 localhost kernel: Bluetooth: Broadcom
Blutonium firmware driver ver 1.0
Sep  1 21:42:42 localhost kernel: usbcore: registered
new driver bcm203x
Sep  1 21:42:42 localhost kernel: Bluetooth: HCI USB
driver ver 2.8
Sep  1 21:42:42 localhost kernel: usbcore: registered
new driver hci_usb
Sep  1 21:42:48 localhost kernel: usb 1-1: USB
disconnect, address 2
Sep  1 21:42:50 localhost kernel: usb 1-1: new full
speed USB device using uhci_hcd and address 3
Sep  1 21:42:51 localhost hcid[2714]: HCI dev 0
registered
Sep  1 21:43:01 localhost hcid[2926]: Can't init
device hci0: Connection timed out (110)
**************************************************

hciconfig -a shows

**************************************************
[root@localhost ~]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO
MTU: 0:0
        DOWN 
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:3 acl:0 sco:0 commands:1 errors:0
**************************************************

and lsusb shows

**************************************************
[root@localhost ~]# lsusb
Bus 001 Device 003: ID 0a5c:2001 Broadcom Corp. 
Bus 001 Device 001: ID 0000:0000  
**************************************************

I can provide /proc/bus/usb/devices if need be.

I've tried lots of different versions of bluez, and
the old bluefw....nothing seems to work!

Help!

Thank you kindly in advance

Graham 


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
