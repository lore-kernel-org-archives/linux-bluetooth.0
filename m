Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185461376.3641.292.camel@cookie.hadess.net>
References: <1185459203.3641.287.camel@cookie.hadess.net>
	<1185459710.3641.289.camel@cookie.hadess.net>
	<1185461376.3641.292.camel@cookie.hadess.net>
Date: Thu, 26 Jul 2007 21:41:49 +0200
Message-Id: <1185478909.7111.200.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Show the trusted icon in the treeview
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

> > > I added a property to be able to show/hide a trusted (bonded) icon in
> > > the list view, it's shown by default.
> > > 
> > > There's also a one-liner to avoid changing the address rather than the
> > > name, when a device doesn't have a name (ie. it still displayed
> > > 00:00:00:00:00:00 rather than 00-00-00-00-00-00, but changed the address
> > > to that).
> > 
> > Johan mentioned that bonded != trusted, and the existing code didn't
> > make the difference. I'll fix that up.
> 
> Fixes the above, and renames the COLUMN_TRUSTED to COLUMN_BONDED, as
> that column includes the bonded status, not the trusted status.

patch has been applied. Thanks.

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
