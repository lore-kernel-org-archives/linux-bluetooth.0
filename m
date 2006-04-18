Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <44454F28.3060800@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sniff & pand
References: <8350AFF45303EE44BE0AF1AB40CA43584DAC8E@scsmsx404.amr.corp.intel.com> <20060407214713.M40337@cos.ufrj.br>
In-Reply-To: <20060407214713.M40337@cos.ufrj.br>
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 18 Apr 2006 21:42:16 +0100

Alexandre Coser Monteiro wrote:
>  EUREKA, EUREKA, it is working, it is working !!!!! You are right it is just a reversed
> sequence of MSB/LSB, but I didn`t find it write in any where.

Then you've not been looking very hard.

Since you're sending raw commands, bypassing BlueZ and talking directly
to the controller, perhaps you should read the HCI specification.

Bluetooth 2.0 + EDR spec, volume 3, part E, section 5.2, page 375:

  * Unless noted otherwise, all parameter values are sent and received
    in Little Endian format

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
