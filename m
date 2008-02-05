Return-Path: <cyrus@holtmann.org>
Message-ID: <f21e7dc80802050641pe208e9ew8eb686088cbf71d5@mail.gmail.com>
Date: Tue, 5 Feb 2008 16:41:30 +0200
From: "Choi Sonim" <choisonim@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202221797.15090.93.camel@violet>
MIME-Version: 1.0
References: <f21e7dc80802042255w4a688071h2678817a45b920fa@mail.gmail.com>
	<1202220823.15090.88.camel@violet>
	<f21e7dc80802050621n28934acay903394cbc6152413@mail.gmail.com>
	<1202221797.15090.93.camel@violet>
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

On Feb 5, 2008 4:29 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > If not - what do you use instead ? directly the libdus C lowlevel library ?
> > or some other binding ?
> > IOW - is it possible to use glib binding without dbus-glib ?
>
> You don't get it. The dbus-glib bindings are an integration of dbus into
> the GObject model (libgobject). We don't use that. Yes, we use glib, but
> not gobject and yes, we use dbus (low-level libdbus).

Ok, I think I understand.
In bluez-utils, which is a d-bus server, you use directly the libdbus library,
just like dbus-daemon does. So the glib is required for completely
different reasons - not
for using dbus. am I correct ?

thank you again very much
choi
>
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
