Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bthid 2.6.5 bad keycode
References: <200404192354.21196.cijoml@volny.cz> <1082412454.4403.77.camel@pegasus>
In-Reply-To: <1082412454.4403.77.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404200013.21239.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 20 Apr 2004 00:13:21 +0200

Hi Marcel,

my XFreeconfig:

<snip>

Section "InputDevice"
        Identifier  "Laptop_keyboard"
        Driver      "keyboard"
        Option      "XkbRules"  "xfree86"
        Option      "XkbModel"  "microsoftpro"
        Option      "XkbLayout" "us"
        #Option     "Xleds"     "1 2 3"
        #Option     "XkbVariant"        "nodeadkeys"
EndSection

</snip>

What's wrong? Couldn't it have the same behavior as under 2.4.26?
I found out, that some multimedia keys returns another events too.

And now question to multimedia keys.
Does any standart exist for return codes after key press of any key?
I have another 4 multimedia keys on my laptop and they returns another even=
ts=20
for e-mail, web etc keys as your bthid translation.

Michal

Dne =FAt 20. dubna 2004 00:07 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > there is bug in 2.6.5 and bthid configuration.
> > It badly resolve "|" key:
> >
> > KeyPress event, serial 28, synthetic NO, window 0x2800001,
> >     root 0x3f, subw 0x0, time 645528, (104,-2), root:(695,18),
> >     state 0x90, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
> >     XLookupString gives 0 characters:  ""
> >
> > KeyPress event, serial 28, synthetic NO, window 0x2800001,
> >     root 0x3f, subw 0x0, time 645982, (104,-2), root:(695,18),
> >     state 0x91, keycode 111 (keysym 0xff61, Print), same_screen YES,
> >     XLookupString gives 0 characters:  ""
> >
> > KeyRelease event, serial 28, synthetic NO, window 0x2800001,
> >     root 0x3f, subw 0x0, time 646121, (104,-2), root:(695,18),
> >     state 0x91, keycode 111 (keysym 0xff61, Print), same_screen YES,
> >     XLookupString gives 0 characters:  ""
> >
> > KeyRelease event, serial 28, synthetic NO, window 0x2800001,
> >     root 0x3f, subw 0x0, time 646842, (104,-2), root:(695,18),
> >     state 0x91, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
> >     XLookupString gives 0 characters:  ""
> >
> > It returns Print and not "|"
> >
> > It is problem to use unix like system without | :)
>
> what is your X11 keyboard setting? You need to use a pc105 keyboard
> layout to get the pipe key back.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
