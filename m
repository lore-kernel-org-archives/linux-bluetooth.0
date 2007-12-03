Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
References: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
Date: Mon, 03 Dec 2007 17:25:22 +0100
Message-Id: <1196699122.12292.113.camel@violet>
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

> I'm resending this patch since I haven't gotten a response in the
> original thread in weeks.  Let me know if this looks OK.

I meant to look into it, but never got around it. Some small comments
about it. Don't make the applet a singleton. That is totally unneeded
since the applet will be loaded at login.

For the well known names use org.bluez.properties and org.bluez.wizard
and don't define constants for it. Simply use the string.

For the "Present" method. Don't use the D-Bus low-level calls. It should
be all dbus-glib. Which means we have to abstract that into an object. I
don't know if there is a well defined way for this. If it is, it might
be good to use that. If not, then propose something for freedesktop.org.

And we should probably have some generic methods inside common/ instead
of doing it again in every program.

Please follow the kernel coding style. I know it is odd for a GTK
application, but it makes it a lot easier for me.

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
