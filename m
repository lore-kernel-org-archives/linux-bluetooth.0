Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SonyEricsson K700i and HID
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4c513c4c7893.4c78934c513c@vxu.se>
References: <4c513c4c7893.4c78934c513c@vxu.se>
Content-Type: text/plain
Message-Id: <1113565314.16433.17.camel@pegasus>
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
Date: Fri, 15 Apr 2005 13:41:54 +0200

Hi Stefan,

> I just bought an SonyEricsson K700i and it have support for bluetooth HID.
> After researching a bit I realized that there probably isent any way to make it work in linux atm..
> 
> I tyred to use it as a keyboard/ mouse with hidd. The phone and computer can connect to each other the phone shows the input map ( just as it does in windows when you use this function). And hidd dosent report any failures...
> 
> Now I want hidd to do something useful like creating a mouse device and a keyboard!
> 
> A list of questions:
> 
> Which implementations do I need to chage?
> How to I make hidd k700i aware?
> Shoud I create an new application that uses the hidp module directly?
> How do I inspect the traffic?
> It there anyway to make hidd print debug info?
> Is this possible to do?
> Wich specifications do I need, where can I get them?
> I found a nice document on ericssons dev site http://developer.sonyericsson.com/getDocument.do?docId=66147 will it help?

the problem with the K700i is that it only supports two L2CAP
connections at the same, but for our implementation we will need
actually three of them. Otherwise we can't get the HID descriptor and
thus we can only do boot. However I successfully used a K700i with the
--nosdp option.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
