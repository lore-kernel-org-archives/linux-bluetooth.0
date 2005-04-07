Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42556E87.7090206@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [PATCH] H4 loss of synchronization recovery
References: <Pine.GSO.4.33.0504071324180.4769-100000@horus.imag.fr>
In-Reply-To: <Pine.GSO.4.33.0504071324180.4769-100000@horus.imag.fr>
Content-Type: text/plain; charset="us-ascii"
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
Date: Thu, 07 Apr 2005 18:31:51 +0100

Catalin Drula wrote:
> But, I would safely say that if such devices exist, they are the
> exception, rather than the norm. Maybe someone with more knowledge about
> Bluetooth firmware could confirm/infirm that (Steven?). From the spec it
> does not sound like those hardware error should be occuring very often
> (they should signal critical conditions; they cannot be "benign").

As an example, I can think of one for CSR devices that might cause a
problem. It indicates a real, serious error but does not require a
reboot. It's FAULT_SYNTH (0x12). This is emitted at boot if we're unable
to calibrate the radio. The usual reason for this is that our PS keys
have not been set correctly. The host will then want to set the correct
PS keys and reboot.

This might be common on ROM devices without an external EEPROM as the
PS keys are wiped on every cold reboot. The ROM parts have to assume
values for critical parts of the system, such as the crystal frequency.
Clearly, this can be right only for some modules. Attempting to
calibrate the radio from a 16 MHz crystal when you think it's 26 MHz
is likely to fail (you'll be trying to tune to 1.4 GHz, not 2.4 GHz).
The chip will still boot, albeit a bit slower, and will then use baud
rate detection to establish communcation with the host. The host should
then download the right parameters and issue a BCCMD SETREQ warm_reset.

Fortunately, in this case, an HCI_Reset is not a sufficiently hard reset
to force us to try and recalibrate, so we shouldn't get stuck in an
infinite loop.

We did once toy with hardware error codes to indicate battery voltage
problems. We don't use them now, but they would be another example of
something serious enough for a hardware error but where rebooting is the
wrong thing to do.

Having said that, on the H4 transport, 99.9% of all hardware errors are
loss of link synchronisation, so resetting HCI is usually the right
thing.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
