Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42DFE719.9010600@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hcitool and rssi value=0
References: <9f41439105072109526cb11e82@mail.gmail.com>
In-Reply-To: <9f41439105072109526cb11e82@mail.gmail.com>
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
Date: Thu, 21 Jul 2005 19:19:05 +0100

Julien BIBOLLET wrote:
> hcitool rssi 00:04:3E:46:02:26
> output is always RSSI return value: 0

0 means that the received signal strength is good - it's in what's
called the golden range (see the HCI specification).

If the signal goes below the bottom of the golden range you'll get
negative numbers, if it goes above you'll get positive numbers.

The golden range is nominally -60 to -40 dBm.

Devices will use power control to keep the signal at the receiver within
the golden range. So, you'll find that the RSSI is zero over a large
variation in range. Devices may power control by 30 dB. Add that to the
20 dB width of the range and you effectively can't distinguish path
losses of 50 dB. That's a factor of 10^5 in power or a factor of 300 in
range (in free space). So, you may not be able to distinguish a device
5 cm away from one 15 m away.

Basically, RSSI on its own is no good for ranging.

If you can get the transmit power of the other side then you can improve
things immensely. You can find out what power you're transmitting with
by using the HCI_Read_Transmit_Power_Level command. Finding out the
remote side's power is much trickier (unless, of course, it doesn't
support power control).

If you've got a BT 1.2 device then you can use inquiry with RSSI.
Devices tend to respond to inquiry at fixed power (although exactly what
that power is may vary from device to device). The inquiry results don't
have a golden range dead band in them which helps too.

However, inquiry results can easily be spoofed so I wouldn't use it for
any secure applications.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
