Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Implementing the PIN helper support
Message-ID: <20060221093118.GA10267@localhost.localdomain>
References: <1140468298.7047.52.camel@localhost> <20060220211402.GA6466@localhost.localdomain> <1140471085.7047.63.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1140471085.7047.63.camel@localhost>
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
Date: Tue, 21 Feb 2006 11:31:18 +0200

Hi Marcel,

On Mon, Feb 20, 2006, Marcel Holtmann wrote:
> my current idea is to have a default handler that the applications have
> to register over org.bluez.Manager and that they can have multiple other
> PIN handlers registered via the org.bluez.Device interface for specific
> devices. While the default handler is permanent, all other PIN handlers
> may expire and get removed automatically.

I think you'll still need a way to unregister the default handler, when
e.g. a user logs out from his session (so the next user that logs in can
register his own default handler).

Using org.bluez.Manager interface for registering the default handler
seems to me extending too much its purpose compared to hald where we
copied it from. The only purpose of the manager interface there is to
allow local device discovery. Placing the default handler registration
method at the interface org.bluez.Device (or org.bluez.Device.PinAgent)
and object path /org/bluez/Device should be enough in my opinion. If you
want to register a handler only for a specific local device then the
exact path for that device (e.g. /org/bluez/Device/hci0) could be used.

> Do we really only need the object path? I really like to get the default
> handler thing implemented very soon.

For the handler registration the object path should be enough. However
we should probably rethink the org.bluez.PinAgent interface which
currently consists of only one method: PinRequest.

The PinRequest method currently takes two arguments: remote device
address and a boolean indicating whether the connection is incomming or
outgoing. A third parameter should probably be added for object path of
the local device, since that information could be used for e.g. querying
the name of the remote device.

Johan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
