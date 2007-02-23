Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45DE8544.4010900@yahoo.com.au>
References: <45D9E0ED.8090700@yahoo.com.au>
	<1171907659.26567.29.camel@violet> <45D9F9DC.1030606@yahoo.com.au>
	<1172060009.7403.17.camel@violet> <45DD2E5E.1060703@yahoo.com.au>
	<1172127123.14885.2.camel@violet>  <45DE8544.4010900@yahoo.com.au>
Date: Fri, 23 Feb 2007 08:07:20 +0100
Message-Id: <1172214440.28266.4.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hid2hci fails: broken pipe
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> > wait a second. You don't even know if it is a HID proxy dongle. You
> > should run "hciconfig hci0 revision" as root. If this is a ROM version
> > then it is not HID proxy. And even if it is an External version, you
> > still need to have to correct unified firmware and the correct boot
> > parameter to make it come up in HID mode first.
> ...
> > You need a BlueCore External to have HID proxy support. The ROM versions
> > are all HCI only.
> 
> Aw man, I tried.  I really tried.  Look here:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=31657125&forum_id=1883
> 
> Didn't I try?  Yes, I tried.  And it didn't bloody help, did it?
> 
> aeon:~# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
>         HCI 18.2.1
>         Chip version: BlueCore3-ROM
>         Max key size: 128 bit
>         SCO mapping:  HCI
> 
> There it is, in black and white.  It's the ROM version.  I guess a
> DN-3008M1 really is completely different to a DN-3008.  That or New
> Zealand websites are evil and shouldn't be trusted.
> 
> So OK, maybe you can tell me.  I would like to buy a USB Bluetooth
> dongle that does the HID proxy thing, preferably 2.0, preferably class
> 1.  Do you know where I might be able to buy such a thing?

don't ask me. It is kinda hard to find a BlueCore4-External dongle these
days. And I actually need some where you can flash new firmware into it.
If anyone find a reliable source of these, I would buy at least a
handful. The best ones _were_ the Level1 things, because they used a
high quality flash chip. However the new ones have ROM chips as well.

> And also: boot parameter?  Do you mean a Linux boot parameter or another
> setting that goes on the flash of the dongle?  Because if it's the
> former, that would invalidate the whole point of HID proxy, wouldn't it?

The CSR unified firmware has a boot parameter where you can tell it to
boot up in HID mode or HCI mode (and some other modes). In general every
unified firmware is HID proxy capable. You might simply have to switch
it on.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
