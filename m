Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41A5CEF7.8090209@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Detecting RSSI without connecting
References: <qszactrj3c5.fsf@timepilot.gpcc.itd.umich.edu>
    <1099960170.29330.43.camel@pegasus>
    <qszu0rfnfil.fsf@mspacman.gpcc.itd.umich.edu>
In-Reply-To: <qszu0rfnfil.fsf@mspacman.gpcc.itd.umich.edu>
Content-Type: text/plain; charset="us-ascii"
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
Date: Thu, 25 Nov 2004 12:24:23 +0000

Scott W Gifford wrote:
>         Features: 0xff 0xff 0x0d 0x38 0x00 0x00 0x00 0x00
[...]
> Am I doing this wrong, or is it possible that a Bluetooth 1.2 device
> doesn't support RSSI on inquiry?

As far as I'm aware, it's not mandatory. There's a features bit that
tells you whether it's supported. If I've counted right, it's bit 6 of
byte 3 (numbering from 0 in both cases). That is, it's:

  00 00 00 40 00 00 00 00

>From the features mask you've given, it looks like this device doesn't
support it.

>                                    If this device doesn't support it,
> can anybody recommend a device available in the US that does support
> RSSI on inquiry?

Modesty forbids.

Marcel's page at http://www.holtmann.org/linux/bluetooth/features.html
really needs updating to quote more features bits now that 1.2 devices
are starting to appear.

>                  Does the feature need to be supported on both the
> inquiring device and the inquired device to get RSSI information, or
> is support on the inquiring device enough?

It needs to be supported just on the inquiring device.

It's worth noting that although the inquiring device can accurately
(one hopes) report the received signal strength, there's no
requirement for the inquired device to trasnsmit at any particular
power. This might be an issue if the inquired devices are a mix of
different power classes and from different manufacturers. You may
also have to watch the effects of fading (but if you get more than one
report for a different device then you can just take the highest
RSSI to eliminate fading effects).

However, devices that are closer will tend to have a higher RSSI than
devices that are further away, so it's often a good place to start.

	- Steven



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
