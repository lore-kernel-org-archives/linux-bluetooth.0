Return-Path: <jjbrucker@free.fr>
Message-ID: <1158570541.450e622da6e80@imp6-g19.free.fr>
Date: Mon, 18 Sep 2006 11:09:01 +0200
From: jjbrucker@free.fr
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Subject: re: re : re specific keyboard in hidd
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

> Hi Jean-Jacques,
>
> >  About the left space : it work but I have assigned it to Alt key. At
> > the end we need a special kmap file to be able to use all features of
> > this keybord, ( mine is an azerty keyboard), in this keymap file (or
> > using xmodmap with X) we could reassign left space button to space
> > event and Alt gr button to Alt and Alt gr event !
> >
> >  I have assigned this button to Alt because I missed him (to switch
> > between console for exemple), And to not loose a special keypress on
> > the keyboard. (it already have a few keys... only 63 !).
bash: !: event not found
>
> the actual keyboard layout maybe needs a re-thinking. I leave this to
> actual users of it.
>
Yes, maybe. But i really think we don't have to loose a key in hidd "driver" on
this small keyboard. This kind of keyboard is made to machines who didn't have
an other keyboard (like pda, phones ...). So we can load a "Smart keyboard"
specific keymap file for this machine. The only challenge is to make the same
layout for all this kind of tiny bluetooth keyboard. (Have the other one at
less an escape button ?).

> >  At the end my patch suggested an architecture to manage different
> > peripherals. The code in is actual state will become a big mess if the
> > number of differents peripheral to manage increase.
>
> No it wasn't an architecture. It still was a hack. The decoding routine
> for the keyboard was still named epox_decode(). A clean architecture
> would have used a callback table or something similar. You can't design
> an architecture if you don't have enough facts about the devices you are
> trying to cover. Everything that is based on the Serial Port Profile and
> which uses a proprietary protocol on top of RFCOMM is a problem and all
> of them are basically unique.

You're right about that.
I didn't exactly know why this function was called epox_decode (i didn't know
about an epox device even if I supposed it comes from it)and that is was i
don't have rename it. Yes I prefer to use a callback table as well, and I don't
have enough facts about the devices to cover.
>
> I prefer the less intrusive approach and this was to use the class of
> device and/or service name for detecting the (at the moment) two
> different devices. I would pick the OUI part of the BD_ADDR only if I
> have no other choice and trusting the remote name is also not a good
> idea, because some input devices allow to change it.
>
Trusting the remote name is really the worst idea, but (that was the first I
have and)we will maybe have no choice...
 I hope the class and service name will be enough to detect 2 different devices.
But we don't know what futur bt device will be and comparing the bd_addr to a
(small, smallest) database of devices ranges is the most reliable method.

> And besides the Laserkey keyboard, I don't expect any other kind of
> Bluetooth input device. The HID is a standard and if you buy a CSR chip,
> you basically get the HID support for free. They did all the work for
> running HID on the chip.
>
I don't expect too any other kind of Bluetooth device, but we are not behind all
bluetooth device manufacter to teach them how to run HID on the chip and not
making specific (windows) drivers ...

> Regards
>
> Marcel

I am not offensed you don t have use the devices.h in the CVS, I just want that
we already have (good) ideas and some lines about how to do IF we will have to
manage more specifics devices.
But today we don't know too much specifics devices...

cordialement,
Jean-Jacques.
