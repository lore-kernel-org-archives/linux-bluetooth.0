Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <001001c755ae$d755e6b0$c301a8c0@Bahubali>
References: <001001c755ae$d755e6b0$c301a8c0@Bahubali>
Date: Wed, 21 Feb 2007 13:04:34 +0100
Message-Id: <1172059474.7403.3.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] dbus-glib-1 was not found
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Vikram,

> I am trying to Build and run the test programs from utils. for that I
> carried out following steps.
>  
> 1) Run ./configure --prefix=/usr
> and make && make install from ..\BlueZ\libs\bluez-libs-3.9 and
> successfully installed BlueZ.
>  
> 2)Successfully installed D-Bus 1.0.2 from www.freedesktop.com.
>  
> 3) run ./configure --prefix=/usr --mandir=/usr/share/man \
>   --sysconfdir=/etc --localstatedir=/var --libexecdir=/lib
> from ..\BlueZ\utils\bluez-utils-3.9
>  
> but I am getting following errors.
>  
> > Package dbus-glib-1 was not found
> > package openobex was not found
> > Package opensync-1.0 was not found
> > Package libusb not found

that is fine. You can ignore these packages. The configure script will
automatically disable certain tools that depend on these.
 
> 4) run make && make istall from ..\BlueZ\utils\bluez-utils-3.9. and
> got following error.
> "undefined referance to XML_Stopparser"

I need the full error message, but that one is strange. I never saw that
one. What happens if you call configure with --enable-glib.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
