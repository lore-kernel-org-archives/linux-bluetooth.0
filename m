Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS multimedia keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: cijoml@volny.cz, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040815131009.GA1752@ucw.cz>
References: <411EF7C7.10900@hotmail.com>
	 <200408151040.00772.cijoml@volny.cz> <200408151132.15730.cijoml@volny.cz>
	 <1092565721.4375.37.camel@pegasus>  <20040815131009.GA1752@ucw.cz>
Content-Type: text/plain
Message-Id: <1092590175.4375.59.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 15 Aug 2004 19:16:15 +0200

Hi Vojtech,

> > > Eigene Musik
> > > keyboard.c: can't emulate rawmode for keycode 255
> > > keyboard.c: can't emulate rawmode for keycode 255
> > > Messenger
> > > keyboard.c: can't emulate rawmode for keycode 252
> > > keyboard.c: can't emulate rawmode for keycode 252
> > > Abmelden
> > > keyboard.c: can't emulate rawmode for keycode 248
> > > keyboard.c: can't emulate rawmode for keycode 248
> > 
> > this problem is because in drivers/char/keyboard.c the x86_keycodes[256]
> > array miss the line for the last 16 keycode translations.
> > 
> > Vojtech, any reason why they are not filled in?
>  
> Because rawmode only can express 240 different scancodes.

may you explain this a little bit. I found a posting from you on the
LKML where you said this has something do to with the PS/2 protocol, but
I still can't follow it.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
