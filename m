Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do inquiry with RSSI in bluetooth 1.2
	devices?
From: Marcel Holtmann <marcel@holtmann.org>
To: albert@csail.mit.edu
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec04101914447e122c22@mail.gmail.com>
References: <ef9938ec041012125930f0b8e3@mail.gmail.com>
	 <1097658003.4643.17.camel@notepaq>
	 <ef9938ec04101511326a6342c3@mail.gmail.com>
	 <1097928625.4911.30.camel@pegasus>
	 <ef9938ec04101914447e122c22@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1098222911.23046.5.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 19 Oct 2004 23:55:11 +0200

Hi Albert,

> > what is actually attached on your USB bus (check with lsusb), because
> > this device is a CSR dongle and the one from your other email is not.
> 
> Sorry about that.  There were two bluetooth adapters attached.  I've
> removed the csr dongle.  Here's the relevant output of lsusb -v

if I ask for lsusb then I don't expect lsusb -v, because otherwise I had
asked for it ;)

> Also, I tried a 2.6.8 kernel compiled with no SCO support in the
> hci_usb driver.  The results I got were slightly different.  Again,
> here is the output of hciconfig features and hciconfig -a
> 
> $ uname -a
> Linux ocha 2.6.8-ash-20041019-1 #1 Tue Oct 19 12:14:55 EDT 2004 i686 GNU/Linux
> $ hciconfig -a hci0
> hci0:   Type: USB
>         BD Address: 00:0B:0D:30:0A:99 ACL MTU: 120:20  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1641 acl:0 sco:0 events:85 errors:0
>         TX bytes:445 acl:0 sco:0 commands:46 errors:0
>         Features: 0xff 0xff 0x05 0x78 0x18 0x10 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'ocha-0'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
>         Manufacturer: Silicon Wave (11)
> $ hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:0B:0D:30:0A:99 ACL MTU: 120:20  SCO MTU: 64:0
>         Features: 0xff 0xff 0x05 0x78 0x18 0x10 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
>                 <enhanced iscan> <interlaced iscan> <interlaced pscan>
>                 <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
>                 <AFH class. master>
> 
> If I try to issue hci_read_inquiry_mode (ocf 0x44) and
> hci_write_inquiry_mode (ocf 0x45) commands, here's what hcidump -x
> shows
> 
> $ hcidump -x
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Unknown (0x01|0x0044) plen 0
> > HCI Event: Command Status (0x0f) plen 4
>   01 01 44 04
> < HCI Command: Unknown (0x01|0x0045) plen 1
>   01
> > HCI Event: Command Status (0x0f) plen 4
>   01 01 45 04
> 
> So it appears that even though the device claims to support
> read_inquiry_mode and write_inquiry_mode, it does not recognize the
> commands.  I've double checked the bt 1.2 specs and { 0x44, 0x44 } are
> the correct OCF values.  I'll check back with the folks at Anycom and
> see if they can give me any useful information.

You should re-read the HCI part of the Bluetooth specification, because
the OGF and OCF values are packed in a specific format. If the latest
version of hcidump shows unknown then you should think about an error on
your side, because I already added full Bluetooth 1.2 support.

Try "hciconfig hci0 inqmode [mode]" to read to write the inquiry mode.

> In the meantime, do you know of any commercially available USB
> Bluetooth 1.2 compliant adapters we could obtain?

If you only care about the inquiry with RSSI support then you can buy
the AVM BlueFRITZ! USB v2.0. Even if this dongle claims not to support
it, it does. Anycom also has a Bluetooth 1.2 dongle and of course you
can update the D-Link DBT-120 Rev. B3 with the Apple firmware.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
