Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Catalin Drula <Catalin.Drula@imag.fr>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <Pine.GSO.4.33.0502101901380.11531-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] Lower granularity for INQUIRY interval
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
Date: Thu, 10 Feb 2005 19:09:14 +0100 (CET)

Hi,

Is there a way to perform INQUIRY for intervals with
a lower granularity than 1.28 seconds? I know the Bluetooth
specification says no.

The solution that I found was to use the INQUIRY_CANCEL command
before the expiration of the inquiry interval. At a programming
level in order to do this I need to work at the HCI level (since the
API function hci_inquiry is blocking, cannot be interrupted).
Is there any other way to do this?

Could we potential have a new function in the API, say
hci_inquiry_fine_granularity, that does exactly what I described
above?

At the Bluetooth hardware level (if there is anyone that has such
knowledge) does my solution of issuing an INQUIRY CANCEL command before
the expiration of the INQUIRY interval really work? (I have a hunch
that the hardware might stay in INQUIRY mode anyway until the end of the
current 1.28sec time slot).

Thanks for any advice,

Catalin



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
