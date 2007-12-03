Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f84803c0712030850k5810ee43na4a13f5e74657388@mail.gmail.com>
References: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
	<1196699122.12292.113.camel@violet>
	<5f84803c0712030850k5810ee43na4a13f5e74657388@mail.gmail.com>
Date: Mon, 03 Dec 2007 17:59:41 +0100
Message-Id: <1196701181.12292.128.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] [RESEND] make bluez GNOME UIs singletons
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

Hi Chris,

>         
>         I meant to look into it, but never got around it. Some small
>         comments
>         about it. Don't make the applet a singleton. That is totally
>         unneeded
>         since the applet will be loaded at login.
> 
> I still think it should be a singleton.  You wouldn't ever want two
> applets running unless you're testing, and we have the singleton flags
> for that.  I don't think this hurts anything. 

I am okay with that. Please abstract everything into common/. And don't
forget to document it in the manual pages.

>         For the "Present" method. Don't use the D-Bus low-level calls.
>         It should 
>         be all dbus-glib. Which means we have to abstract that into an
>         object. I
>         don't know if there is a well defined way for this. If it is,
>         it might
>         be good to use that. If not, then propose something for
>         freedesktop.org.
> 
> I thought about doing this, but it seems like overkill to define a
> GObject to just expose one method.  GObject isn't exactly terse
> either.

In a simple way you can use GObject for it. It is better than using the
low-level D-Bus calls.

>         And we should probably have some generic methods inside
>         common/ instead
>         of doing it again in every program.
>         
>         Please follow the kernel coding style. I know it is odd for a
>         GTK
>         application, but it makes it a lot easier for me. 
> 
> Which parts of the patch violate the kernel coding style?  The
> function parameter spacing?

Mainly the spacing.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
