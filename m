Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185318541.3641.195.camel@cookie.hadess.net>
References: <1185293793.3641.129.camel@cookie.hadess.net>
	<1185311688.7111.72.camel@violet>
	<1185315051.3641.189.camel@cookie.hadess.net>
	<1185318541.3641.195.camel@cookie.hadess.net>
Date: Wed, 25 Jul 2007 09:04:28 +0200
Message-Id: <1185347068.7111.91.camel@violet>
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

you patch is wrong. You are messing up a DBusConnection object with the
BluetoothClient object in the callbacks of the DefaultAdapterChanged
signal.

Actually I also don't like this way, we should store the default path
globally since that is what really counts. The tree storing all
information should be fully valid as long as we have an instance of the
BluetoothClient object and it can store the information about the
default adapter for us.

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
