Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] probleme installing Wireless IntelliMouse and
	optical desktop
From: Marcel Holtmann <marcel@holtmann.org>
To: nicolas <n1c0l4s.l3@wanadoo.fr>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406151155.09370.n1c0l4s.l3@wanadoo.fr>
References: <200406151155.09370.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1087294271.13792.87.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 15 Jun 2004 12:11:11 +0200

Hi Nicolas,

> i have some questions  because i have kernel 2.6.7Rc2mdk and my bluetooth is 
> recognise

first you need a least the 2.6.6-mh3 patch in your kernel and you must
activate HIDP support.

> $ hcitool inq
> Inquiring ...
>         00:50:F2:7F:C4:E8       clock offset: 0x6892    class: 0x002580
>         00:50:F2:80:A1:2B       clock offset: 0x6d26    class: 0x002540
> $ hcitool scan
> Scanning ...
>         00:50:F2:7F:C4:E8       Microsoft Mouse
>         00:50:F2:80:A1:2B       Microsoft Keyboard
> # hcitool info 00:50:F2:80:A1:2B
> Requesting information ...
>         BD Address:  00:50:F2:80:A1:2B
>         Device Name: Microsoft Keyboard
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x1df
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xfc 0xfb 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <encryption> <slot offset> <timing accuracy> <role switch>
>                 <hold mode> <sniff mode> <park state> <RSSI> <SCO link>
>                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
>                 <paging scheme> <power control> <transparent SCO>
> # hcitool info 00:50:F2:7F:C4:E8
> Requesting information ...
>         BD Address:  00:50:F2:7F:C4:E8
>         Device Name: Microsoft Mouse
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x1d0
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xfc 0xfb 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <encryption> <slot offset> <timing accuracy> <role switch>
>                 <hold mode> <sniff mode> <park state> <RSSI> <SCO link>
>                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
>                 <paging scheme> <power control> <transparent SCO>
> #
> 
> but how to connecte it   to use it?
> 
> i don't understand   i have look at 
> http://www.holtmann.org/linux/bluetooth/microsoft.html but it doesn't
> 
> there is someone using it and which have the solution?

I splitted the pages yesterday, because it seems that every HID device
has its bugs and the text on www.holtmann.org/linux/bluetooth/hid.html
was getting too long.

More detailed information can be found in the mailing list archives, but
the short is; get the hidp.ko kernel module and install bluez-libs-2.7
and bluez-utils-2.7. Then start "hidd --server" and use "hidd -c ..."
for the initial connection to your mouse and keyboard.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
