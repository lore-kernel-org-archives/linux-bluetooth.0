Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200505262356.17172.cijoml@volny.cz>
Subject: [Bluez-users] Fwd: Re: [linux-usb-devel] Re: [linux-pm] potential pitfall? changing configuration while PC in hibernate (fwd)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 26 May 2005 23:56:16 +0200

Marcel, can you pls tell to David Brownell <david-b@pacbell.net>
where is problem and some info about suspend() method in hci_usb driver?

Thanks

Michal

=2D---------  P=F8edan=E1 zpr=E1va  ----------

Subject: Re: [linux-usb-devel] Re: [linux-pm] potential pitfall? changing=20
configuration while PC in hibernate (fwd)
Date: =E8t 26. kv=ECtna 2005 19:34
=46rom: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, cijoml@volny.cz,=20
linux-kernel@vger.kernel.org

On Wednesday 25 May 2005 4:47 pm, Andrew Morton wrote:
> Michal Semler <cijoml@volny.cz> wrote:
> > It is real stupid, that Linux kernel freezes when simply during hiberna=
te
> > I change Bluetooth dongle to USB mouse in my USB port.

That is, you unplug the dongle -- breaking the USB power session -- and then
plug in a mouse?  And the kernel does something other than disconnecting the
dongle, and then enumerate a new mouse?  That'd be a bug.  Somewhere.  It'd
probably help a lot if the bluetooth USB driver had a suspend() method.

It's not clear to me what you mean by "hibernate".  If that's an "everything
powered off" pseudo-suspend state, then the dongle should always be getting
disconnected, and USB always re-enumerated by Linux.  Only "real suspend"
states, like suspend-to-RAM, can normally maintain USB power sessions.  And
even then, the device drivers need to be prepared to maintain them ... and
do things like stop active I/O requests, and resume them later.

You said this was an all-Intel system.  So which host controller driver is
in use here ... UHCI?  EHCI?  With RC5 and CONFIG_USB_DEBUG, what do the
USB debug messages say is happening?  Does CONFIG_USB_SUSPEND change things?
Try this with purely modular USB for now.

=2D Dave

=2D------------------------------------------------------

=2D-=20
S pozdravem

Michal Semler


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
