Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1209541359.31036.35.camel@pancake>
References: <1209541359.31036.35.camel@pancake>
Date: Fri, 09 May 2008 14:50:00 +0200
Message-Id: <1210337400.28002.40.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-gnome and OBEX DBus names
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

Hi Florian,

> I'm running bluez-gnome 0.26 and obex-data-server 0.3 from Gentoo. My
> Bluetooth setup is running fine, with the exception of OBEX reception.
> When I start the bluetooth-applet from a shell, I get the warning
> "Bluetooth OBEX start failed: Invalid path". A bit of dbus-monitoring
> shows that this error comes from the OBEX server:
> 
> method call sender=:1.96 -> dest=org.openobex
> path=/org/openobex/server1; interface=org.openobex.Server; member=Start
>    string ""
>    boolean true
>    boolean true
> 
> error sender=:1.94 -> dest=:1.96
> error_name=org.openobex.Error.InvalidArguments reply_serial=16
>    string "Invalid path"
> 
> A look in ods-server.c shows that it's testing for the first parameter
> of the method call to be an existing directory, but the bluetooth-applet
> is passing an empty string.. and this is because the applet uses
> g_get_user_special_dir(G_USER_DIRECTORY_PUBLIC_SHARE) and
> g_get_user_special_dir(G_USER_DIRECTORY_DOWNLOAD) to retrieve the
> directory names.
> 
> So, I now have one suggestion - see the attached patch, two small error
> checks to make debugging this _much_ easier - and one question:

the patch has been applied. Thanks.

> how is the average user (yes, there are such things now ;-) expected to
> know how to set these *!$%& directories? I needed 20 minutes of glib
> source diving to find the relevant code - why doesn't Gnome, e.g., set
> this automatically?

Actually GNOME should do this. However if you kept upgrading GNOME over
time from an old installation, it might have missed it. Don't ask me
details, but for a clean installation it is set.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
