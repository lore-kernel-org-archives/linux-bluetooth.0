Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9cc82a4d0610030741t3e830a20ib170103e7d3a86c2@mail.gmail.com>
Date: Tue, 3 Oct 2006 14:41:43 +0000
From: "Guylhem Aznar" <guylhem@guylhem.net>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0610031538100.5319@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <9cc82a4d0610020710q17efb8efk99079c5f943ddaf8@mail.gmail.com>
	<4521D073.1030105@xmission.com> <45221882.3020809@palmsource.com>
	<9cc82a4d0610030425g3c078f62o77fd4d29318c4bee@mail.gmail.com>
	<45226231.6080203@palmsource.com>
	<9cc82a4d0610030619qbc160fdqe983cb529e5f8c02@mail.gmail.com>
	<Pine.LNX.4.63.0610031538100.5319@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] Bluez article on OReillyNet
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

Hello,

On 10/3/06, Peter Wippich <pewi@gw-instruments.de> wrote:
> Depending on your system it is most likely that the HW Uart extension is
> not realy supported by the serial driver. I currently only know for sure
> for PXA type system. You need a special HWUART driver to take advantage of
> the HWUART.

There are 4 ARM systems I can try that with

- A Zaurus 6000, which is a PXA 255

- A Zaurus C860, which is also a PXA 255.

- An Acer N30, but it's a s3c2410, which is quite different.

- A Simpad - however it is a SA 1100, which has no HWUART. Moreover,
its bluetooth module needs some reflashing (which I can't do). It is
on ttySA1 - cf http://www.guylhem.net/r-hardware/simpad/bluetooth/ for
the hardware part, http://opensimpad.org/index.php/Simpad.c for the
software part.

> For a PXA system we may help you out if you insist.

Yes please. I would make a great base for the article.

> Further you may get problems with the RS232 driver chips usualy
> used. If you're able to connect the serial bluetooth module directly to
> the ARM UART lines (Rx / Tx / RTS /CTS) (3 Volt interface without RS232
> driver on both sides) this would be much better.

On the Zaurus 6000, I didn't add the module myself, but I think it's
on 3.3 V directly. It is also on the UART that can be rerouted to
HWUART (FTUART ?)

On the C860, it is directly soldered to the UART lines - yet to ones
of the standard serial port - ttyS0, which I think is STUART (will
check tonight) and which can not be rerouted to HWUART IIRC.

The demo could use either a 2.4 or 2.6 kernel. I usually run a 2.4 on
the 6000 and a 2.6 on the 860 but that's only for tests.

On the N30, I really don't know the s3c2410 - bluetooth work fine with
a 2.6 kernel.

Tell me if you need more information.

Guylhem

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
