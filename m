Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Implementing the PIN helper support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060220211402.GA6466@localhost.localdomain>
References: <1140468298.7047.52.camel@localhost>
	 <20060220211402.GA6466@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1140471085.7047.63.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 20 Feb 2006 22:31:25 +0100

Hi Johan,

> > we need to think about implementing the variable PIN helper support
> > within the D-Bus API. What is the best way to implement such kind of
> > communication?
> 
> I'll first describe a couple of typical usage scenarios when this
> feature would be needed so others not involved in previous discussions
> know what we are talking about: Currently the D-BUS pin helper works so
> that when enabled hcid will call a PinRequest D-BUS method at a
> hardcoded service and object path (org.bluez.PinAgent and
> /org/bluez/PinAgent).
> 
> This works fine as long as there is only need for one generic pin
> handler, e.g. a popup dialog. However, a piece of SW might want to
> implement e.g. a "pairing wizard" and take over handling of pin requests
> for a certain remote device for a short period of time. A SIM Access
> Profile implementation might also want to override the default handler
> with a GUI that automatically generates a 16 character PIN (which SIM
> Access Profile requires).
> 
> A (somewhat simple) way to allow this kind of flexibility in PIN
> requests could be e.g. to have two methods for registering PIN handlers:
> 
> 1. For registering the "default" handle you could have
> RegisterDefault(string object_path)
> This would tell hcid (or bluetoothd) that the "object" at the path
> object_path implements the org.bluez.PinAgent
> interface and is ready to handle PIN requests. I havent listed the
> service (or dbus name as it is called nowdays) in the arguments list
> since that information could be picked directly from the method call
> (using dbus_message_get_sender()). If we want to allow a service to
> register a handler on behalf of another service, then this extra
> parameter can of course be added.
> 
> 2. For registering a "special" pin handler you could have e.g.
> RegisterSpecial(string object_path, string bt_addr)
> Same applies as for RegisterDefault, except that only PIN requests for
> the device identified by bt_addr would be delegated to this handler. A
> "unregister" method for this type of handler might not be necessary as
> we can have e.g. a timer for removing it automatically if nothing hapens
> for a while. The handler would naturally also be removed once pairing
> has succeeded with the device that the handler was registered for or if
> the service which registered the handler disappears from the bus.

my current idea is to have a default handler that the applications have
to register over org.bluez.Manager and that they can have multiple other
PIN handlers registered via the org.bluez.Device interface for specific
devices. While the default handler is permanent, all other PIN handlers
may expire and get removed automatically.

Do we really only need the object path? I really like to get the default
handler thing implemented very soon.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
