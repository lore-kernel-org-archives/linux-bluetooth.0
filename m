Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5f30e26104120912237f20ea80@mail.gmail.com>
From: Jeff Wilson <jazzbotley@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] setting inquiry and inquiry_scan parameters
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
Date: Thu, 9 Dec 2004 14:23:33 -0600

Browsing through the gmane archives, I found this nugget of wisdom:

<quote url=http://article.gmane.org/gmane.linux.bluez.devel/1696>
From: Steven Singer <steven.singer <at> csr.com>
Subject: Re: Parameters of the Bluetooth standard in BlueZ...
Date: Fri, 27 Feb 2004 11:58:04 +0000

... <snip> ...

BlueZ does have control over the total inquiry length and, on the
scanning side, the time between entering inquiry scans and the amount
of time spend in a scan each time.

</quote>

I realize this post is over 9 months old, but I'm trying to write an
application that does these very kinds of things.  Can someone tell me
more about the specifics of how to tweak these numbers?  I'm guessing
it's related to HCI ... ?

     Thanks,
       jw


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
