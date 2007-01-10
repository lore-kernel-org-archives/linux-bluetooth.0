Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 10 Jan 2007 09:07:45 +0100
From: "Glen Rolle" <g.len@gmx.de>
In-Reply-To: <20070108233813.5588d305@localhost>
Message-ID: <20070110080745.22520@gmx.net>
MIME-Version: 1.0
References: <20070108221038.266790@gmx.net> <20070108233813.5588d305@localhost>
To: Tim Hentenaar <tim@hentenaar.com>
Cc: bluez-devel@lists.sourceforge.net, tjalfefisk@gmail.com, patrik@yes.nu
Subject: Re: [Bluez-devel] [Patch Update] Re: Logitech DiNovo Media LCD
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> > - I have extended the interface for the lcd and added following
> > functions. I wanted to have more atomic control over the LCD.
> > =

> > -- WriteLine (line_number, scroll_mode, string)
> > --- Write only a single line, so that you can set content and scroll
> > mode separately for each line.
> =

> IMO, it's easier to have the driver auto-determine the scroll mode. =

> This saves the programmer from having to deal with splitting up the
> text.
> =

Yes, but then we are missing the scroll mode 0x20 which scrolls one line ch=
aracter per character (like the html marque).
Maybe we should include a function like WriteScrollingLine, that sets this =
scrolling mode. The autodetection scrolls only buffer-wise.

> > =

> > -- SetScreenMode (mode)
> > --- An easy way to switch between the 3-line display (0) and the
> > clock display (1).
> =

> You can switch back to the clock display by pressing "Clear Screen",
> and to the "3-line" mode by writing text. (This is so that alerts
> persist until the user presses "Clear Screen.")
> =

This function is to allow a programme a more "atomic" control over the disp=
lay.

> > =

> > -- SendRawData (array_of_integers)
> > --- Mainly for testing and debugging purpose, so that you can send
> > commands to the LCD without having to recompile fakehid all the time.
> > The raw data starts with 0x10 and 0x11 resp. The 0xA2 will be send
> > automaticallay.
> =

> This could be useful under certain circumstances, however, there's
> really no need at this point to send raw data to the mediapad, because
> the functionality is quite complete (With the exception of the Nav
> indicator and the Calculator -> Clipboard, of course (I know how it
> works sending the data back (I've got code in place in the driver), but
> I can't seem to isolate the init packet.)) =

> =

I use this function for testing purpose e. g. to evaluate what effect the c=
ommand 0x83 0x00 0x00 0x00 has. (I still don't know ...). We can offer such=
 a function for advanced users, though it is not essential.

> > It might be useful to split some of your funtions e. g. the WriteText
> > into a "initScreen" part and the text display. (This would remove the
> > flashing display when sending new text with WriteText.)
> =

> If you look at the code that writes the text out to the display, it
> handles the scrolling of the display automatically (for simplicity.)
> =

What I noticed between two sequential calls to WriteText was a short flasin=
g on the display. The cause is the command 0x12 0x01 0x01 0x01 which hides =
all three lines. We could avoid this flashing by separating the screen init=
ializing and the actual text writing e. g.:
InitScreen:
  0x80 0x00 0x00 0x00
  0x12 0x01 0x01 0x01
  0x81 0x00 0x00 0x00
WriteTextOnly:
  0x20 ...
  0x21 ...
  ...
  0x28 ...
  0x12 display modes

> I do concur that a WriteLine() function would be helpful, so I've added t=
he following (based on your suggestions):
> =

>     WriteLine(lineno, text) =

>     WriteLineBin(lineno, chars)
>     WriteTextBin(lineno, chars)
>
I had a look at the patch and think we should do some minor changes:
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},  ## Should be 0x=
80 instead of 0x81
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x10, 0x10, 0x10 }, 8},  ## This would c=
hange the scroll mode on all three lines. Using 0x00 instead of 0x10 does n=
ot change the display mode of the othr lines.
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20=
, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20=
, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x22, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20=
, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x10, 0x10, 0x10 }, 8},  ## same as abov=
e.
+	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},  ## Is this line=
 really required? What does it do?

 =

> > - hidd is not always initialized correctly. You can connect the
> > MediaPad on two different ways. First is to run hidd --search and
> > press the connect button on the MediaPad. This is a bit ugly compared
> > to the second method but correctly initializes your DBus-interface
> > (and does not show the NAV-led) The second method is to just press a
> > key on the MediaPad. It will connect and will be visible to hidd, but
> > the connection method in hidd is not run and therefore the
> > DBUS-interface is not available. (But the NAV-led works) I think this
> > is not a problem with the work you done, but maybe it helps us to
> > improve the usage of the MediaPad.
> =

> The "second method" is because hidd passes the connection into the
> kernel's bluetooth HID driver (which should really be in userspace,
> IMHO) - and thus is "never heard from again."
>
That's bad. Any chance that we can change this behaviour? I would be much m=
ore user-friendly not to have to call hidd manually. Marcel?
 =

> Pardon my nit-picking, however, I did notice a couple bugs in the
> patch you attached: =

That's why I did not send it to the list directly. :-)

Kind regards,

Glen.
-- =

Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! =

Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
