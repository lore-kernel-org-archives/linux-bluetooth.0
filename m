Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185293793.3641.129.camel@cookie.hadess.net>
References: <1185293793.3641.129.camel@cookie.hadess.net>
Date: Tue, 24 Jul 2007 23:14:48 +0200
Message-Id: <1185311688.7111.72.camel@violet>
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

> With this patch, we can now pass a NULL as the adapter to work with all
> the adapters. This is for use in the upcoming patch for the selector
> widget.

I don't like it. We should not wildly use all attached adapters. Passing
a NULL to the client creation should use the default adapter.

Actually in case of multiple adapters we need to provide one extra step
to let the user select the appropriate adapter.

Main reason, why I don't wanna start an inquiry on all adapters is that
it can happen that you see a remote device with one adapter, but then
the actual connection or device discovery is done via another one. That
is not good. We should always use the default adapter and if (and only
if) more adapters are present, then present a way to select a different
adapter.

However this includes that we have to monitor if the default adapter
changes or one adapter gets removed while being in the adapter selector
widget or device selector widget.

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
