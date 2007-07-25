Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185294455.3641.141.camel@cookie.hadess.net>
References: <1185294455.3641.141.camel@cookie.hadess.net>
Date: Wed, 25 Jul 2007 10:04:31 +0200
Message-Id: <1185350671.7111.108.camel@violet>
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

> It's a first draft of the device selector widget, which I'd like to use
> in the applet for gnome-vfs obexftp browsing, and in the wizard. Tadas
> can probably use it for the obex sending program as well.
> 
> The test program shows how to use it. The API is dead simple.
> 
> I also want to add a "Search" button, to restart a discovery, and combo
> boxes at the top of it to filter the type/class of device (known,
> recently used, recently discovered, and printer/phone/etc.).
> 
> Big patch, but not really any other way to do it...

I really do like it and it is a good idea. However we need to change
this a little bit. What we need is multiple things:

BluetoothAdapterChooserWidget

This widget should make it possible to choose an adapter. It can be
either a combo box or a tree view depending on some property.

BluetoothAdapterChooserDialog

Uses the BluetoothAdapterChooserWidget and creates a dialog around.

BluetoothDeviceChooserWidget

Will present devices in range. Has a scan button and other possible
things to tweak it. And actually we should include maybe a widget to
choose the adapter if multiple are available and a property says that is
what we want.

BluetoothDeviceChooserDialog

Use the BluetoothDeviceWidget in a dialog and make it useful for simple
applications.

Mainly all of these four should be modeled along with the GtkFileChooser
stuff and work kinda similar.

Also having some kind of BluetoothDeviceButton that launches a dialog if
needed would be nice.

To shorten the widget names. We might better use _not_ the "Chooser"
word since it looks like Gtk compat stuff because the other name was
already taken by an older widget.

So BluetoothDeviceButton, BluetoothDeviceSelection and
BluetoothDeviceSelectionDialog might be appropriate. What do you think?

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
