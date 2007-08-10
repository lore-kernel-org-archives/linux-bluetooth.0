Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Date: Fri, 10 Aug 2007 13:45:54 +0100
Message-ID: <f9hmm2$e7i$1@sea.gmane.org>
References: <fb2ac3c90708092110y3a4ffff1ka8d5ea1ebdd17e32@mail.gmail.com>
	<1186736578.20129.202.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluetooth-applet and gnome-vfs-obexftp
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:

>> Version 0.10 of bluez-gnome added support for "browsing devices" - a
>> much needed feature by any account.  What I'm not thrilled about is
>> that it was written to support gnome-vfs-obexftp.
>> 
>> Don't get me wrong - gnome-vfs-obexftp is awesome, but
>> bluetooth-applet is the wrong entry point for it.  The applet should
>> allow you to see what devices are around you and allow you to initiate
>> a bonding with them but the assumption that you want to browse OBEX is
>> bad.
> 
> it is exactly the right entry point. You might wanna compare how MacOS X
> handles it. The actual bonding will be done automatically. You are the
> client and so we can rely on the actual FTP server to ask for a bonding
> and not wasting time to try to pair a public FTP repository that has no
> key anyway.

What I find odd is that it suggests bluez is somehow connected to gnome.
As a KDE user I find it strange that I have to use a gnome application.
This doesn't offend me, but I assumed - wrongly as it happened -
that installing bluez-gnome would require 
a whole slew of gnome applications.

As far as I can see, one has to have bluez-gnome just to establish pairing.
Is that right?
I don't understand why you can't just put the code in a file.


-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
