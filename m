Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MS multimedia keys
References: <411EF7C7.10900@hotmail.com> <1092590175.4375.59.camel@pegasus> <20040815190508.GC2321@ucw.cz>
In-Reply-To: <20040815190508.GC2321@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408152127.44433.cijoml@volny.cz>
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
Date: Sun, 15 Aug 2004 21:27:43 +0200

Marcel, 

so you must remap it to lower numbers first before you'll send it into 
keyboard.c???

Michal

Dne ne 15. srpna 2004 21:05 Vojtech Pavlik napsal(a):
> On Sun, Aug 15, 2004 at 07:16:15PM +0200, Marcel Holtmann wrote:
> > Hi Vojtech,
> >
> > > > > Eigene Musik
> > > > > keyboard.c: can't emulate rawmode for keycode 255
> > > > > keyboard.c: can't emulate rawmode for keycode 255
> > > > > Messenger
> > > > > keyboard.c: can't emulate rawmode for keycode 252
> > > > > keyboard.c: can't emulate rawmode for keycode 252
> > > > > Abmelden
> > > > > keyboard.c: can't emulate rawmode for keycode 248
> > > > > keyboard.c: can't emulate rawmode for keycode 248
> > > >
> > > > this problem is because in drivers/char/keyboard.c the
> > > > x86_keycodes[256] array miss the line for the last 16 keycode
> > > > translations.
> > > >
> > > > Vojtech, any reason why they are not filled in?
> > >
> > > Because rawmode only can express 240 different scancodes.
> >
> > may you explain this a little bit. I found a posting from you on the
> > LKML where you said this has something do to with the PS/2 protocol, but
> > I still can't follow it.
>
> The PS/2 protocol has valid keycodes in these two ranges:
>
> 	00 to 5f and e0 00 to e0 5f
>
> The first is the classic XT set and the other is the extended set. Of
> course there are exceptions and also some of the 60-7f and e060-e07f can
> be used. This gives approximately 240 possible scancodes.
>
> The table maps those 240 scancodes to the first 240 Linux keycodes.
> Keycodes above this limit don't have any mapping, because it'd have to
> be identical with some already used, or cause a protocol violation.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
