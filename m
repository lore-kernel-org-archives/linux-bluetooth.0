Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 28 Jul 2006 10:21:43 -0400
Message-ID: <E65CD2CAB74C80498703D6EF7624BB4C023974AA@zmaex.zma.zoran.com>
From: "Lan Zhang" <Lan.Zhang@Zoran.com>
To: <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Hci Reset Problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi, Marcel: 

Here is the hciconfig result. 

hci0:	Type: USB
	BD Address: 00:0F:3D:49:05:13 ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:179 acl:0 sco:0 events:26 errors:0
	TX bytes:846 acl:0 sco:0 commands:25 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x3e0100
	Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
	Manufacturer: Cambridge Silicon Radio (10)


Andy, below is the syslog, I believe the USB disconnect happens after
obexopen. Thanks. 

Jul 27 11:43:14 wsp171944wss kernel: Bluetooth: Core ver 2.6
Jul 27 11:43:14 wsp171944wss kernel: NET: Registered protocol family 31
Jul 27 11:43:14 wsp171944wss kernel: Bluetooth: HCI device and
connection manager initialized
Jul 27 11:43:14 wsp171944wss kernel: Bluetooth: HCI socket layer
initialized
Jul 27 11:43:14 wsp171944wss kernel: Bluetooth: HCI USB driver ver 2.7
Jul 27 11:43:14 wsp171944wss kernel: usbcore: registered new driver
hci_usb
Jul 27 11:43:21 wsp171944wss hcid[5812]: Bluetooth HCI daemon
Jul 27 11:43:21 wsp171944wss bluetooth: hcid startup succeeded
Jul 27 11:43:21 wsp171944wss bluetooth: sdpd startup succeeded
Jul 27 11:43:21 wsp171944wss kernel: Bluetooth: L2CAP ver 2.4
Jul 27 11:43:21 wsp171944wss kernel: Bluetooth: L2CAP socket layer
initialized
Jul 27 11:43:21 wsp171944wss sdpd[5816]: Bluetooth SDP daemon 
Jul 27 11:43:21 wsp171944wss hcid[5812]: HCI dev 0 up
Jul 27 11:43:21 wsp171944wss hcid[5812]: Starting security manager 0
Jul 27 11:43:22 wsp171944wss kernel: Bluetooth: RFCOMM ver 1.3
Jul 27 11:43:22 wsp171944wss kernel: Bluetooth: RFCOMM socket layer
initialized
Jul 27 11:43:22 wsp171944wss kernel: Bluetooth: RFCOMM TTY layer
initialized
Jul 27 11:43:46 wsp171944wss su(pam_unix)[5853]: session opened for user
root by bryant(uid=500)
Jul 27 11:45:58 wsp171944wss su(pam_unix)[3235]: session closed for user
root
Jul 27 11:47:03 wsp171944wss kernel: usb 1-1: USB disconnect, address 2
Jul 27 11:47:06 wsp171944wss hcid[5812]: HCI dev 0 down
Jul 27 11:47:06 wsp171944wss hcid[5812]: Stoping security manager 0
Jul 27 11:47:06 wsp171944wss hcid[5812]: HCI dev 0 unregistered
Jul 27 11:47:07 wsp171944wss kernel: usb 1-1: new full speed USB device
using address 3
Jul 27 11:47:07 wsp171944wss hcid[5812]: HCI dev 0 registered
Jul 27 11:47:08 wsp171944wss hcid[5812]: HCI dev 0 up
Jul 27 11:47:08 wsp171944wss hcid[5812]: Starting security manager 0
Jul 27 12:01:01 wsp171944wss crond(pam_unix)[6148]: session opened for
user root by (uid=0)
Jul 27 12:01:01 wsp171944wss crond(pam_unix)[6148]: session closed for
user root
Jul 27 13:01:01 wsp171944wss crond(pam_unix)[6152]: session opened for
user root by (uid=0)
Jul 27 13:01:01 wsp171944wss crond(pam_unix)[6152]: session closed for
user root
Jul 27 13:27:04 wsp171944wss kernel: usb 1-1: USB disconnect, address 3
Jul 27 13:27:06 wsp171944wss hcid[5812]: HCI dev 0 down
Jul 27 13:27:06 wsp171944wss hcid[5812]: Stoping security manager 0
Jul 27 13:27:06 wsp171944wss hcid[5812]: HCI dev 0 unregistered
Jul 27 13:27:07 wsp171944wss kernel: usb 1-1: new full speed USB device
using address 4
Jul 27 13:27:07 wsp171944wss hcid[5812]: HCI dev 0 registered
Jul 27 13:27:08 wsp171944wss hcid[5812]: HCI dev 0 up
Jul 27 13:27:08 wsp171944wss hcid[5812]: Starting security manager 0
Jul 27 14:01:01 wsp171944wss crond(pam_unix)[7865]: session opened for
user root by (uid=0)
Jul 27 14:01:01 wsp171944wss crond(pam_unix)[7865]: session closed for
user root
Jul 27 14:42:30 wsp171944wss kernel: hci_acldata_packet: hci0 ACL packet
for unknown connection handle 2
Jul 27 14:42:30 wsp171944wss kernel: hci_acldata_packet: hci0 ACL packet
for unknown connection handle 3
Jul 27 14:42:30 wsp171944wss kernel: hci_acldata_packet: hci0 ACL packet
for unknown connection handle 0
Jul 27 14:42:30 wsp171944wss kernel: usb 1-1: USB disconnect, address 4
Jul 27 14:42:34 wsp171944wss hcid[5812]: HCI dev 0 down
Jul 27 14:42:34 wsp171944wss hcid[5812]: Stoping security manager 0
Jul 27 14:42:34 wsp171944wss hcid[5812]: HCI dev 0 unregistered
Jul 27 14:42:35 wsp171944wss kernel: usb 1-1: new full speed USB device
using address 5
Jul 27 14:42:35 wsp171944wss hcid[5812]: HCI dev 0 registered
Jul 27 14:42:37 wsp171944wss hcid[5812]: HCI dev 0 up
Jul 27 14:42:37 wsp171944wss hcid[5812]: Starting security manager 0
Jul 27 14:42:54 wsp171944wss hcid[14483]: Bluetooth HCI daemon
Jul 27 14:42:54 wsp171944wss hcid[14483]: Starting security manager 0
Jul 27 14:42:54 wsp171944wss bluetooth: hcid startup succeeded
Jul 27 14:42:54 wsp171944wss sdpd[14489]: init_server: binding L2CAP
socket: Address already in use 
Jul 27 14:42:54 wsp171944wss sdpd[14489]: main: Server initialization
failed 
Jul 27 14:42:54 wsp171944wss bluetooth: sdpd startup succeeded
Jul 27 14:45:22 wsp171944wss kernel: usb 1-1: USB disconnect, address 5
Jul 27 14:45:25 wsp171944wss hcid[14483]: HCI dev 0 down
Jul 27 14:45:25 wsp171944wss hcid[14483]: Stoping security manager 0
Jul 27 14:45:25 wsp171944wss hcid[5812]: HCI dev 0 down
Jul 27 14:45:25 wsp171944wss hcid[5812]: Stoping security manager 0
Jul 27 14:45:25 wsp171944wss hcid[14483]: HCI dev 0 unregistered
Jul 27 14:45:25 wsp171944wss hcid[5812]: HCI dev 0 unregistered
Jul 27 14:45:26 wsp171944wss kernel: usb 1-1: new full speed USB device
using address 6
Jul 27 14:45:26 wsp171944wss hcid[14483]: HCI dev 0 registered
Jul 27 14:45:26 wsp171944wss hcid[5812]: HCI dev 0 registered
Jul 27 14:45:27 wsp171944wss hcid[14483]: HCI dev 0 up
Jul 27 14:45:27 wsp171944wss hcid[5812]: HCI dev 0 up
Jul 27 14:45:27 wsp171944wss hcid[14483]: Starting security manager 0
Jul 27 14:45:27 wsp171944wss hcid[5812]: Starting security manager 0
Jul 27 14:50:10 wsp171944wss hcid[14776]: Bluetooth HCI daemon
Jul 27 14:50:10 wsp171944wss hcid[14776]: Starting security manager 0
Jul 27 14:50:10 wsp171944wss bluetooth: hcid startup succeeded
Jul 27 14:50:10 wsp171944wss sdpd[14782]: init_server: binding L2CAP
socket: Address already in use 
Jul 27 14:50:10 wsp171944wss sdpd[14782]: main: Server initialization
failed 
Jul 27 14:50:10 wsp171944wss bluetooth: sdpd startup succeeded
Jul 27 14:52:30 wsp171944wss kernel: usb 1-1: USB disconnect, address 6
Jul 27 14:52:33 wsp171944wss hcid[14776]: HCI dev 0 down
Jul 27 14:52:33 wsp171944wss hcid[14776]: Stoping security manager 0
Jul 27 14:52:33 wsp171944wss hcid[14483]: HCI dev 0 down
Jul 27 14:52:33 wsp171944wss hcid[14483]: Stoping security manager 0
Jul 27 14:52:33 wsp171944wss hcid[5812]: HCI dev 0 down
Jul 27 14:52:33 wsp171944wss hcid[5812]: Stoping security manager 0
Jul 27 14:52:33 wsp171944wss hcid[14776]: HCI dev 0 unregistered
Jul 27 14:52:33 wsp171944wss hcid[14483]: HCI dev 0 unregistered
Jul 27 14:52:33 wsp171944wss hcid[5812]: HCI dev 0 unregistered
Jul 27 14:52:34 wsp171944wss kernel: usb 1-1: new full speed USB device
using address 7
Jul 27 14:52:34 wsp171944wss hcid[14776]: HCI dev 0 registered
Jul 27 14:52:34 wsp171944wss hcid[14483]: HCI dev 0 registered
Jul 27 14:52:35 wsp171944wss hcid[5812]: HCI dev 0 registered
Jul 27 14:52:35 wsp171944wss hcid[14776]: HCI dev 0 up
Jul 27 14:52:35 wsp171944wss hcid[14483]: HCI dev 0 up
Jul 27 14:52:35 wsp171944wss hcid[5812]: HCI dev 0 up
Jul 27 14:52:35 wsp171944wss hcid[14776]: Starting security manager 0
Jul 27 14:52:35 wsp171944wss hcid[14483]: Starting security manager 0
Jul 27 14:52:35 wsp171944wss hcid[5812]: Starting security manager 0
Jul 27 15:01:01 wsp171944wss crond(pam_unix)[15071]: session opened for
user root by (uid=0)
Jul 27 15:01:01 wsp171944wss crond(pam_unix)[15071]: session closed for
user root


Lan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
