Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185311532.3641.178.camel@cookie.hadess.net>
References: <1185293793.3641.129.camel@cookie.hadess.net>
	<1185294005.3641.132.camel@cookie.hadess.net>
	<1185310470.7111.64.camel@violet>
	<1185311532.3641.178.camel@cookie.hadess.net>
Date: Tue, 24 Jul 2007 23:26:23 +0200
Message-Id: <1185312383.7111.81.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Make BluetoothClient work on all adapters
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

> > > > With this patch, we can now pass a NULL as the adapter to work with all
> > > > the adapters. This is for use in the upcoming patch for the selector
> > > > widget.
> > > 
> > > And a tiny patch to fix the test-client's compilation.
> > 
> > what is wrong with providing a convenience wrapper around the GObject
> > unref function?
> 
> unref isn't destroy.
> 
> Destroy, as used in GTK+ for widgets (it's not used in glib) means you
> destroy the widget, drop the refcount to 0, clean up, free the memory,
> etc.
> 
> Unref means you reduce the refcount by 1. If you have > 1 reference
> before running the command, then nothing happens apart from the refcount
> being updates.
> 
> Wrapping a _destroy() function to call _unref() means you're mixing two
> semantics. When you call _destroy() the object isn't destroyed, it's
> refcount is reduced...

okay. Point taken. I removed the _destroy() function form the code, but
I didn't apply the rest of the patch.

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
