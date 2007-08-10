Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <fb2ac3c90708101030u6a29eb77n557f023c6329beb9@mail.gmail.com>
Date: Fri, 10 Aug 2007 11:30:39 -0600
From: "Andrew Jorgensen" <andrew.jorgensen@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <fb2ac3c90708101001v230e5f19j5f71a0213e163c89@mail.gmail.com>
MIME-Version: 1.0
References: <fb2ac3c90708092110y3a4ffff1ka8d5ea1ebdd17e32@mail.gmail.com>
	<1186736578.20129.202.camel@violet>
	<fb2ac3c90708101001v230e5f19j5f71a0213e163c89@mail.gmail.com>
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

On 8/10/07, Andrew Jorgensen <andrew.jorgensen@gmail.com> wrote:
> I'm trying to help Ubuntu's next release not have a prominent new
> feature that doesn't work out of the box.  They aren't including
> gnome-vfs-obexftp by default in gutsy (maybe they'll change their
> mind?) so it looks a bit ugly when you get an error message saying you
> can't browse the thing bluetooth-applet says you can browse.

Apparently there's already a bug open on Launchpad:
https://bugs.launchpad.net/ubuntu/+source/bluez-gnome/+bug/131530

The reporter there got the same impression I did - that the Browse
device feature was intended to allow the user to pair or connect with
a device.  He also found it odd that only OBEX FTP was supported.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
