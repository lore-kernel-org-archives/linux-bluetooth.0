Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <404EFA72.4090205@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
CC: jessieh@MIT.EDU, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bd_addr question
References: <404EC780.4070609@nue.et-inf.uni-siegen.de>
In-Reply-To: <404EC780.4070609@nue.et-inf.uni-siegen.de>
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
Date: Wed, 10 Mar 2004 11:22:26 +0000

Michael Schmidt wrote:
> Keep in mind that you break some of the BT functionality when you use 
> variable BD_ADDRs: The pairing-based security mechanisms (authentication 
> and encryption) rely on a constant BD_ADDR. I guess there is more 
> functionality that is affected by the change.

Don't forget that Bluetooth addresses must be unique otherwise unpleasant
things happen.

Bluetooth addresses come out of the same address space as MAC addresses,
if you want to use your own then you need to get an OUI or IAB allocation
from the IEEE.

The BD ADDR <-> MAC point is important. If you start running BNEP
(Bluetooth Network Encapsulation Protocol = Ethernet over Bluetooth)
then the Bluetooth device will use its Bluetooth address as its Ethernet
MAC address. This means that you can't simply take the MAC address from
another device on your system (say an Ethernet card) and use it as your
Bluetooth address.

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
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
