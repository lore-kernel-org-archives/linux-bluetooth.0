Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185350671.7111.108.camel@violet>
References: <1185294455.3641.141.camel@cookie.hadess.net>
	<1185350671.7111.108.camel@violet>
Date: Wed, 25 Jul 2007 09:14:19 +0100
Message-Id: <1185351259.3641.228.camel@cookie.hadess.net>
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

On Wed, 2007-07-25 at 10:04 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > It's a first draft of the device selector widget, which I'd like to use
> > in the applet for gnome-vfs obexftp browsing, and in the wizard. Tadas
> > can probably use it for the obex sending program as well.
> > 
> > The test program shows how to use it. The API is dead simple.
> > 
> > I also want to add a "Search" button, to restart a discovery, and combo
> > boxes at the top of it to filter the type/class of device (known,
> > recently used, recently discovered, and printer/phone/etc.).
> > 
> > Big patch, but not really any other way to do it...
> 
> I really do like it and it is a good idea. However we need to change
> this a little bit. What we need is multiple things:
> 
> BluetoothAdapterChooserWidget
> 
> This widget should make it possible to choose an adapter. It can be
> either a combo box or a tree view depending on some property.

In which cases would this be used?

> BluetoothAdapterChooserDialog
> 
> Uses the BluetoothAdapterChooserWidget and creates a dialog around.

Again, which use cases? Also, why would we need a dialogue (see below
for the reasoning).

> BluetoothDeviceChooserWidget
> 
> Will present devices in range. Has a scan button and other possible
> things to tweak it. And actually we should include maybe a widget to
> choose the adapter if multiple are available and a property says that is
> what we want.

That sounds fair, I already wanted the user to be able to show/hide some
of the filter drop-downs, which could/would include the types of devices
as mentioned, as well as the adapter on which to work, although I can't
think of many cases where we would want to show anything but the default
adapter.

> BluetoothDeviceChooserDialog
> 
> Use the BluetoothDeviceWidget in a dialog and make it useful for simple
> applications.
> 
> Mainly all of these four should be modeled along with the GtkFileChooser
> stuff and work kinda similar.

I think it's a bit too much work trying to cater for all the uses one
could have of a dialogue, and the amount of code isn't that great to
create the widget ourselves (see example in the test selector, or the
browse device item).

I think a good selector widget that can be inserted in a dialogue would
be better.

> Also having some kind of BluetoothDeviceButton that launches a dialog if
> needed would be nice.

I have a widget like that in gnome-phone-manager, see the prefs
screenshot:
http://live.gnome.org/PhoneManager

It uses libbtctl and gnome-bluetooth widgets right now, but could be
ported easily.

> To shorten the widget names. We might better use _not_ the "Chooser"
> word since it looks like Gtk compat stuff because the other name was
> already taken by an older widget.

fair enough.

> So BluetoothDeviceButton, BluetoothDeviceSelection and
> BluetoothDeviceSelectionDialog might be appropriate. What do you think?

I'm not sure about the dialogue widgets, as I said, but the button and
the chooser widget would be very useful. Not convinced about the adapter
selector either though.

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
