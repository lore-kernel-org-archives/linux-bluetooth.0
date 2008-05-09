Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1210337400.28002.40.camel@violet.holtmann.net>
References: <1209541359.31036.35.camel@pancake>
	<1210337400.28002.40.camel@violet.holtmann.net>
Date: Fri, 09 May 2008 14:19:19 +0100
Message-Id: <1210339159.3070.35.camel@cookie.hadess.net>
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

On Fri, 2008-05-09 at 14:50 +0200, Marcel Holtmann wrote:
<snip>
> > how is the average user (yes, there are such things now ;-) expected to
> > know how to set these *!$%& directories? I needed 20 minutes of glib
> > source diving to find the relevant code - why doesn't Gnome, e.g., set
> > this automatically?
> 
> Actually GNOME should do this. However if you kept upgrading GNOME over
> time from an old installation, it might have missed it. Don't ask me
> details, but for a clean installation it is set.

Not GNOME actually, but xdg-user-dirs[1]. A decent installation should
have this running in the user's session, and Nautilus allows you to
rename/move the directories and keep the configuration up-to-date as
expected.

[1]: http://freedesktop.org/wiki/Software/xdg-user-dirs


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
