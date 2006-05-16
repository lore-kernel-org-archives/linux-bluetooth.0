Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Inquiry with RSSI on Broadcom BCM2035 - not
	supported ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3e890f530605131204w2980dee2v586468fed3fe16ed@mail.gmail.com>
References: <3e890f530605131204w2980dee2v586468fed3fe16ed@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1147789208.24761.73.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 16 May 2006 16:20:08 +0200

Hi Javier,

> I have make this question on bluez-users mailing list some time ago,
> without answer.
> 
> 
> I have tested the D-Link DBT-122 dongle (BCM2035 chipset) with
> BlueZ-utils and I find the following features list:
> 
> # hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:13:46:01:22:90 ACL MTU: 377:10 SCO MTU: 16:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff
> mode>
>                 <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power
> control>
>                 <transparent SCO> <enhanced iscan> <interlaced iscan>
>                 <interlaced pscan> <AFH cap. slave> <AFH cap. master>
> 
> Looking the manufactured specification page of BCM2035 chipset it says
> that it implements the Bluetooth v1.2 specification. Nevertheless I
> found that it's not true, because this dongle doesn't support the
> <Inquiry with RSSI> feature, that belongs to that version and
> following of the BT specification.
> 
> 
> I have also tested other usb dongles, for example CSR BlueCore4,
> successfully with this feature:
> 
> # hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:80:5A:46:2D:51 ACL MTU: 384:8 SCO MTU: 64:8
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff
> mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2
> packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
> scheme>
>                 <power control> <transparent SCO> <broadcast encrypt>
>                 <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
>                 <interlaced iscan> <interlaced pscan> <inquiry with
> RSSI>  <-----
>                 <extended SCO> <EV4 packets> <EV5 packets> <AFH cap.
> slave>
>                 <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
>                 <AFH cap. master> <AFH class. master> <EDR eSCO 2
> Mbps>
>                 <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended
> features>
> 
> 
> 
> Please, could you confirm me that it's impossible to make an "Inquiry
> with RSSI" operation with the BCM2035 chipset from Broadcom ?
> Do you know on existence of an firmware upgrade for this chipsets that
> solves this lack ?

simply try "hciconfig hci0 inqmode 1" and monitor with "hcidump -X -V"
what happens if you call "hcitool scan". I've seen some Broadcom chips
that don't set the feature bit for inquiry with RSSI, but they do
support it.

Regards

Marcel




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
