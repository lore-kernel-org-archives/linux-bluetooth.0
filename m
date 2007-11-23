Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
From: "thHog" <bluez@t3i.nl>
Mime-Version: 1.0
Message-Id: <E1Ivexh-0008Tl-P5@daffy.sipo.nl>
Date: Fri, 23 Nov 2007 21:17:17 +0100
Subject: Re: [Bluez-devel] python / dbus issue
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

----- Oorspronkelijk bericht -----
From: Manuel Naranjo <manuel@aircable.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: 23-Nov-2007 13:12
Subject: Re: [Bluez-devel] python / dbus issue

> Hi,
> > I tried my first python script for accessing bluez through dbus. The
bluez
> > setup is complete and I can scan and connect bluetooth devices using
hcitool
> > and rfcomm tools. The dbus setup is working as well, the "dbus-monitor
> > --system" shows bluez messages when starting bluez.
> >   
> I think it wasn't well installed.
> > But, I tried to run the following python script (and several other
examples
> > from the internet):
> > .....
> >   
> I checked your script and it works for me. Make sure you have the latest
> version, and that's installed as it's supposed to be.
> 
> If you don't want to mess up with scripts you can check with: dbus-send
> --system --type=method_call --print-reply --dest=org.bluez /org/bluez
> org.bluez.Manager.ListAdapters
> 
> > self._connection.send_message_with_reply_and_block(message, timeout)
> > dbus.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Method
> > "ListAdapters" with signature "" on interface "org.bluez.Manager" doesn't
> > exist
> >   
> How strange you are missing the method ListAdapters which actually exists.
> 
> > On starting /etc/init.d/bluetooth, dbus-monitor --system shows:
> >
> > $ dbus-monitor --system
> > signal sender=org.freedesktop.DBus -> dest=:1.5
path=/org/freedesktop/DBus;
> > ......
> >   
> What does it show when running the script?
> 
> > What is wrong here?
> >   
> Maybe you missed something when passing the arguments to configure and
> built.

Upgrading to v3.20 fixed it. Thanks :-)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
