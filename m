Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth after suspend? 
In-reply-to: <42513AA3.1050309@arnes.si> 
References: <42513AA3.1050309@arnes.si>
Message-ID: <17461.1112620837@csr.com>
From: Peter Stephenson <pws@csr.com>
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
Date: Mon, 04 Apr 2005 14:20:37 +0100

Matija Grabnar wrote:
> I've noticed that bluetooth (I use it for DUN over a Nokia phone 
> exclusively) seems not to
> work after the system comes back from suspend (laptop, both APM suspend 
> on a Dell laptop
> with a USB bluetooth dongle, and ACPI suspend on a Prestigio/Clevo with 
> internal bletooth).
> 
> Any ideas where I should look for the cause?

Find out what sort of dongle it is, and if it's CSR, the firmware version
(HCI subversion, which you should get at the same time).

pws


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
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
