Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Multiple Bluetooth connections 
In-Reply-To: Message from Marcel Holtmann <marcel@holtmann.org>
   of "Wed, 16 Mar 2005 10:42:10 +0100." <1110966130.9818.95.camel@pegasus>
References: <42372E0A.80002@futurlink.com>  <1110966130.9818.95.camel@pegasus> 
Message-ID: <22721.1110969653@csr.com>
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
Date: Wed, 16 Mar 2005 10:40:53 +0000

Marcel Holtmann wrote:
> this is a hardware limit and I don't know of any chip that is capable of
> establishing two connections at the same time. From what I know this
> will never be possible, but you should better ask a radio/baseband
> expert for a correct answer.

Below HCI, it won't work in a typical set up.  The usual scan mode is "R1
page scan repetition mode" where the device scans at least (and usually
only) every 1.28 seconds, usually for 18 slots.  If you try to page
two devices at once, you run the risk of switching to paging the other
device at exactly the short window you need to pick up one device,
and hence miss it altogether.  You can do it when the devices are in
"R0" (continuous scan) but then connection time should be more or
less instantaneous anyway and there's no gain.  So it's not supported
by HCI_Create_Connection.

Once you have an ACL connection, it should be entirely possible to
negotiate multiple channels over the top of it, depending on the
software.

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
