Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040616115718.GA8420@kone>
References: <20040616112702.GA898@kone> <1087385828.4309.3.camel@pegasus>
	 <20040616115718.GA8420@kone>
Content-Type: text/plain
Message-Id: <1087388298.4309.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 16 Jun 2004 14:18:18 +0200

Hi Johan,

> The first part with the error handling is needed because
> dbus_pending_call_get_reply() may return NULL if a timeout occurs (a
> reply isn't received in time). Also, if new errors are added in the
> future it is probably better to check for the general case here:
> dbus_message_get_type().

ok, but the "message == NULL" must be moved into the D-Bus library. I
checked their source code and actually they miss a

	_dbus_return_val_if_fail (message != NULL, ???);

in their function.

> The second part (dbus_message_set_auto_activation) enables service
> activation if the PinAgent service isn't aquired by any process (i.e.
> the D-BUS daemon will execute the pin-helper program if needed).

The hcid shouldn't execute the D-Bus PIN helper. In case of a failure
with the D-Bus version it should fall back to the old one.

> Do you mean that without these changes, the pin-helper is automatically
> launched when a D-BUS message is sent by hcid to the service
> org.bluez.PinAgent? I could not get it working without the changes. What
> version of D-BUS are you using?

I use these tools:

Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  bluez-hcidump  1.5-2          Analyses Bluetooth HCI packets
ii  bluez-pin      0.23-1         Bluetooth PIN helper with D-BUS support
ii  bluez-utils    2.7-4          Bluetooth tools and daemons

And I set this in hcid.conf:

        # PIN helper
        pin_helper /usr/bin/bluez-pin;

        # D-Bus PIN helper
        dbus_pin_helper;

>>From my local .xession I start "bluez-pin --dbus &" and everything works
fine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
