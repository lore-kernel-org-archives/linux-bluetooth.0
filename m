Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <403F30CC.4090209@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Jers <jers@inwind.it>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Parameters of the Bluetooth standard in BlueZ...
References: <001501c3fd1d$019840a0$6b821d97@userpc>
In-Reply-To: <001501c3fd1d$019840a0$6b821d97@userpc>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 27 Feb 2004 11:58:04 +0000

Jers wrote:
> o       The period between the transmission of two consecutive packets
> (According the standard: 244.5 msec, after odd packets; 869.5 msec,
> after even packets)

Coo, you quoted the time from the end of one packet to the start of the
next. I've never seen anyone quote them that way before. Everybody else
measures the time from the start of one packet to the start of the next.
Those would be 312.5 us (half a slot) and 987.5 us (one and a half slots).

And please, the appropriate abbreviation for microseconds is <greek-mu>s
never replace the mu with an m as ms is short for milliseconds - a big
difference. In ASCII text, replace the mu with a u as u is not an SI
prefix so is not prone to confusion. Saying sec instead of s is also
non-standard, but will get you in to trouble only if you try and publish
in a scientific journal.

> I suppose I can set these parameters by BlueZ, so I looked for lines
> that manage them in all BlueZ files but I didn't find.

You can't set these parameters in BlueZ. They're hardcoded in the
Bluetooth chip. All BlueZ does is send down a command asking the chip
to do an inquiry. The chip then sends out thousands of packets and
just reports interesting events back to the host.

BlueZ doesn't even have control over the amount of time the chip spends
on each page train, nor does it have control over the number of hops
used (the country code used to have a small effect on the number of
hops, but country codes have been deprecated).

BlueZ does have control over the total inquiry length and, on the
scanning side, the time between entering inquiry scans and the amount
of time spend in a scan each time.

	- Steven
-- 




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
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
