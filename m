Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueZ Timing Resolution 
In-reply-to: ""Marc Fouquet""'s message of "Mon, 10 May 2004 12:18:59 BST."
             <002b01c43680$a4ba19b0$0500a8c0@pii350>
Message-ID: <19267.1084185806@csr.com>
From: Peter Stephenson <pws@csr.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 10 May 2004 11:43:26 +0100

"Marc Fouquet" wrote:
> Hello!
> This inter-arrival time between two IP packets always appears to be a
> multiple of
> 1 ms when using BlueZ, for example:
> 0.026006 s between packet 0 and 1
> 0.041003 s between packet 2 and 3
> 0.025990 s between packet 4 and 5
> 0.029987 s between packet 6 and 7
> 0.029997 s between packet 8 and 8
> 0.030001 s between packet 10 and 11
> 
> With other networks - for example ethernet - I can measure
> inter-arrival times that are much shorter than 1 ms.
> 
> I would need to know the exact reason for the limited timing resolution with
> Bluetooth. Does the BT hardware give packets to my Computer only once
> a ms? Or does the BlueZ module only give the packets to the kernel
> once a ms? Why 1 ms and not a multiple of the BT slot time of 625
> microseconds?

Speaking for the hardware part (downstream of the HCI interface), you
could be running into the Bluetooth poll period, which is 40 baseband
slots, i.e. 0.025 seconds.  The master will poll the slave roughly that
often, if there's nothing happening.  It will poll much more often ---
continuously if necessary --- once data starts to flow.  If that's
what's happening, you're seeing a latency for startup which wouldn't
apply if you were sending bulk data.  (That's probably not all that's
going on, however.)

Recent CSR firmware allows you to reduce this using the latency
parameter of the HCI_QoS_Setup command, which is a time in microseconds,
so for example 2500 would be poll every four baseband slots.  That's
about the best you're likely to get when there's no data flowing.  Be
careful, if you have multiple slaves you can screw things up badly.  I'm
just suggesting this as a possible experiment rather than a sensible
setting.  You need version 16 of our firmware, and access to HCI (or you
need to know a man who has access :-)).  This interpretation of latency
is sort of semi-official, so you might be able to do this with some
other hardware, too --- unfortunately the specification of quality of
service in Bluetooth is currently very poor, we're hoping it will be
improved next time round.

-- 
Peter Stephenson <pws@csr.com>                  Software Engineer
CSR Ltd., Science Park, Milton Road,
Cambridge, CB4 0WH, UK                          Tel: +44 (0)1223 692070


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
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
