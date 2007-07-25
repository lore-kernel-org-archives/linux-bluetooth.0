Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185351259.3641.228.camel@cookie.hadess.net>
References: <1185294455.3641.141.camel@cookie.hadess.net>
	<1185350671.7111.108.camel@violet>
	<1185351259.3641.228.camel@cookie.hadess.net>
Date: Wed, 25 Jul 2007 10:26:22 +0200
Message-Id: <1185351983.7111.114.camel@violet>
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

> > To shorten the widget names. We might better use _not_ the "Chooser"
> > word since it looks like Gtk compat stuff because the other name was
> > already taken by an older widget.
> 
> fair enough.
> 
> > So BluetoothDeviceButton, BluetoothDeviceSelection and
> > BluetoothDeviceSelectionDialog might be appropriate. What do you think?
> 
> I'm not sure about the dialogue widgets, as I said, but the button and
> the chooser widget would be very useful. Not convinced about the adapter
> selector either though.

if we need a dialog for the button anyway, we can even provide it as a
widget. Shouldn't be that much work, right? However we can fix the
dialog part later on. The widget itself has to come first anyway.

The device selection widget is more important than an adapter selection
widget, but I see the need for it since it wraps around D-Bus and allows
us not to worry about the details. However there are use cases for the
adapter selection. I have at least one when it comes to the Bluetooth
Analyzer application and its planned live import support. And on the
other hand we have that information inside the model anyway. Only need
to export them into a combo box or tree view.

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
