Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185356252.3641.236.camel@cookie.hadess.net>
References: <1185294455.3641.141.camel@cookie.hadess.net>
	<1185350671.7111.108.camel@violet>
	<1185351259.3641.228.camel@cookie.hadess.net>
	<1185351983.7111.114.camel@violet>
	<1185356252.3641.236.camel@cookie.hadess.net>
Date: Wed, 25 Jul 2007 12:34:00 +0200
Message-Id: <1185359640.7111.118.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] add device selector widget
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

> Here's an updated patch to common/, with the new widget name. I added
> the bluetooth- to the filenames, as it's the GNOME way to show the whole
> namespace in the header filename.

the patch is in the CVS now. Thanks.

> I think we'll need some changes to the client for when there's no
> default adapter (ie. no adapter) and we show the widget, then plug in an
> adapter. Any ideas how you would want that 

If the adapter gets removed we should make the widget insensitive. For
me that looks like the only sane way to do it. We can send a signal to
inform the user and then they can do whatever they think is right.
However any selection itself becomes invalid at that point.

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
