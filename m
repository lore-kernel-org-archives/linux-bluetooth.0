Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 02 Feb 2007 10:49:06 -0500
From: Walt Shekrota <wshekrota@optonline.net>
To: bluez-users@lists.sourceforge.net, wshekrota@optonline.net
Message-id: <200702021049.06882.wshekrota@optonline.net>
MIME-version: 1.0
Subject: [Bluez-users] Ubuntu 6.06 and bluez setup problem?
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

Many things appear to work from install with the 6.06 Ubuntu's. I think bluez 
is probably no exception. I have been having some problem that is subtle. It 
relates to the utility starting up in client space and SDP server 
responding "invalid exchange".
Please see the pertinent listings below I hope I have included what you need.
Any help or direction greatly appreciated.
I have two dongles the one used here is Cellink BTA-3120 .... also have the 
trendnet TBW-102UB.

-Walt

====

Kubuntu 6.06

First I insert the dongle and view the dmesg as below.
Then I setup the headset leaving it waiting to pair.
On my kde desktop I get the message "not paired" in a popup.
Could it be the setup of the  file hcid.conf? (also below)

hcitool scan
Scanning ...
        00:03:89:F7:A9:78       320Plantronics

hciconfig -a revision
hci0:   Type: USB
        BD Address: 00:0A:94:12:E1:D3 ACL MTU: 120:20 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:159 acl:0 sco:0 events:19 errors:0
        TX bytes:73 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: ''
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)

dmesg
[17179629.580000] Bluetooth: Core ver 2.8
[17179629.580000] NET: Registered protocol family 31
[17179629.580000] Bluetooth: HCI device and connection manager initialized
[17179629.580000] Bluetooth: HCI socket layer initialized
[17179629.612000] Bluetooth: L2CAP ver 2.8
[17179629.612000] Bluetooth: L2CAP socket layer initialized
[17179629.620000] Bluetooth: RFCOMM socket layer initialized
[17179629.620000] Bluetooth: RFCOMM TTY layer initialized
[17179629.620000] Bluetooth: RFCOMM ver 1.7
[17179739.600000] usb 3-1: new full speed USB device using uhci_hcd and 
address 2
[17179741.132000] Bluetooth: HCI USB driver ver 2.9
[17179741.136000] usbcore: registered new driver hci_usb


uname -a
Linux kubuntu 2.6.15-27-686 #1 SMP PREEMPT Sat Sep 16 02:13:27 UTC 2006 i686 
GNU/Linux

btsco -v 00:03:89:F7:A9:78
btsco v0.42
Device is 1:0
Error: Failed to connect to SDP server: Invalid exchange
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Invalid exchange

cat /proc/asound/cards
0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 with ALC202 at 0xe0000c00, irq 217
1 [Headset        ]: Bluetooth SCO - BT Headset
                     BT Headset 1


/etc/bluetooth/hcid.conf
#
# HCI daemon configuration file.
#

# HCId options
options {
	# Automatically initialize new devices
	autoinit yes;

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	#
	security user; 

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# PIN helper
	pin_helper /usr/bluez-pin

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "%h-%d";

	# Local device class
	class 0x3e0100;
# class 0x100;
	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	lp rswitch,hold,sniff,park;

	# Authentication and Encryption (Security Mode 3)
auth disable;
encrypt disable;
}

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
