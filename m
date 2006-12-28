Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <544bb7070612280942n6907d4e2u107654fd71310df4@mail.gmail.com>
Date: Thu, 28 Dec 2006 09:42:53 -0800
From: "Ian Rickard" <inioinio@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0612281212140.12381@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <544bb7070612272338m3f130e00p22ee2f1b7f67d3cb@mail.gmail.com>
	<56233.80.165.155.106.1167300847.squirrel@webmail10.pair.com>
	<Pine.LNX.4.63.0612281212140.12381@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] bdaddr for CSR chipset - porting dificulties
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

But only UART, not USB?  I tried again with transient = true (word 7 =
0x0008) and I still get a response with status 0x0009.

And yeah, I understand changing your BT address is generally a bad
idea.  This is just for research purposes.  I'm trying to get a Wii to
connect to a MacBook as if it were a Wii Remote and so far just
matching the device name/class has proved insufficient.  Current
theory is it will only connect to devices in Nintendo's OUI ranges.

On 12/28/06, Peter Wippich <pewi@gw-instruments.de> wrote:
>
> Hi,
>
> > > I've been working on porting bluez's bdaddr utility to mac, and I
> > > think I'm making pretty good progress.  After digging around the
> > > internals of IOBluetooth.framework, I've managed to, I think,
> > > replicate the behavior of bdaddr's csr_write_bd_addr and
> > > csr_reset_device.
> > >
> > > as far as I can tell, the command sent matches exactly what
> > > csr_write_bd_addr would have sent with transient=false and addr =
> > > 00-16-cb-1b-7e-ad.  Anyone see what I'm doing wrong?  Or even any clue
> > > what status 0x0009 is?
> >
> >
> > Status 0x0009 = PERMISSION_DENIED
> >
> > I dont think you can change the bd_addr in the CSR chipset
> > via UART/USB HCI commmands, only via SPI.
> > Normally you only want to set the bd_addr during production.
> >
>
> You can change it over the UART by using the bccmd util provided with
> bluez utils. However, in the default configuration this will only change the
> address in RAM, not permanently in flash. This is by intention because
> normaly you're not expected to do this unless you own a block of OUI
> numbers where you can take a valid address from.
>
> So, as Susanne already mentioned normaly only in production.
>
> Ciao,
>
> Peter
>
>
> |       Peter Wippich                   Voice: +49 30 46776411          |
> |       G&W Instruments GmbH            fax:   +49 30 46776419          |
> |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
> |       D-13355 Berlin  / Germany                                       |
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
