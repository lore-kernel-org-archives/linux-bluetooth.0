Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <418D0016.2020408@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: multi rfcomm/sco connection
References: <E1CQIAu-0004AO-Dd@sc8-sf-list2.sourceforge.net>	 <007901c4c402$84dd2280$6f04a8c0@ZBOX> <1099749058.6919.56.camel@pegasus>
In-Reply-To: <1099749058.6919.56.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 06 Nov 2004 17:47:18 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
|>In the other way, I have test with hsmicro with two Headsets it's OK
|>but I must force Alternate Setting of Isochronous interface from default
|>2 to 4 (two 16 bits Voice links) in hci_usb_probe() [hci_usb.c]
|
|
| This is a known problem, because we don't use a dynamic alternate
| setting switching. It must be fixed inside the driver.
|
| Send me a patch for the hci_usb driver that can switch the alternate
| setting depending on the number of SCO connections. You should talk to
| the Bluetooth ALSA (bluetooth-alsa.sf.net) guys, because they will need
| this too.

*developer raising hand*

I'm one of the bt-alsa guys and looked into the problem a bit. You can
find my questions in the mailing list archive of bluez-devel, Topic was
"question about hci_usb endpoint selection..."

We cleared some basic things like what usb callbacks are needed, but I
never came to selecting the correct alternate mode.

I short it comes down to something like:

"the number of sco connections and there type (16b, 8b) lead to the
alternate setting. Look again in the BT specs for this".

Another excerpt from the email communication:

***
~ int usb_set_interface(struct usb_device *dev, int interface, int
alternate);
***

The documentation/manpage says:

***
Note that in the Linux USB subsystem, bandwidth associated with an
endpoint in a given alternate setting is not reserved until an URB is
submitted that needs that bandwidth. Some other operating systems
allocate bandwidth early, when a configuration is chosen.

This call is synchronous, and may not be used in an interrupt context.
Also, drivers must not change altsettings while urbs are scheduled for
endpoints in that interface; all such urbs must first be completed
(perhaps forced by unlinking).
***

Please have a closer look at the older email communication, if you begin
to develop a solution it would be great if you can keep me up-to-date so
that we don't do the same work twice.

CU & good luck,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjQAVQWC6DTWkDAoRAj2CAJ95/FndEkAExhpxoFepV575WlXQWwCbBP0q
mlqU0TpoDkgYY1WwAchOSow=
=ujWU
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
