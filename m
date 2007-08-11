Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <fb2ac3c90708101030u6a29eb77n557f023c6329beb9@mail.gmail.com>
References: <fb2ac3c90708092110y3a4ffff1ka8d5ea1ebdd17e32@mail.gmail.com>
	<1186736578.20129.202.camel@violet>
	<fb2ac3c90708101001v230e5f19j5f71a0213e163c89@mail.gmail.com>
	<fb2ac3c90708101030u6a29eb77n557f023c6329beb9@mail.gmail.com>
Date: Sat, 11 Aug 2007 20:04:09 +0200
Message-Id: <1186855449.6698.14.camel@violet>
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

Hi Andrew,

> > I'm trying to help Ubuntu's next release not have a prominent new
> > feature that doesn't work out of the box.  They aren't including
> > gnome-vfs-obexftp by default in gutsy (maybe they'll change their
> > mind?) so it looks a bit ugly when you get an error message saying you
> > can't browse the thing bluetooth-applet says you can browse.
> 
> Apparently there's already a bug open on Launchpad:
> https://bugs.launchpad.net/ubuntu/+source/bluez-gnome/+bug/131530
> 
> The reporter there got the same impression I did - that the Browse
> device feature was intended to allow the user to pair or connect with
> a device.  He also found it odd that only OBEX FTP was supported.

actually once we add the "Setup new device" menu entry to that menu then
it should become more clearer. This then will call the wizard.

The missing gnome-vfs-obexftp issue is because it is part of universe
and not Gutsy core. That is up to the Ubuntu guys to figure out. I think
the main problem might be that we don't have a Debian package for it. So
time for someone to maintain a gnome-vfs-obexftp Debian package and so
it will find its way into Ubuntu core.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
