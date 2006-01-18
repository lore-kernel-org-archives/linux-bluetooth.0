Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <51698.199.118.135.220.1137612095.squirrel@www.blisster.com>
From: "Robert Bliss" <rbliss@blisster.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Logitech Bluetooth Travel Mouse on Sony VAIO t370
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
Date: Wed, 18 Jan 2006 14:21:35 -0500 (EST)

Hello:

  I am trying to get a Logitech Bluetooth Travel Mouse to work on a Sony
VAIO T370 laptop.

  This laptop has built in bluetooth.

  I am running Fedora Core 4 which has Bluez  bluez-libs-2.15-1
bluez-hcidump-1.18-1
bluez-utils-2.15-76243cl

  hciconfig -a yields

hci0:   Type: USB
        BD Address: 00:01:4A:31:4E:1F ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:3531 acl:0 sco:0 events:250 errors:0
        TX bytes:1035 acl:0 sco:0 commands:89 errors:0
        Features: 0xff 0xff 0x8b 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'speedy'
        Class: 0x120104
        Service Classes: Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.2 (0x2) HCI Rev: 0x490 LMP Ver: 1.2 (0x2) LMP Subver:
0x490
        Manufacturer: Cambridge Silicon Radio (10)

If I move the mouse hcitool con yields:

 Connections:
        > ACL 00:07:61:49:28:71 handle 0 state 5 lm SLAVE

And hcitool inf 00:07:61:49:28:71 yields:
Requesting information ...
        BD Address:  00:07:61:49:28:71
        Device Name: Bluetooth Travel Mouse

However,  hidd --connect 00:07:61:49:28:71 yields:
Can't create HID control channel: Connection timed out

Has anyone gotten this device to work on this type of bluetooth controller?

Is there a better howto for connecting mice that I should be using The one
I have been following is from www.buech.ch/comp/mx900/mx900.html but
he has a different brand laptop and a different logitech mouse.

I guess the good news is that the laptop at least seems to see the mouse so
it would appear that I am doing something dumb.

  Thanks Bob.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
