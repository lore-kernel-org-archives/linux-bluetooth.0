Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <420BB12D.8010107@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Lower granularity for INQUIRY interval
References: <Pine.GSO.4.33.0502101901380.11531-100000@horus.imag.fr>
In-Reply-To: <Pine.GSO.4.33.0502101901380.11531-100000@horus.imag.fr>
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
Date: Thu, 10 Feb 2005 19:08:29 +0000

Catalin Drula wrote:
> Is there a way to perform INQUIRY for intervals with
> a lower granularity than 1.28 seconds? I know the Bluetooth
> specification says no.

To inquire for less than 10.24 seconds is a bad idea. Unless you
inquire for a single contiguous block lasting 10.24 seconds you do not
have a good probability of picking up all devices.

Note that, for example, 8 consecutive 1.28 second inquiries is not
guaranteed to work.

> Could we potential have a new function in the API, say
> hci_inquiry_fine_granularity, that does exactly what I described
> above?

I don't think that it's a good idea to add an API to make it easy to
perform actions that are bad ideas.

> At the Bluetooth hardware level (if there is anyone that has such
> knowledge) does my solution of issuing an INQUIRY CANCEL command before
> the expiration of the INQUIRY interval really work? (I have a hunch
> that the hardware might stay in INQUIRY mode anyway until the end of the
> current 1.28sec time slot).

CSR devices will stop inquiring straight away (give or take a few
milliseconds). I can't comment on what other manufacturers will do.

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
