Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602210440p141b4b7cta5c51ca87d135bde@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Implementing the PIN helper support
In-Reply-To: <1140521700.10008.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1140468298.7047.52.camel@localhost>
	 <20060220211402.GA6466@localhost.localdomain>
	 <1140471085.7047.63.camel@localhost>
	 <20060221093118.GA10267@localhost.localdomain>
	 <1140521700.10008.8.camel@localhost>
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
Date: Tue, 21 Feb 2006 09:40:00 -0300

Hi guys,

Let me try expose some D-Bus features that can help us design the PIN
Agent better...

Currently PinAgent uses the system bus connection. D-Bus is able to
start applications automatically. Applications with user interfaces
can't be started by system dbus-daemon, only the session can run this
kind of applications. Using the session bus connection,  it is not
necessary has a applet/or a application always active. The D-Bus
starts the application when the first message is sent to the path.
For more information read the section "Message Bus Starting Services":
http://dbus.freedesktop.org/doc/dbus-specification.html


On 2/21/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
> > > my current idea is to have a default handler that the applications ha=
ve
> > > to register over org.bluez.Manager and that they can have multiple ot=
her
> > > PIN handlers registered via the org.bluez.Device interface for specif=
ic
> > > devices. While the default handler is permanent, all other PIN handle=
rs
> > > may expire and get removed automatically.
> >
> > I think you'll still need a way to unregister the default handler, when
> > e.g. a user logs out from his session (so the next user that logs in ca=
n
> > register his own default handler).
[Claudio Takahasi]
Remember that we can register fallback path(hierarchical path), where
the root level can handle messages not handled by the child paths.
Therefore, the default PIN Agent can be the base and the user defined
can child paths.

>
> I agree. In the first place I thought we can automatically unregister it
> when the program ends, but in case of desktop switching we need the
> Bluetooth applet playing nice.
>
> > Using org.bluez.Manager interface for registering the default handler
> > seems to me extending too much its purpose compared to hald where we
> > copied it from. The only purpose of the manager interface there is to
> > allow local device discovery. Placing the default handler registration
> > method at the interface org.bluez.Device (or org.bluez.Device.PinAgent)
> > and object path /org/bluez/Device should be enough in my opinion. If yo=
u
> > want to register a handler only for a specific local device then the
> > exact path for that device (e.g. /org/bluez/Device/hci0) could be used.
>
> For the default handler the Manager interface makes perfect sense to me.
> It has nothing to do with any device and it can be present even if no
> Bluetooth device is attached at all. From me perspective we put every
> non device specific things into the Manager interface. However I might
> be missing something.
>
> > > Do we really only need the object path? I really like to get the defa=
ult
> > > handler thing implemented very soon.
> >
> > For the handler registration the object path should be enough. However
> > we should probably rethink the org.bluez.PinAgent interface which
> > currently consists of only one method: PinRequest.
> >
> > The PinRequest method currently takes two arguments: remote device
> > address and a boolean indicating whether the connection is incomming or
> > outgoing. A third parameter should probably be added for object path of
> > the local device, since that information could be used for e.g. queryin=
g
> > the name of the remote device.
>
> The interface must change. We use strings for the BD_ADDR now a clean
> break is a good thing. Can you propose something?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
