Return-Path: <cyrus@holtmann.org>
Message-ID: <f21e7dc80802050621n28934acay903394cbc6152413@mail.gmail.com>
Date: Tue, 5 Feb 2008 16:21:37 +0200
From: "Choi Sonim" <choisonim@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202220823.15090.88.camel@violet>
MIME-Version: 1.0
References: <f21e7dc80802042255w4a688071h2678817a45b920fa@mail.gmail.com>
	<1202220823.15090.88.camel@violet>
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

Hi Marcel,

On Feb 5, 2008 4:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> We use glib for the mainloop, the XML parser and other things.

Does glib impose a big memory footprint on the system or is it ok for
embedded systems ?

> We will have hard dependencies on dbus and glib (not dbus-glib).

Maybe I'm confusing terms - but don't you use dbus' glib binding
(isn't that dbus-glib?) ?

If not - what do you use instead ? directly the libdus C lowlevel library ?
or some other binding ?
IOW - is it possible to use glib binding without dbus-glib ?

thank you very much - you are very helpful !
choi

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
