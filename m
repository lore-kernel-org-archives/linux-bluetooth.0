Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185318541.3641.195.camel@cookie.hadess.net>
References: <1185293793.3641.129.camel@cookie.hadess.net>
	<1185311688.7111.72.camel@violet>
	<1185315051.3641.189.camel@cookie.hadess.net>
	<1185318541.3641.195.camel@cookie.hadess.net>
Date: Wed, 25 Jul 2007 08:51:04 +0200
Message-Id: <1185346264.7111.87.camel@violet>
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

> > > However this includes that we have to monitor if the default adapter
> > > changes or one adapter gets removed while being in the adapter selector
> > > widget or device selector widget.
> > 
> > Fair enough, I knew this would be a sticky point. I'm trying to fix it
> > up so that we use the default adapter by default with "NULL" passed as
> > the adapter.
> 
> Here goes. This should correctly kill the disco on the old default
> adapter and re-enable it on the new default adapter, when the default
> adapter changes.
> 
> If the default adapter changes but we didn't start a discovery using the
> default adapter, then it's up to the application to start/stop it
> anyway.
> 
> It will also make all the functions taking an adapter use the default
> adapter when NULL is passed.
> 
> We should also kill discovery on all the devices when the object goes
> away, and move the treestore, and dbus connection to the class, rather
> than using statics. But that's for another patch.

when the object goes away, then we can disconnect from the system bus
and kill our D-Bus connection. This means that hcid will detect that our
application is no longer in control and cancel everything that is still
running. Only exception is periodic inquiry, but that is meant to be
like it and we don't have to worry.

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
