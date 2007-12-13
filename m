Return-Path: <cyrus@holtmann.org>
Message-ID: <103e3fa20712130429l1d80c136o4420e6f513c83228@mail.gmail.com>
Date: Thu, 13 Dec 2007 13:29:21 +0100
From: "Torbjorn Kristoffersen" <torbjoern@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Strange problem,
	hcitool scan returns nothing even though it clearly should
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have a Linux computer using a Linksys USBBT100 (Broadcom chipset). I
also have a bluetooth-enabled Samsung cellphone.

I've tested this USB adapter in advance on a Mac and also on a Windows
machine, so I know it works fine.  It usually detects any cellphone in
the vicinity, but when I tried it on my OpenSUSE 10.3 (2.6.22 kernel)
machine running Bluez 3.18, the behavior I see is very strange...

Whenever I open up the clamshell on my phone, Bluez is able to see the
phone. But whenever it's closed, then "hcitool scan" sees absolutely
nothing.

It's definitely not supposed to be this way, as I've tested the same
USB adapter on Mac and Windows, and they both see the phone whether
the clamshell is open or not. As do all other phones.

Here's a log from my system:

b1:/lib/firmware # dmesg | grep -i bluetooth
usb 2-1: Product: USB Bluetooth Device
Bluetooth: Core ver 2.11
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: Broadcom Blutonium firmware driver ver 1.1
b1:/lib/firmware # ls -l
total 588
-rwxr-xr-x 1 root root 114688 Sep 28 02:01 BCM2033-2.13-FW.bin
-rwxr-xr-x 1 root root 114688 Sep 28 02:01 BCM2033-2.14-FW.bin
-rwxr-xr-x 1 root root 114688 Sep 28 02:01 BCM2033-2.15-FW.bin
-rwxr-xr-x 1 root root 114688 Sep 28 02:01 BCM2033-2.16-FW.bin
-rwxr-xr-x 1 root root 114688 Sep 28 02:01 BCM2033-FW.bin
-rwxr-xr-x 1 root root   3245 Sep 28 02:01 BCM2033-MD.hex
-rwxr-xr-x 1 root root   2142 Sep 28 02:01 bcm_hex2bin
b1:/lib/firmware # hciconfig -a
hci0:   Type: USB
        BD Address: 00:18:F8:89:96:68 ACL MTU: 377:10 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2188 acl:0 sco:0 events:97 errors:0
        TX bytes:423 acl:0 sco:0 commands:37 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (none) (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)

b1:/lib/firmware # hcitool scan
Scanning ...
b1:/lib/firmware #

         [[ Now I flip open my cellphone ]]

b1:/lib/firmware # hcitool scan
Scanning ...
        12:47:90:0F:8A:BC       Torby
b1:/lib/firmware # l2ping 12:47:90:0f:8a:bc
Ping: 12:47:90:0f:8a:bc from 00:18:F8:89:96:68 (data size 44) ...
4 bytes from 12:47:90:0f:8a:bc id 0 time 73.52ms
4 bytes from 12:47:90:0f:8a:bc id 1 time 9.75ms
4 bytes from 12:47:90:0f:8a:bc id 2 time 10.46ms
3 sent, 3 received, 0% loss

        [[ Now I close my cellphone ]]

b1:/lib/firmware # l2ping 12:47:90:0f:8a:bc
Ping: 12:47:90:0f:8a:bc from 00:18:F8:89:96:68 (data size 44) ...
4 bytes from 12:47:90:0f:8a:bc id 0 time 50.93ms
4 bytes from 12:47:90:0f:8a:bc id 1 time 10.62ms
4 bytes from 12:47:90:0f:8a:bc id 2 time 11.44ms
4 bytes from 12:47:90:0f:8a:bc id 3 time 10.17ms
4 bytes from 12:47:90:0f:8a:bc id 4 time 10.96ms
5 sent, 5 received, 0% loss

b1:/lib/firmware # hcitool scan
Scanning ...
b1:/lib/firmware #


Anyone else encountered a similar problem? Any ideas would be
appreciated. I am at loss right now.


Kind regards,
Torbjorn Kristoffersen

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
