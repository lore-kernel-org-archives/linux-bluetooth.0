Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1193358579.25405.158.camel@cookie.hadess.net>
References: <5f84803c0710251220m73a0b7va39bd0c46cfaabd9@mail.gmail.com>
	<1193352257.6184.282.camel@violet>
	<1193358579.25405.158.camel@cookie.hadess.net>
Date: Wed, 31 Oct 2007 17:33:57 +0100
Message-Id: <1193848437.32459.64.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Add an ellipsis to
	the	preferences	menu	item
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

> > > Since the Preferences menu entry in the applet opens a new window it
> > > should probably have an ellipsis in the label.  Attached is a trivial
> > > patch to add this.
> > 
> > what does the HIG recommend for applet menus. I wanna follow the HIG.
> > Currently I simply did what all other applets do that I have running.
> 
> This one is a toss-up between what's right, and what GTK+ implements. It
> doesn't have separate strings for menus, so you don't get the ellipsis.
> 
> I'm sure there's a GTK+ bug opened somewhere about "doing the right
> thing" in the case of stock items.
> 
> So it's really up to you. Personally, I'd stick with the stock item,
> unless you have a wide-ranging amount of translations (which you'd get
> if you moved bluez-gnome to GNOME SVN, hint hint :)

I stick with the stock item. Makes stuff simpler.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
