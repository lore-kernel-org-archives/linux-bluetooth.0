Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bthid 2.6.5 bad keycode
References: <200404192354.21196.cijoml@volny.cz> <200404200013.21239.cijoml@volny.cz> <1082413123.4403.81.camel@pegasus>
In-Reply-To: <1082413123.4403.81.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404200028.23722.cijoml@volny.cz>
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
Date: Tue, 20 Apr 2004 00:28:23 +0200

Hi,

I tried change to pc105 layout, but without success:

KeyPress event, serial 28, synthetic NO, window 0x2000001,
    root 0x3f, subw 0x0, time 100219, (-255,261), root:(336,281),
    state 0x0, keycode 62 (keysym 0xffe2, Shift_R), same_screen YES,
    XLookupString gives 0 characters:  ""

KeyPress event, serial 28, synthetic NO, window 0x2000001,
    root 0x3f, subw 0x0, time 100559, (-255,261), root:(336,281),
    state 0x1, keycode 111 (keysym 0xff61, Print), same_screen YES,
    XLookupString gives 0 characters:  ""

KeyRelease event, serial 28, synthetic NO, window 0x2000001,
    root 0x3f, subw 0x0, time 100660, (-255,261), root:(336,281),
    state 0x1, keycode 111 (keysym 0xff61, Print), same_screen YES,
    XLookupString gives 0 characters:  ""

KeyRelease event, serial 28, synthetic NO, window 0x2000001,
    root 0x3f, subw 0x0, time 100698, (-255,261), root:(336,281),
    state 0x1, keycode 62 (keysym 0xffe2, Shift_R), same_screen YES,
    XLookupString gives 0 characters:  ""

I think microsoftpro includes pc105 layout...so no change :(

Michal

Dne =FAt 20. dubna 2004 00:18 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > my XFreeconfig:
> >
> > <snip>
> >
> > Section "InputDevice"
> >         Identifier  "Laptop_keyboard"
> >         Driver      "keyboard"
> >         Option      "XkbRules"  "xfree86"
> >         Option      "XkbModel"  "microsoftpro"
> >         Option      "XkbLayout" "us"
> >         #Option     "Xleds"     "1 2 3"
> >         #Option     "XkbVariant"        "nodeadkeys"
> > EndSection
> >
> > </snip>
> >
> > What's wrong? Couldn't it have the same behavior as under 2.4.26?
> > I found out, that some multimedia keys returns another events too.
>
> actually for me this was XFree 4.2 against 4.3 and the pipe key is not
> present on a pc104 keyboard layout.
>
> > And now question to multimedia keys.
> > Does any standart exist for return codes after key press of any key?
> > I have another 4 multimedia keys on my laptop and they returns another
> > events for e-mail, web etc keys as your bthid translation.
>
> You are asking the wrong guy. I am no X11 or input expert.

Well, I'll try directly linux-kerne@vger

>
> Regards
>
> Marcel

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
