Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Implementing the PIN helper support
Message-ID: <20060221122147.GA10892@localhost.localdomain>
References: <1140468298.7047.52.camel@localhost> <20060220211402.GA6466@localhost.localdomain> <1140471085.7047.63.camel@localhost> <20060221093118.GA10267@localhost.localdomain> <1140521700.10008.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1140521700.10008.8.camel@localhost>
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
Date: Tue, 21 Feb 2006 14:21:47 +0200

On Tue, Feb 21, 2006, Marcel Holtmann wrote:
> > Using org.bluez.Manager interface for registering the default handler
> > seems to me extending too much its purpose compared to hald where we
> > copied it from. The only purpose of the manager interface there is to
> > allow local device discovery. Placing the default handler registration
> > method at the interface org.bluez.Device (or org.bluez.Device.PinAgent)
> > and object path /org/bluez/Device should be enough in my opinion. If you
> > want to register a handler only for a specific local device then the
> > exact path for that device (e.g. /org/bluez/Device/hci0) could be used.
> 
> For the default handler the Manager interface makes perfect sense to me.
> It has nothing to do with any device and it can be present even if no
> Bluetooth device is attached at all. From me perspective we put every
> non device specific things into the Manager interface. However I might
> be missing something.

Well, it depends how we define the purpose of the Manager interface :)
If we say it's for "all stuff which is not device specific" then what you
propose is ok. If we say it's only for local device discovery, as in
hald, then the default handler registration shouldn't be in Manager.

In my opinion non-device specific things could just use the root device
path (/org/bluez/Device), while device specific stuff would use the
exact device paths (e.g. /org/bluez/Device/hci0). But, I don't have any
really strong opinion about this, so if you still insist on using
Manager I wont complain anymore ;)

> > > Do we really only need the object path? I really like to get the default
> > > handler thing implemented very soon.
> > 
> > For the handler registration the object path should be enough. However
> > we should probably rethink the org.bluez.PinAgent interface which
> > currently consists of only one method: PinRequest.
> > 
> > The PinRequest method currently takes two arguments: remote device
> > address and a boolean indicating whether the connection is incomming or
> > outgoing. A third parameter should probably be added for object path of
> > the local device, since that information could be used for e.g. querying
> > the name of the remote device.
> 
> The interface must change. We use strings for the BD_ADDR now a clean
> break is a good thing. Can you propose something?

I'm not so convinced about the necessity of the "outgoing" boolean
parameter, so depending on whether you want to keep it or not (we could
add another device method for getting this information later) I'd
propose one of the following:
PinRequest(string bt_addr, string device_path)
PinRequest(string bt_addr, string device_path, boolean outgoing)

So a call could look like:
PinRequest("11:22:33:44:55:66", "/org/bluez/Device/hci0")

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
