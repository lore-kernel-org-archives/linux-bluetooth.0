Return-Path: <Johan.Hedberg@nokia.com>
Date: Wed, 16 Jun 2004 15:05:14 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Message-ID: <20040616120514.GA8454@kone>
References: <20040616112702.GA898@kone> <1087385828.4309.3.camel@pegasus> <20040616115718.GA8420@kone>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040616115718.GA8420@kone>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Jun 16, 2004, Johan Hedberg wrote:
> Also, if new errors are added in the future it is probably better to
> check for the general case here: dbus_message_get_type().

Actually you might even now get some DBUS_ERROR_* from
dbus_pending_call_get_reply (for example DBUS_ERROR_NO_REPLY), so
the dbus_message_get_type() == ERROR test is needed anyway.

Johan
