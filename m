Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <010201c62197$be32dae0$14141bac@mgpi.de>
From: "Bernhard Held" <berny156@gmx.de>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] PAN with ISSC USB-dongle and MTU
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
Date: Wed, 25 Jan 2006 11:11:30 +0100

Hi all,

I recently bought 2 mini class-1 bluetooth dongles, and they turned out to
use the ISSC chip.

It was no problem to establish connections with a GPS mouse (rfcomm) and a
Palm T5 (ppp).

But I had big problems with PAN between a desktop and my venerable compaq
armada notebook. I could establish a connection, ping worked. But each time
I tried to transfer some real payload the connection died, and with it some
parts of the bluetooth stack. To restablish the connection most of the time
it's necessary to restart all bluetooth daemons, sometimes even the dongles
must be re-plugged.

I started to play with the ping size. 'ping -s 900' works, 'ping -s 1000'
kills the PAN connection. There was hope! Then I played with MTU (on both
sides): 'ifconfig bnep0 mtu 1000' solves all my problems (default is
1500)!!! With this setting I've a rock solid 75 kByte/s transfer rate over
ftp. A mtu of 1017 still works, 1018 definitely kills the connection. Then
the syslog is flooded with:
> hci_acldata_packet: hci0 ACL packet for unknown connection handle 0
and some stray
> hci_usb_rx_complete: hci0 corrupted packet: type 2 count 423

Small oversteps of MTU 1017 are recoverable, but a MTU 1500 kills my
daemons.

HTH! I'm ready to supply any additional information you need!

Thanks for the great bluez-software!

Bernhard


My config:
SuSE Linux 9.3 with all updates
kernel 2.6.15.1 with 3 tiny patches (not bluetooth related)

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:67:18:16:BB ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:4845896 acl:47638 sco:0 events:74919 errors:1
        TX bytes:28784762 acl:74470 sco:0 commands:220 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ viktoria (0)'
        Class: 0x330104
        Service Classes: Positioning, Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver:
0x1f4
        Manufacturer: Integrated System Solution Corp. (57)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
