Return-Path: <vojtech@suse.cz>
Date: Sun, 15 Aug 2004 15:10:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: cijoml@volny.cz, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS multimedia keys
Message-ID: <20040815131009.GA1752@ucw.cz>
References: <411EF7C7.10900@hotmail.com> <200408151040.00772.cijoml@volny.cz> <200408151132.15730.cijoml@volny.cz> <1092565721.4375.37.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092565721.4375.37.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Sun, Aug 15, 2004 at 12:28:41PM +0200, Marcel Holtmann wrote:

> Hi Michal,
> 
> > and when pressed this is sent into dmesg:
> > 
> > Eigene Dateien
> > keyboard.c: can't emulate rawmode for keycode 253
> > keyboard.c: can't emulate rawmode for keycode 253
> > Eigene Bilder
> > keyboard.c: can't emulate rawmode for keycode 254
> > keyboard.c: can't emulate rawmode for keycode 254
> > Eigene Musik
> > keyboard.c: can't emulate rawmode for keycode 255
> > keyboard.c: can't emulate rawmode for keycode 255
> > Messenger
> > keyboard.c: can't emulate rawmode for keycode 252
> > keyboard.c: can't emulate rawmode for keycode 252
> > Abmelden
> > keyboard.c: can't emulate rawmode for keycode 248
> > keyboard.c: can't emulate rawmode for keycode 248
> 
> this problem is because in drivers/char/keyboard.c the x86_keycodes[256]
> array miss the line for the last 16 keycode translations.
> 
> Vojtech, any reason why they are not filled in?
 
Because rawmode only can express 240 different scancodes.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
