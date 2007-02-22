Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45DD2E5E.1060703@yahoo.com.au>
References: <45D9E0ED.8090700@yahoo.com.au>
	<1171907659.26567.29.camel@violet> <45D9F9DC.1030606@yahoo.com.au>
	<1172060009.7403.17.camel@violet>  <45DD2E5E.1060703@yahoo.com.au>
Date: Thu, 22 Feb 2007 07:52:03 +0100
Message-Id: <1172127123.14885.2.camel@violet>
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

> > then something is broken here. Can't tell your what, but it should work.
> 
> I tried booting Knoppix and running lsusb, and it also claimed that the
> dongle was in "HCI mode".  Since that version of Knoppix predates
> hid2hci, I think I can assume that this dongle is not booting in HID
> mode as I thought it would.
> 
> Is it likely that either this particular chip doesn't support HID proxy
> despite being bluecore 4, or that it has some pin wired hard to ground
> to disable this feature?

wait a second. You don't even know if it is a HID proxy dongle. You
should run "hciconfig hci0 revision" as root. If this is a ROM version
then it is not HID proxy. And even if it is an External version, you
still need to have to correct unified firmware and the correct boot
parameter to make it come up in HID mode first.

> >> Second, I'm a little confused about how this "HID proxy" thing works
> >> anyway.  How does the dongle remember which mouse and keyboard it's
> >> paired with after the power is switched off?  Does it have a little bit
> >> of flash on board that remembers the last paired device or something?
> >> Or have I completely misunderstood what this feature is for?
> > 
> > That is the magic in the dongle HID software. It parses HID devices in
> > the background when it is in HCI mode.
> 
> Yeah, that bit I get.  But it must also know which devices to connect
> to, and assuming it's using an encrypted link, it also needs a key.
> That has to be stored somewhere so it persists when the thing is powered
> down.  Does that mean it's got an extra little bit of flash hidden
> inside the bluecore somewhere?  Or does it use the external flash chip?
>  That matters, because it would imply that only bluecore chips with
> external storage would work in HID proxy mode.

You need a BlueCore External to have HID proxy support. The ROM versions
are all HCI only.

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
