Return-Path: <vojtech@suse.cz>
Date: Sun, 15 Aug 2004 21:05:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: cijoml@volny.cz, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS multimedia keys
Message-ID: <20040815190508.GC2321@ucw.cz>
References: <411EF7C7.10900@hotmail.com> <200408151040.00772.cijoml@volny.cz> <200408151132.15730.cijoml@volny.cz> <1092565721.4375.37.camel@pegasus> <20040815131009.GA1752@ucw.cz> <1092590175.4375.59.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092590175.4375.59.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Sun, Aug 15, 2004 at 07:16:15PM +0200, Marcel Holtmann wrote:
> Hi Vojtech,
> 
> > > > Eigene Musik
> > > > keyboard.c: can't emulate rawmode for keycode 255
> > > > keyboard.c: can't emulate rawmode for keycode 255
> > > > Messenger
> > > > keyboard.c: can't emulate rawmode for keycode 252
> > > > keyboard.c: can't emulate rawmode for keycode 252
> > > > Abmelden
> > > > keyboard.c: can't emulate rawmode for keycode 248
> > > > keyboard.c: can't emulate rawmode for keycode 248
> > > 
> > > this problem is because in drivers/char/keyboard.c the x86_keycodes[256]
> > > array miss the line for the last 16 keycode translations.
> > > 
> > > Vojtech, any reason why they are not filled in?
> >  
> > Because rawmode only can express 240 different scancodes.
> 
> may you explain this a little bit. I found a posting from you on the
> LKML where you said this has something do to with the PS/2 protocol, but
> I still can't follow it.
 
The PS/2 protocol has valid keycodes in these two ranges:

	00 to 5f and e0 00 to e0 5f

The first is the classic XT set and the other is the extended set. Of
course there are exceptions and also some of the 60-7f and e060-e07f can
be used. This gives approximately 240 possible scancodes.

The table maps those 240 scancodes to the first 240 Linux keycodes.
Keycodes above this limit don't have any mapping, because it'd have to
be identical with some already used, or cause a protocol violation.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
