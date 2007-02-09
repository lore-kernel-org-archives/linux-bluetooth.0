Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <200702091102.l19B2H0L012760@news01.csr.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <b5dccebe0702090241w797ff03fk8dc41eb2e8881015@mail.gmail.com> 
References: <b5dccebe0702090241w797ff03fk8dc41eb2e8881015@mail.gmail.com>
Date: Fri, 09 Feb 2007 11:02:17 +0000
From: Peter Stephenson <pws@csr.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] phone model and link manager version
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

"Mikael Lindqvist" wrote:
> I wonder if there is any correlation between the Link Manager Protocol
> (LMP) Subversion and the model of a bluetooth phone.

Yes and no, but mostly no.  The LMP subversion is that of the link
manager on the Bluetooth chip, not (for example) the phone's GSM
baseband chip---unless Bluetooth is built into the latter, which is
possible but not very common.  In either case it's probably not telling
you the sorts of things you want to know about the phone, simply about
the phone manufacturer's procurement policy.

Note that because they're telling you about the Bluetooth chip, the LMP
and HCI subversion numbers are useless without the Bluetooth
manufacturer ID (which is also reported).  You can decode these
from http://www.bluetooth.org/assigned-numbers/company_identifiers.php

There will be *some* correlation: an older version is likely to appear
in an older phone, obviously.  But even the same model of phone might
have a different version of the firmware, and in some cases even a
completely different Bluetooth chip.  There's not even a requirement
that the LMP subversion is monotonically increasing with time.

pws


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

To get further information regarding CSR, please visit our Investor Relations page at http://ir.csr.com/csr/about/overview

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
