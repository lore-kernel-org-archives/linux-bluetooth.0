Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-users] sniff mode
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA93870966477E@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
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
Date: Fri, 11 Nov 2005 11:40:23 -0800

I answered one of my questions myself... looks like both devices should
support sniff mode just fine...

	Trevor

stargate93:root/ # hciconfig hci0 features
hci0:   Type: USB
        BD Address: AE:2D:00:23:01:96 ACL MTU: 120:20 SCO MTU: 64:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>=20
                <timing accuracy> <role switch> <hold mode> <sniff mode>

                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>=20
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power
control>=20
                <enhanced iscan> <interlaced iscan> <interlaced pscan>=20
                <AFH cap. slave> <AFH class. slave> <AFH cap. master>=20
                <AFH class. master>=20

stargate93:root/ # hcitool info 00:04:3E:01:83:C2
Requesting information ...
        BD Address:  00:04:3E:01:83:C2
        Device Name: ScoobyDoo (0)
        LMP Version: 1.1 (0x1) LMP Subversion: 0x0
        Manufacturer: Zeevo, Inc. (18)
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>=20
                <timing accuracy> <role switch> <hold mode> <sniff mode>

                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>=20
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power
control>=20


-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Pering,
Trevor
Sent: Friday, November 11, 2005 11:34 AM
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] sniff mode

Thanks, Marcel. See the output below.  It says "Unsupported Feature of
Parameter value" -- so, I suppose this means either that the feature
isn't supported by my particular BT device, or that I'm getting
something wrong :-).  This is a fairly new SilliconWave dongle, so I
would assume it would work...   (I've also tried with other devices with
similar results).

How can I decode the features bits given by "hciconfig -a"?

The other question would be if I'm getting the parameters right, but...
I'm not quite sure how to figure that one out. I've tried a variety of
parameters, but they all end up the same.

Cheers,
	Trevor


stargate93:root/ # ./hcidump -X -V &
[1] 21524
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
stargate93:root/ # ./sniff=20
< HCI Command: ogf 0x02, ocf 0x0003, plen 10
  00 07 02 02 01 01 01 02 03 04=20
< HCI Command: Sniff Mode (0x02|0x0003) plen 10
  0000: 00 07 02 02 01 01 01 02  03 04                    ..........
> HCI Event: Command Status (0x0f) plen 4
    Sniff Mode (0x02|0x0003) status 0x11 ncmd 1
    Error: Unsupported Feature or Parameter Value
> HCI Event: 0x0f plen 4
  11 01 03 08=20

-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, November 11, 2005 11:08 AM
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sniff mode

Hi Trevor,

> I'm trying to get sniff mode working between two devices.  My
> understanding is that this is not directly supported by bluez
> (http://mhonarc.axis.se/bluetooth-dev/msg03437.html), so I'm trying to
> send the relevant HCI commands directly -- but I can't seem to get it
to
> work. A quick trace of all the information is below...  basically, it
> seems to send the command ok, but it just comes back with an error
> (which I think I have translated to just "HCI parameter error").  Any
> thoughts on what might be going wrong? =20

run "hcidump -X -V" in the back for the decoding.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server.
Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server.
Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
