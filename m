Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187964427.3293.3.camel@snoogens.fab.redhat.com>
References: <1187612230.26239.79.camel@cookie.hadess.net>
	<1187958606.15402.169.camel@violet>
	<1187964427.3293.3.camel@snoogens.fab.redhat.com>
Date: Fri, 24 Aug 2007 16:27:46 +0200
Message-Id: <1187965667.15402.181.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Better startup under KDE
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

> > > This patch comes from a KDE user via:
> > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=247284
> > > 
> > > This makes the bluetooth applet startup after the panel, and disable
> > > startup notification (as it doesn't support it).
> > 
> > no idea why you wanna start a GNOME applet under KDE. They should have
> > their own stuff.
> 
> Though it's only working properly in KDE4, and this applet is still
> useful for KDE3 users with newer versions of bluez-libs and bluez-utils.

no. There is a KDE3 release that has passkey agent stuff and management
tools like KDE4 does.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
