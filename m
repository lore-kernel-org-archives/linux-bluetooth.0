Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP and SDP interface specification?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <407174BC.8020503@uni-paderborn.de>
References: <407174BC.8020503@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1081179607.2843.9.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 05 Apr 2004 17:40:07 +0200

Hi Stefan,

> where can I find the specification of the BlueZ L2CAP and SDP API? I 
> hope there ist any.

the L2CAP API is a socket interface and you will find the API in the
bluetooth/l2cap.h header file. For an usage example look at l2test.

The SDP API can be found in bluetooth/sdp.h and bluetooth/sdp_lib.h and
for example code look at the dund and pand applications.

> And how can I register my application for getting HCI events, so that I 
> don't have to poll? hcid? API/specs?

The HCI API is also a socket interface. If you want to have some kind of
event based approach you have to use and IO event main loop like it is
used in the Glib.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
