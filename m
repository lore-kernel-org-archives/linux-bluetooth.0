Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4239B037.4020803@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Has anyone seen these problems with the CSR
    BlueCore and BlueZ before ?
References: <E1DBv62-0004qg-Ld@sc8-sf-mx1.sourceforge.net>
In-Reply-To: <E1DBv62-0004qg-Ld@sc8-sf-mx1.sourceforge.net>
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
Date: Thu, 17 Mar 2005 16:28:39 +0000

Han Hoekstra wrote:
> What I think happens is that the BlueCore receives data to fast over the air
> and can not pass it on to the Linux CPU quick enough, so there is an
> internal overflow in the BlueCore.

This shoudn't happen.

The BlueCore firmware has multiple layers of defences in place to prevent
exactly this sort of problem.

If it's reset, it's possible that the firmware has detected a problem
and has panicked. If it has, a panic code will be stored in RAM and
preserved across the reset. You should be able to read it by using
BCCMD to get variable 0x6805. You might also want to read the fault
code in variable 0x6806.

Panic represent unrecoverable fatal errors (like they do for the
linux kernel). They cause the chip to reset immediately. Faults
represent recoverable errors. The firmware does its best to continue.
It reports the problem with an HCI Hardware_Error event and an HQ
report.

>From the panic code, I should be able to tell you exactly what the
firmware thinks has gone wrong.

One slight snag is that since the panic and fault codes are kept in an
area of RAM that's never reset, on power up they go to random values.
All valid values are less than 0x0100, so usually you can distinguish
the random values from real values. You can use bccmd to set the value
to 0 after you've read it to make sure that you're seeing an up to date
value.

[Marcel, would it be a good idea to add reading of the panic and
fault codes to the CSR specific section of hcitool revision? Or,
get BlueZ to read the panic code when the inerface is brought up. If
it's non-zero and < 0x0100 write it to an event log and then zero it.]

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
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
