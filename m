Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42498E15.9000409@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Hardware Error event patch
References: <Pine.GSO.4.33.0503251434430.12451-100000@horus.imag.fr>
In-Reply-To: <Pine.GSO.4.33.0503251434430.12451-100000@horus.imag.fr>
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
Date: Tue, 29 Mar 2005 18:19:17 +0100

Catalin Drula wrote:
> I've finished the patch for handling the Hardware Error event and you have
> it attached below.
> 
> To briefly remind the context: when H4 (HCI over UART) is used
> as the transport layer between the host and the Bluetooth controller
> and the controller detects a loss of synchronization, it sends a
> "Hardware Error" event to the host, which should then send a "Reset"
> command for resynchronization. The procedure is described under "Error
> Recovery" in the H:4 appendix of Bluetooth v1.1 specification.

Are you resetting for all hardware error events, or just when you think
that H4 synchronisation has been lost?

It is true that the spec says that a device will issue a hardware error
when synchronisation is lost but it doesn't say that that's the only
reason for a device to issue a hardware error.

CSR devices, for example, use hardware error code 0xFE to mean that H4
synchronisation has been lost. Other hardware error events mean other
things and HCI_Reset is not the appropriate action in all cases. In some
cases no action is required. In other cases user intervention will be
needed to clear the error and we'll emit a hardware error on every boot
until the problem is resolved. A few cases will require a harder reset
than an HCI_Reset.

You probably don't want to reset if you receive a hardware error and
you were not using the H4 host transport.

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
