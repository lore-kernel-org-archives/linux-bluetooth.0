Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9cc82a4d0610040220ldf5218bo608969a33cffd7da@mail.gmail.com>
Date: Wed, 4 Oct 2006 09:20:27 +0000
From: "Guylhem Aznar" <bluez-devel@externe.net>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0610031651360.5319@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <9cc82a4d0610030746r7039990eie8397add3559ca80@mail.gmail.com>
	<Pine.LNX.4.63.0610031651360.5319@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] High speed serial connection (Was: Bluez article
	on OReillyNet)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello

On 10/3/06, Peter Wippich <pewi@gw-instruments.de> wrote:
> > - A Zaurus 6000, which is a PXA 255
> > - A Zaurus C860, which is also a PXA 255.
> This two shall work with a HWUART driver. Make sure the BT Chip is
> connected to the BTUART, which is shared with the HWUART (/dev/ttyS1).

Not on the C860: /dev/ttyS0, and neither on the 6000 : /dev/ttyS2

But sharp gives weird names to their serial ports that do not reflect
the uart connection - I will check the addresses directly in the
sourcecode and guess the correct uart=E9

> Ok, but be warned. It will not run out of the box and is only tested with
> 2.6.14 kernel. I've attached the driver source and a modified Kconfig and
> Makefile. This will go to linux/drivers/bluetooth/ . You also have to edit
> the Kconfig to get the driver enabled for your machine type.

I'll try to tweak it and let you know my results. Can I put a kernel
sourcetree somewhere for you to see?

BTW I notice it comes from the ROAD S101. Any news on the device ?
I am eager to see it reaching the market to review it. Last seen on
press releases in Auguest.

Guylhem

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
