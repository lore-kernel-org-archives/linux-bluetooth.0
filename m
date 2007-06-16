Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1182012252.31424.353.camel@cookie.hadess.net>
References: <1181925876.31424.326.camel@cookie.hadess.net>
	<1181978755.6846.46.camel@aeonflux.inter-touch.com>
	<1182012252.31424.353.camel@cookie.hadess.net>
Date: Sat, 16 Jun 2007 21:24:21 +0200
Message-Id: <1182021864.30934.5.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HID initiated connections and input service
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

Hi Bastien,

> > > 2(3) HID devices I own have the same problem with BlueZ when using the
> > > input service. Both use HID initiated connections, rather than the
> > > Host
> > > initiated connection use case you would see when addind a Bluetooth
> > > mouse to a laptop for example.
> > > 
> > > * First device: Logitech MX5000 mouse/keyboard combo
> > > 
> > > When not switched into HCI mode, the device works as a normal USB HID.
> > > On boot, hid2hci is run, and the 2 devices (mouse and keyboard) try to
> > > connect to bluetooth dongle (ex-USB wireless dongle).
> > > There's no bluetooth-applet, or other services, and the requests are
> > > dropped to the floor, and I end up with a Bluetooth HCI device, and no
> > > keyboard or mouse (unplug/replug "fixes" the problem though).
> > > 
> > > Could we integrate hid2hci into the input service, so that it would only
> > > be started when a session is available? I'm not sure how to handle the
> > > pairing without a keyboard or mouse though...
> > 
> > after catching up with the IRC, I realized another problem with this HID
> > proxy dongles. We can fix that for the original firmwares from CSR that
> > are used by Apple, but for the Logitech's (they are slightly modified) I
> > am not sure.
> > 
> > So when you switch a HID proxy dongle from HID mode into HCI, you have
> > to read its information about stored devices and their link keys. These
> > information have then to be put into /var/lib/bluetooth. This leaves out
> > the HID report descriptor that we also need. So that needs to be gotten
> > while it is still in USB mode.
> 
> So it would be:
> 1) Get info from dongle about its own bdaddr, and the bdaddr of the
> attached devices (do you have code to do that for Logitech devices?)
> 2) Add attached devices' bdaddr as trusted for the device, and get the
> HID report descriptor, save it
> 3) switch the dongle to HCI mode
> 
> Would that work? We could even do this in a HAL addon, or udev callback
> so that we're sure that newly plugged dongles are handled automatically.

something like that and I have no idea how to do that for Logitech
devices. I have strange code for pure CSR dongles, but it is so ugly
that I am not going to share it. It is mostly CSR vendor stuff.

> > Getting the HID report descriptor over USB makes always the assumption
> > that it is exactly the same as on Bluetooth. This should be checked.
> 
> How can I verify that?

I don't have code for that. Need to write a tool that does this.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
