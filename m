Return-Path: <cijoml@volny.cz>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] bthid updated
Date: Mon, 10 Nov 2003 12:25:09 +0100
References: <20031106014519.GA31868@schnell> <1068109845.1288.153.camel@pegasus>
In-Reply-To: <1068109845.1288.153.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200311101225.09925.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Dne =E8t 6. listopadu 2003 10:10 Marcel Holtmann napsal(a):
> Hi Peter,
>
> > I've updated my bthid daemon with some tweaks that
> > may or may not have been necessary to get the new
> > Apple Bluetooth keyboard to work, and a new "-p"
> > option that enables regular pinging after inactivity,
> > which appears to be the key to keeping the Microsoft
> > keyboard from going to sleep so hard that it needs
> > to be power-cycled.  Michal Semler suggested the
> > technique, and I wish that I had thought of it before
> > I broke the keyboard's battery compartment cover from
> > overuse.
>
> if you have some extra time, please send me the information from
> "hcitool inq" and "hcitool info" of the Apple devices. And the output
> from the libs2 CVS "sdptest records" could be very helpful, too.
>
> Let's talk a little bit about the freezing of the Microsoft devices,
> because I already solved this for my own HID implementation, but I
> forgot to share my knowledge. The mouse and the keyboard drop both L2CAP
> connections after 12 minutes of idle time and try to disconnect the ACL
> link after that, but on the Linux side we don't handle this correctly.

Maybe M$ handle it incorrectly on theit side :)

> It seems that closing the two L2CAP connections at the same time causes
> problems. The problem must be inside the kernel HCI or L2CAP layer, but
> on my latest review I found nothing wrong. So I used this pseudo code
>
> 	if (we_close_connection) {
> 		close(control_psm);
> 		sleep(1);
> 		close(interrupt_psm);
> 	} else {	/* HID device after 12 minutes idle */
> 		close(interrupt_psm);
> 		sleep(1);
> 		close(control_psm);
> 	}
>
> If you don't do it this way the ACL connection between the host and the
> HID device will not be terminated. In general this is not a problem, but
> it gets unusable and so you have to power-cycle.
>
> Keeping the HID device alive with some kind of pinging is not a good
> idea, because it consumes to much power ;)

=46or now I prefer working solution if non other and better is known...

>
> > The Microsoft and Apple offerings remain the only Bluetooth
> > keyboards of commercial availability known to me.  Has anyone
> > seen another?
>
> Logitech seems to have some devices on the market. Last time I tried the
> old Logitech Presenter I found that your SDP implementation can't get
> the HID descriptor out of this device. I don't have this device handy,
> so I can't reproduce the error.
>
> Have you ever looked at the "User level driver support for input"? It
> maybe can replace your fake driver and I also backported it to 2.4, but
> Marcelo didn't picked it up.
>
> Regards
>
> Marcel

Michal
