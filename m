Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Implementing the PIN helper support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602210440p141b4b7cta5c51ca87d135bde@mail.gmail.com>
References: <1140468298.7047.52.camel@localhost>
	 <20060220211402.GA6466@localhost.localdomain>
	 <1140471085.7047.63.camel@localhost>
	 <20060221093118.GA10267@localhost.localdomain>
	 <1140521700.10008.8.camel@localhost>
	 <e1effdeb0602210440p141b4b7cta5c51ca87d135bde@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140526960.10008.25.camel@localhost>
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
Date: Tue, 21 Feb 2006 14:02:40 +0100

Hi Claudio,

> Let me try expose some D-Bus features that can help us design the PIN
> Agent better...
> 
> Currently PinAgent uses the system bus connection. D-Bus is able to
> start applications automatically. Applications with user interfaces
> can't be started by system dbus-daemon, only the session can run this
> kind of applications. Using the session bus connection,  it is not
> necessary has a applet/or a application always active. The D-Bus
> starts the application when the first message is sent to the path.
> For more information read the section "Message Bus Starting Services":
> http://dbus.freedesktop.org/doc/dbus-specification.html

I don't think that this is the right way to go. We will have a Bluetooth
applet running (like NetworkManager etc.) and this can handle the tasks
of PIN input. It only needs to tell hcid/bluetoothd that it exists and
where to call it.

If no PIN helper has been registered then the default action will be to
reject every PIN request. This is a clean approach and we can remove a
lot of code from hcid that tries to handle PIN input nicely. And if they
wanna have a fixed PIN then they need to write a PIN helper, but the
whole communication must go over D-Bus. And once version 1.0 of D-Bus is
out, I will make it mandatory for bluez-utils.

> > > > my current idea is to have a default handler that the applications have
> > > > to register over org.bluez.Manager and that they can have multiple other
> > > > PIN handlers registered via the org.bluez.Device interface for specific
> > > > devices. While the default handler is permanent, all other PIN handlers
> > > > may expire and get removed automatically.
> > >
> > > I think you'll still need a way to unregister the default handler, when
> > > e.g. a user logs out from his session (so the next user that logs in can
> > > register his own default handler).
> 
> Remember that we can register fallback path(hierarchical path), where
> the root level can handle messages not handled by the child paths.
> Therefore, the default PIN Agent can be the base and the user defined
> can child paths.

I don't like this. The default action if no handler is registered must
be to reject the PIN request. Lets keep hcid/bluetoothd totally stupid.

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
