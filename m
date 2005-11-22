Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem setting the flush timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43815F5F.8030402@masaka.cs.ohiou.edu>
References: <43815F5F.8030402@masaka.cs.ohiou.edu>
Content-Type: text/plain
Message-Id: <1132657745.28644.7.camel@blade>
Mime-Version: 1.0
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
Date: Tue, 22 Nov 2005 12:09:05 +0100

Hi Jim,

> 	I have been pulling my hair for quite some time at the 
> set-flush-timeout.c code segment I was referred to use to set the flush 
> timeout for a bluetooth device.  The call to hci_get_route( bdaddr_t* ) 
> is failing, even though I directly cut-and-pasted the code.  I verified 
> that the address I'm passing does exist on the system.  It's setting 
> errno to 19 and claiming that the device doesn't exist even though I'm 
> 100% positive that it does (hcitool dev shows it's 00:11:95:4F:FD:22, 
> and cr -> bdaddr_t.b[5] through cr -> bdaddr_t.b[0] are the same values, 
> copied in using str2ba).  The device does definitely exist on the 
> system.  Any other idea why this might be happening?

if you wanna use hci_get_route() then use the code inside hcitool.c for
any reference, because its usage is known to work.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
