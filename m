Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100817084850.GA16821@joshua.mesa.nl>
References: <201008121013.o7CADR8r004125@joshua.mesa.nl>
	<1281613299.12579.266.camel@localhost.localdomain>
	<20100816172238.GA27814@joshua.mesa.nl>
	<AANLkTi=p5WD+WELPNo=URLVTnpaKQ4xFk9Efu2HiviYE@mail.gmail.com>
	<20100817084850.GA16821@joshua.mesa.nl>
Date: Thu, 19 Aug 2010 13:53:21 +0300
Message-ID: <AANLkTinD_KNBBpxwXZ8gB5p2o+NA_ThfbmspXe-5NGEc@mail.gmail.com>
Subject: Re: [PATCH] IrMC sync server support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Aug 17, 2010 at 11:48 AM, Marcel J.E. Mol <marcel@mesa.nl> wrote:
> Ok, then 17 is just fine for IrMC then. I posted a 3th version at the end=
 of
> last week. Are there any new comments I have to take care of? Or can it =
=A0be
> considere for inclusion in the main tree now?
>
>
> On the other hand, if the channel 'varies' it might be better to let the
> plugin manager select a channel number for each service instead of alloca=
ting
> a fixed one in the specific plugin code.
>
> What did you found about channel 11 then? On my nokia 7710 channel 11 is =
used for
> "OBEX File Transfer" (serivce 0x1106).

We decided to use 14, also Johan pushed a complete list of bluez
assigned number to:

http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommitdiff;h=3Dfbeff4fd3=
03b43fa7f6c27e95fb6f023e80720a9;hp=3D0627552640140e1d986d36bb4770ccc4b3206b=
03

Could you please update your changes to use 14? Also there seems to be
some white spaces that doesn't follow our code styling, could you
please fix those?

--=20
Luiz Augusto von Dentz
Computer Engineer
