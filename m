Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41DA94BF.8000401@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Continuous Inquiry
References: <BAY12-F35563885BF49C62DF2513EAB9E0@phx.gbl>
In-Reply-To: <BAY12-F35563885BF49C62DF2513EAB9E0@phx.gbl>
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
Date: Tue, 04 Jan 2005 13:06:07 +0000

Pegasus ... wrote:
> If I do Inquiry in batches of  1.28 seconds, will that affect Inquiry 
> response from other devices? ...due to the Inquiry Scan Window traversing 
> the same frequencies again !
> 
> I tested the batch approach with the two Socket CF+PCMCIA cards I have and 
> seem to work fine... but maybe it wont work when there are more devices from 
> different vendors ?

In general, this can't be guaranteed to work for the reason you stated.

The minimum time an inquiry can be performed for and have a good chance
of picking up all devices is 10.24 seconds.

I think the raw socket approach is best. Do the inquiry as normal but
snoop on the inquiry response events by using a raw HCI socket.

	- Steven



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
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
