Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] passive inquiry 
In-reply-to: <20041217141809.62713.qmail@web40605.mail.yahoo.com> 
References: <20041217141809.62713.qmail@web40605.mail.yahoo.com>
Message-ID: <17081.1103293811@csr.com>
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
Date: Fri, 17 Dec 2004 14:30:11 +0000

Paolino paperino wrote:
> Hi,
> i want to know if it is possible to make a "passive
> inquiry", i explain better, a device A do an inquiry
> no find their neighbours, it is possible for a device
> B (in the reachability field) to know that was
> inquiried by device A? The applican can receive an
> event each time the device is inquiried?

No, unfortunately that can't work with an ordinary inquiry.
The device which is scanning only receives an ID packet, which
contains no information about the sender.

There are moves afoot to add more flexible forms of inquiry to
the specification, but that hasn't happened yet.

pws


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
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
