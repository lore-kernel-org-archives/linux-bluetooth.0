Return-Path: <Johan.Hedberg@nokia.com>
Date: Wed, 16 Jun 2004 14:57:18 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Message-ID: <20040616115718.GA8420@kone>
References: <20040616112702.GA898@kone> <1087385828.4309.3.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087385828.4309.3.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Jun 16, 2004, Marcel Holtmann wrote:
> since I don't know very much about D-Bus, please explain your changes to
> me. Why are they needed?

The first part with the error handling is needed because
dbus_pending_call_get_reply() may return NULL if a timeout occurs (a
reply isn't received in time). Also, if new errors are added in the
future it is probably better to check for the general case here:
dbus_message_get_type().

The second part (dbus_message_set_auto_activation) enables service
activation if the PinAgent service isn't aquired by any process (i.e.
the D-BUS daemon will execute the pin-helper program if needed).

> Don't get your point here, because it works perfect on my Debian Sid.

Do you mean that without these changes, the pin-helper is automatically
launched when a D-BUS message is sent by hcid to the service
org.bluez.PinAgent? I could not get it working without the changes. What
version of D-BUS are you using?

Johan
