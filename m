Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45DE8544.4010900@yahoo.com.au>
Date: Fri, 23 Feb 2007 07:10:12 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <45D9E0ED.8090700@yahoo.com.au>	<1171907659.26567.29.camel@violet>
	<45D9F9DC.1030606@yahoo.com.au>	<1172060009.7403.17.camel@violet>
	<45DD2E5E.1060703@yahoo.com.au> <1172127123.14885.2.camel@violet>
In-Reply-To: <1172127123.14885.2.camel@violet>
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

Marcel Holtmann - marcel@holtmann.org wrote:

> wait a second. You don't even know if it is a HID proxy dongle. You
> should run "hciconfig hci0 revision" as root. If this is a ROM version
> then it is not HID proxy. And even if it is an External version, you
> still need to have to correct unified firmware and the correct boot
> parameter to make it come up in HID mode first.
...
> You need a BlueCore External to have HID proxy support. The ROM versions
> are all HCI only.

Aw man, I tried.  I really tried.  Look here:

http://sourceforge.net/mailarchive/forum.php?thread_id=31657125&forum_id=1883

Didn't I try?  Yes, I tried.  And it didn't bloody help, did it?

aeon:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
        HCI 18.2.1
        Chip version: BlueCore3-ROM
        Max key size: 128 bit
        SCO mapping:  HCI

There it is, in black and white.  It's the ROM version.  I guess a
DN-3008M1 really is completely different to a DN-3008.  That or New
Zealand websites are evil and shouldn't be trusted.

So OK, maybe you can tell me.  I would like to buy a USB Bluetooth
dongle that does the HID proxy thing, preferably 2.0, preferably class
1.  Do you know where I might be able to buy such a thing?

And also: boot parameter?  Do you mean a Linux boot parameter or another
setting that goes on the flash of the dongle?  Because if it's the
former, that would invalidate the whole point of HID proxy, wouldn't it?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
