Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <f21e7dc80802042255w4a688071h2678817a45b920fa@mail.gmail.com>
References: <f21e7dc80802042255w4a688071h2678817a45b920fa@mail.gmail.com>
Date: Tue, 05 Feb 2008 15:13:43 +0100
Message-Id: <1202220823.15090.88.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez+dbus: why glib binding
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

Hi Choi,

> i am intersted to understand why did bluez daemon choose to use the
> glib binding of dbus.

the bluez-utils don't depend on dbus-glib. It is an option that we use
for testing and nothing more.

> i understand it is easier than the low level c library.
> 
> but - doesn't glib impose a new depedanbility ?
> 
> and - does the bluez daemon use glib for something other than dbus ?

We use glib for the mainloop, the XML parser and other things. However
currently you can configure it to use the included eglib which means you
don't have to depend on glib.

However the option to use eglib will go away with the 4.x series. We
will have hard dependencies on dbus and glib (not dbus-glib).

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
