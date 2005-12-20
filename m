Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1135111693.26233.11.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Cleaning up the D-Bus interface
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 20 Dec 2005 21:48:13 +0100

Hi guys,

I always said that the D-Bus interface won't have to be designed after
any technical part of the Bluetooth specification and I think it is time
to change the discoverable and connectable options.

The Bluetooth specification and most devices allow you to set the device
to discoverable, but not connectable. The combination actually makes no
sense at all, because for the name resolving the remote device must be
connectable. I would propose to have a "mode" property with actually
three different states: Off, Connectable, Discoverable/Connectable. The
Off state also makes the Up/Down functions obsolete, because they are
BlueZ internal and in some embedded devices you might wanna also have
deep sleep mode support. The internals should be all hidden from the
userspace and for desktop devices the Off option could mean inquiry and
page scan disabled.

The other option that is needed is of course the device name. With the
upcoming extended inquiry the question is now if we also wanna support a
short name or if hcid/bluetoothd should shorten the name by itself if
needed.

We also have to deal with the major and minor part of the device class.
The other bits would be set by sdpd if a specific profile has been
registered.

What else needs to be configurable?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
