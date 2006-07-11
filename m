Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 11 Jul 2006 19:18:09 +0200 (CEST)
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0607091841010.20657@ybpnyubfg.ybpnyqbznva>
Message-ID: <Pine.LNX.4.64.0607111912500.7183@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.64.0607091841010.20657@ybpnyubfg.ybpnyqbznva>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Installing / get running bluez-3.1
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

On Sunday, 09. July 2006, 19:15, Andreas Fehr (as AF) wrote:

>AF: Up to now, I used some version 2.x (can't remember what version as 
>AF: I uninstalled it to early). Compiling and installing the files was 
>AF: no problem, but I can't get it running.
>AF: 
>AF: I use:
>AF: - Kernel 2.6.17.4
>AF: - bluez-libs-3.1
>AF: - bluez-utils-3.1
>AF: - dbus-0.62
>AF: 
>AF: dmesg |grep blue -i -a1 shows:
>AF: 
>AF:  PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
>AF:  Bluetooth: Core ver 2.8
>AF:  NET: Registered protocol family 31
>AF:  Bluetooth: HCI device and connection manager initialized
>AF:  Bluetooth: HCI socket layer initialized
>AF:  PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
>AF:  --
>AF:  NET: Registered protocol family 17
>AF:  Bluetooth: L2CAP ver 2.8
>AF:  Bluetooth: L2CAP socket layer initialized
>AF:  Bluetooth: RFCOMM socket layer initialized
>AF:  Bluetooth: RFCOMM TTY layer initialized
>AF:  Bluetooth: RFCOMM ver 1.7
>AF:  Using IPI Shortcut mode
>AF:  --
>AF:  usb 2-1: configuration #1 chosen from 1 choice
>AF:  Bluetooth: HCI USB driver ver 2.9
>AF:  usbcore: registered new driver hci_usb
>AF: 
>AF: I have a Blue Fritz V2.0 USB dongle and lsmod tells me, that the usb 
>AF: module has been loaded:
>AF:  Module                  Size  Used by
>AF:  hci_usb                 9236  0 
>AF: 
>AF: With vmware and it's USB driver, I'm able to use the Bluetooth dongle, 
>AF: so the USB driver, the dongle and my hardware seem to be ok. So much for 
>AF: the good part.
>AF: 
>AF: Now, if I run rfcomm bind 0, the file /dev/rfcomm gets created:
>AF:  crw-rw-rw-  1 root dialout 216, 0 Jul  9 19:02 /dev/rfcomm0
>AF: 
>AF: rfcomm: (1)
>AF:  rfcomm0: 00:18:xx:xx:xx:xx channel 3 clean
>AF: 
>AF: But the old software that I used to use does not work.
>AF: 
>AF: minicom comes up with the message:
>AF:  minicom: cannot open /dev/rfcomm0: No route to host
>AF: 
>AF: hcitool scan prints:
>AF:  Device is not available: No such device
>
> call "hciconfig -a" and make sure "hcidump -X -V" is running in 
> another terminal to catch the setup.

For me, both output look reasonable. Does it help to analyse the 
problem?


hciconfig -a (BD Address changed):

hci0:   Type: USB
        BD Address: 00:05:0F:99:06:04 ACL MTU: 120:20 SCO MTU: 64:0
        UP RUNNING PSCAN 
        RX bytes:407 acl:0 sco:0 events:18 errors:0
        TX bytes:320 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'mycomputer'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2005 LMP Ver: 1.1 (0x1) LMP Subver: 0x1805
        Manufacturer: AVM Berlin (31)

hcidump -X -V:

HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'mycomputer'
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x3e0100
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 1.1 (0x1) HCI Revision: 0x2005
    LMP Version: 1.1 (0x1) LMP Subversion: 0x1805
    Manufacturer: AVM Berlin (31)



> You might also kill hcid and then start it with "hcid -n" to catch the 
> initialization of the adapter via hcidump.

< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 2
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
    bdaddr 00:00:00:00:00:00 all 1
> HCI Event: Command Complete (0x0e) plen 8
    Read Stored Link Key (0x03|0x000d) ncmd 1
    status 0x00 max 8 num 0
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 1.1 (0x1) HCI Revision: 0x2005
    LMP Version: 1.1 (0x1) LMP Subversion: 0x1805
    Manufacturer: AVM Berlin (31)
< HCI Command: Write Local Name (0x03|0x0013) plen 248
    name 'mycomputer'
> HCI Event: Command Complete (0x0e) plen 4
    Write Local Name (0x03|0x0013) ncmd 1
    status 0x00
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
    class 0x3e0100
> HCI Event: Command Complete (0x0e) plen 4
    Write Class of Device (0x03|0x0024) ncmd 1
    status 0x00
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
    mode 0
> HCI Event: Command Complete (0x0e) plen 4
    Write Inquiry Mode (0x03|0x0045) ncmd 1
    status 0x00
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Scan Enable (0x03|0x0019) ncmd 1
    status 0x00 enable 2
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Scan Enable (0x03|0x0019) ncmd 1
    status 0x00 enable 2
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'mycomputer'



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
