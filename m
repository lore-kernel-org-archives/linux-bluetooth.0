Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid updated
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Klausler <pmk@cray.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031106014519.GA31868@schnell>
References: <20031106014519.GA31868@schnell>
Content-Type: text/plain
Message-Id: <1068109845.1288.153.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 06 Nov 2003 10:10:45 +0100

Hi Peter,

> I've updated my bthid daemon with some tweaks that
> may or may not have been necessary to get the new
> Apple Bluetooth keyboard to work, and a new "-p"
> option that enables regular pinging after inactivity,
> which appears to be the key to keeping the Microsoft
> keyboard from going to sleep so hard that it needs
> to be power-cycled.  Michal Semler suggested the
> technique, and I wish that I had thought of it before
> I broke the keyboard's battery compartment cover from
> overuse.

if you have some extra time, please send me the information from
"hcitool inq" and "hcitool info" of the Apple devices. And the output
from the libs2 CVS "sdptest records" could be very helpful, too.

Let's talk a little bit about the freezing of the Microsoft devices,
because I already solved this for my own HID implementation, but I
forgot to share my knowledge. The mouse and the keyboard drop both L2CAP
connections after 12 minutes of idle time and try to disconnect the ACL
link after that, but on the Linux side we don't handle this correctly.
It seems that closing the two L2CAP connections at the same time causes
problems. The problem must be inside the kernel HCI or L2CAP layer, but
on my latest review I found nothing wrong. So I used this pseudo code

	if (we_close_connection) {
		close(control_psm);
		sleep(1);
		close(interrupt_psm);
	} else {	/* HID device after 12 minutes idle */
		close(interrupt_psm);
		sleep(1);
		close(control_psm);
	}

If you don't do it this way the ACL connection between the host and the
HID device will not be terminated. In general this is not a problem, but
it gets unusable and so you have to power-cycle.

Keeping the HID device alive with some kind of pinging is not a good
idea, because it consumes to much power ;)

> The Microsoft and Apple offerings remain the only Bluetooth
> keyboards of commercial availability known to me.  Has anyone
> seen another?

Logitech seems to have some devices on the market. Last time I tried the
old Logitech Presenter I found that your SDP implementation can't get
the HID descriptor out of this device. I don't have this device handy,
so I can't reproduce the error.

Have you ever looked at the "User level driver support for input"? It
maybe can replace your fake driver and I also backported it to 2.4, but
Marcelo didn't picked it up.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
