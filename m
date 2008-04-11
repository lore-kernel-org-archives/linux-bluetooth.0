Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1207672137.3396.52.camel@cookie.hadess.net>
References: <1207446435.26353.1.camel@californication>
	<1207672137.3396.52.camel@cookie.hadess.net>
Date: Fri, 11 Apr 2008 12:31:46 +0200
Message-Id: <1207909906.1098.2.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release of bluez-gnome-0.26
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

Hi Bastien,

> Another patch. This one gives you a better error message when you have a
> Palm device, as well as changing the "ETA" message to match that of
> Nautilus.

the patch has been committed, but in a total different form. Can I just
remind you to comply with the coding style (aka whitespaces) and please
don't do such complex code.

if () if () if () makes my brain hurt. I prefer if (!) return etc. A
good rule is that if a line hits the 80 characters marker, then the code
is too complex.

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
