Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1153857069.6181.26.camel@anselm.venusberg.augustinnetz.de>
References: <1153857069.6181.26.camel@anselm.venusberg.augustinnetz.de>
Date: Wed, 26 Jul 2006 18:48:29 +0200
Message-Id: <1153932509.13885.74.camel@panic>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HIDclient: Using a Bluez PC as virtual
	Bluetooth	keyboard and mouse
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

Cool, but do I read right - it only supports REPORT mode? =


My HID keyboard (http://www.mulliner.org/bluetooth/xkbdbthid.php) so far
only supports BOOT mode... I allways wanted to implement report mode.


Collin

On Tue, 2006-07-25 at 21:51 +0200, Anselm Martin Hoffmeister wrote:
> Hello list,
> =

> with this posting I publish a software that mimicks a Bluetooth HID
> (keyboard and mouse combo device) on a Linux PC. Thus you can
> remote-control other Bluez-equipped PCs, Widcomm-stack equipped windows
> boxes, and basically any machine that knows how to talk to Bluetooth
> keyboards in non-boot-protocol mode.
> =

> Source code is GNU GPLd, and can be found on
> http://www.hoffmeister-online.de/bluez/hidclient-20060725.tar.bz2
> =

> Short instructions (for root users):
> Download the file and unpack it
> # wget -q
> http://www.hoffmeister-online.de/bluez/hidclient-20060725.tar.bz2
> # tar -xjvf hidclient-20060725.tar.bz2
> =

> Run make and copy the hid-sdp-record.bin into /etc/bluetooth/
> =

> Make sure bluez is installed (else the "make" will most probably fail
> anyway) and the SDP daemon is running (which it should by default).
> =

> Change to a Linux textmode console (e.g. Ctrl+Alt+F1) and run
> ./hidclient
> from there. Then, startup the other machine and discover the "HID"
> service available on your virtual-HID box. Connect to it.
> =

> Move the mouse, touch the keyboard, enjoy.
> =

> Hint: The bluetooth connection can be interrupted by pressing "Pause",
> the program can be aborted altogether with LeftCtrl+LeftAlt+Pause
> =

> Beware, all keyboard and mouse input will simultaneously be read by your
> virtual-HID computer as well! That's why running hidclient from a
> textmode console is a good idea.
> =

> Code history: Developped as a practical work during the "Networks"
> course at Rheinische Friedrich-Wilhelms-Universit=E4t, Bonn, Germany in
> 2004/2005 for the Nokia-supported, GPLd, Affix Bluetooth stack.
> Ported in July/2006 to bluez, several code cleanups and improvements.
> =

> Questions welcome.
> =

> Regards
> Anselm
> =

> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Help Microsoft fight software piracy: Give Linux to a friend today!


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
