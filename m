Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MS multimedia keys
References: <411EF7C7.10900@hotmail.com> <1092565721.4375.37.camel@pegasus> <20040815131009.GA1752@ucw.cz>
In-Reply-To: <20040815131009.GA1752@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408151559.04506.cijoml@volny.cz>
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
Date: Sun, 15 Aug 2004 15:59:04 +0200

Marcel,

that means, that these keys will never work?

Michal

Dne ne 15. srpna 2004 15:10 Vojtech Pavlik napsal(a):
> On Sun, Aug 15, 2004 at 12:28:41PM +0200, Marcel Holtmann wrote:
> > Hi Michal,
> >
> > > and when pressed this is sent into dmesg:
> > >
> > > Eigene Dateien
> > > keyboard.c: can't emulate rawmode for keycode 253
> > > keyboard.c: can't emulate rawmode for keycode 253
> > > Eigene Bilder
> > > keyboard.c: can't emulate rawmode for keycode 254
> > > keyboard.c: can't emulate rawmode for keycode 254
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


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
