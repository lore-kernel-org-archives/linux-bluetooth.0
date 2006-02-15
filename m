Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hciconfig doesn't come up
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <d6db2b820602131319u1658f2fn40823df3c623c500@mail.gmail.com>
References: <d6db2b820602131319u1658f2fn40823df3c623c500@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139993269.26072.25.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 15 Feb 2006 09:47:49 +0100

Hi Michael,

> We would like to setup BT communication on embedded MIPS-processor
> Broadcom card with Linux 2.4.20 (patched by patch no.18 of M.Holtman).
> Kernel contained USB support, HID support and BlueTooth support (on
> all layers). 
> On this card we're using USB-PCI host-controller of Philips
> (ISP1562ES1).
> We are using Bluez-2.24 library and utils. We also use the library for
> userspace-kernelspace USB translation (libusb-0.1.so.4.4.3).

the 2.4 kernel series are no longer supported and actually the USB part
of these kernels might be buggy, too.

> We are using CSR based BT dongle with the following description:
> >T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0>
> >D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> >P:  Vendor=0a12 ProdID=0001 Rev= 11.20
> (as we saw in the supported products list, it is supported.)

It is fully supported. What build id is this? I know that the Rev equals
the build id, but I always forget how to convert it.

> ># ps -aux
> >  PID  Uid     Stat Command 
> >    1 0         S    init noinitrd
> >    2 0         S    [keventd]
> >    3 0         S    [ksoftirqd_CPU0]
> >    4 0         S    [kswapd]
> >    5 0         S    [bdflush]
> >    6 0         S    [kupdated] 
> >    7 0         S    [mtdblockd]
> >   15 0         S    /usr/sbin/dnsmasq
> >   24 0         S    /usr/sbin/diag
> >   25 0         S    /bin/sh
> >   35 0         S    [khubd]
> >   63 0         S    [krfcommd] 
> >   77 0         S    hcid: processing events
> >   80 0         S    sdpd
> >  104 0         S    hcid: processing events
> >  108 0         S    hcid: hci0 init
> >  111 0         S    /usr/sbin/hidd --server 
> >  124 0         R    ps -aux

Make sure only one hcid is running at a time.

> The problem is that hciconfig doesn't come up:
> ># hciconfig
> >hci0:   Type: USB
> >        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
> >        DOWN
> >        RX bytes:20 acl:0 sco:0 events:2 errors:0 
> >        TX bytes:9 acl:0 sco:0 commands:3 errors:0
> 
> When we're trying to wake it up, it failed on timeout:
> ># hciconfig hci0 up
> >Can't init device hci0: Connection timed out (145)
> We received the same timeout reply for version, revision and commands
> requests. 
> We received the following reply for features request (# hciconfig hci0
> features)
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 192:8 SCO MTU: 64:8
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff
> mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2
> packets> 
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
> scheme>
>                 <power control> <transparent SCO>
> 
> When we're trying to do the same actions on PC with Linux 2.6.12
> (using the same USB-PCI card and BT dongle), the only difference that
> after "hciconfig up" it returns the BD address and UP state. Following
> that all hcitool, sdptool, l2ping etc. services worked ok and we could
> establish BT communication.

Why don't try to use a decent 2.6 kernel for embedded board? This will
make all things a lot easier.

> One additional issue. We see in the product list that our dongle is in
> HCI mode, so we don't have to use hid2hci utility, but for some
> strange reason it doesn't work in any direction (on both Brodacom and
> PC). 
> We found that in the list, declared in the file hid2hci.c , this pair
> "vendor-productID" is defined as HID... It's strange.

You need to have a dongle that actually supports HID proxy. Otherwise
this tool doesn't do anything.

> We see in sources that the socket to AF_BLUETOOTH with BT_PROTOHCI is
> opened successfully and even some of ioctl's succeeded, but HCIDEVUP
> did not...
> 
> May someone hint us, what we did wrong. 
> Should we change something in the "default" hcid.conf (class device or
> something else)?
> Or should we make something additional configurations?
> We don't find nothing extra in the manuals and HOWTOs... 
> How could we fix this HCI connection and move forward in establishing
> BT communication on the described setup?

Move to a 2.6 kernel, because I think this is a bug inside the USB
subsystem. However if you don't need SCO support, you might wanna
disable the ISOC transfers (SCO support) of the hci_usb driver.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
