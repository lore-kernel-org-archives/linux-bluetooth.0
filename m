Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <dc98d8d9050904210345205b4c@mail.gmail.com>
From: Paul Webster <pjwebster@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bcm2035
In-Reply-To: <004e01c5b159$3dff3bb0$0100a8c0@rdhome>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local>
	 <001601c5b09c$df79dee0$0201a8c0@NBVICTOR>
	 <001301c5b0be$d4717f90$0100a8c0@rdhome>
	 <dc98d8d9050904050925daa428@mail.gmail.com>
	 <004e01c5b159$3dff3bb0$0100a8c0@rdhome>
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
Date: Mon, 5 Sep 2005 14:03:21 +1000

On 9/5/05, Oliver Ruiz Dorantes <urnenfel@tiscali.es> wrote:
> Paul,
>=20
> > bluetooth installed again. I kept getting errors saying that the
> > bluetooth license was not valid, and asking to locate the correct
> > license file.
>=20
> Same on mine in different computers, I think in this license file there
> could be at least a BD_ADDR wich matches the Broadcom assigned values, an=
d
> as it is reported as 00:00:00:00:00:00 causes the mismatch.
Hmmm, I think it's about time I lodged a support issue with my laptop
manufacturer and see what they come up with, at least with regards to
fixing the Windows side of things. That may shed light on the monster
we're dealing with here.

> > ~ $ hidd --show
> > 00:0A:94:C0:2A:6E HID Boot Device [0000:0000] connected [boot-protocol]
>=20
> As I can see this is the BD_ADDR of the keyboard, but were you able to ge=
t a
> valid BD_ADDR of your built-in device? in other words, can another device=
s
> look for you / connect to you?

Yeah, that was just to show that it's operational one way. I made a
half-hearted attempt to connect my bluetooth mobile without success
when I first got bluez up, but it was late, so I gave up and didn't
try again. I'll give it a go next time I try things with bluez

> > This is kind of an interesting idea. I would have assumed that the
> > BD_ADDR was a harware adress, and not alterable by software.
>=20
> Me also, I have seen looking for, and i found sources (setbd-bluez.c) tha=
n
> can set the BD_ADDR of a "Ericsson ROK 101" issuing 2 HCI commands in the
> ogf 0x3f which is out of the specifications:
>=20
> HCI Command: ogf 0x3f, ocf 0x000d, plen 6
> HCI Command: ogf 0x3f, ocf 0x0022, plen 0
>=20
> So here it looks like there is a "hide way" at least for this Ericsson
> device.
>=20
> Can I keep hope that Broadcom left this possibility as well, and start to
> cast commands in the 0x3f  range?

This looks like they're setting a BD_ADDR of a remote device over a
bluetooth connection, not the local one. Trawling other links on the
digitalmunition website hosting the file you referenced found
references to the license.dat issue. More trawling to be done outside
of work hours :)


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
