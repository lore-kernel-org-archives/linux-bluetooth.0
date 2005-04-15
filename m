Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Lars Steinke <sf@lsweb.de>
To: bluez-users@lists.sourceforge.net
Cc: bluez-devel@lists.sourceforge.net
Message-ID: <20050415121633.GA4265@lsweb.de>
References: <20050404194542.GA7640@lsweb.de> <20050404195007.GA8373@lsweb.de> <20050415111207.GA4885@lsweb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050415111207.GA4885@lsweb.de>
Subject: [Bluez-devel] Re: btsco - headset profile activated but no sco packets transmitted ???
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
Date: Fri, 15 Apr 2005 14:16:33 +0200

Phew, got it finally,

it was the bloody ehci_hcd audio problem others have come across:
http://sourceforge.net/mailarchive/message.php?msg_id=11431438

Using ohci_hcd, btsco works a treat in recording and playing, thanks for 
the good work !!!

PS: Should others have trouble using the BT110, keep in mind it has very
stringent power saving and thus will turn off very soon after the last
audio packets have been transmitted (the confimation tone will notify you
of that) - btsco will then quit with "RFCOMM channel lost"... 

Regards,
Lars


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
