Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Help needed with getting Bluez on Axis Dev Board
	82
From: Roderick Taylor <rtaylor@hcvwireless.com>
To: tereza99@hotmail.com
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1094997879.5695.16.camel@pegasus>
References: <BAY2-F7xJagXTi8M19V0000e6e7@hotmail.com>
	 <1094997879.5695.16.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1100164121.8079.24.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 Nov 2004 09:08:42 +0000

Hi Theresa,

I=B4ve done this for a different Dev board.  Not an Axis one.

To do this, I

1. Patched the supplied kernel (mine was 2.4.19) source with Marcel=B4s
patch. "patch -p1 < patchfile.patch" for example

2. Configured the kernel kernel as per dev board instructions
instructions

3. Added Bluetooth support to the kernel using "make xconfig".

4. Compiled the kernel using the supplied cross compiler "make zImage"=20

5. Put the new kernel on the Dev board (My dev board has Flash ROM)

6. Cross Compiled the bz libs and bz utils. These didn=B4t cleanly cross
compile.  I had to twiddle with the bluez=B4s makefiles and stuff to get
it to work properly.

7. Added the kernel modules, libraries and utils to the filesystem image
(you can copy then with ssh or ftp or whatever if you don't want to
flash a new image, although I recommend doing it this way)

I did it a while ago and other things have taken precedence since so I
am sketchy on the details. Hope this helps.

Rod.


On Sun, 2004-09-12 at 15:04, Marcel Holtmann wrote:
> Hi Theresa,
>=20
> > I am a desperate newbie in need of help getting Bluez working on my Axi=
s Dev=20
> > board 82.  I have seen some posts by others implying they somehow got t=
hings=20
> > working on their boards.
> >=20
> > For those who dont know much about kernels and writing patches, is ther=
e a=20
> > "how to" or list of instructions to help us get going.  For instance, w=
hat=20
> > do I do first?  The latest version for the board is 2.4.26 - so am I=20
> > supposed to apply Marcel's patch for that kernel from the Bluez site?  =
If=20
> > so, are there any special things that I am to do in addition?
> >=20
> > I also saw a post that said someone had cross compiled bluez...does tha=
t=20
> > mean i have to put that into my makefile for the board?
> >=20
> > Please forgive me for not knowing much, as I am still learning about th=
ings.
>=20
> I have never done this before. Ask the Axis guys directly to provide you
> with more information. They should drop their OpenBT in favour of BlueZ
> and help people using it or ask them to send me a bunch of their boards
> for testing.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.=20
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
