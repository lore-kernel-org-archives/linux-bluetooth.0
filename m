Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Stefan Jonasson <sjond00@student.vxu.se>
Subject: Re: [Bluez-devel] SonyEricsson K700i and HID
To: bluez-devel@lists.sourceforge.net
Message-id: <4ca6094ca1c0.4ca1c04ca609@vxu.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
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
Date: Fri, 15 Apr 2005 14:07:34 +0200

How exactly did you get it to work .. just by starting hidd with --nosdp,  and then it worked out if the box?

How did you connect the mouse decive to X? I don't think that there are any appropriate mouse protocols / keyboard layouts for the k700 phone !? 

----- Original Message -----
From: Marcel Holtmann <marcel@holtmann.org>
Date: Friday, April 15, 2005 1:41 pm
Subject: Re: [Bluez-devel] SonyEricsson K700i and HID

> Hi Stefan,
> 
> > I just bought an SonyEricsson K700i and it have support for 
> bluetooth HID.
> > After researching a bit I realized that there probably isent any 
> way to make it work in linux atm..
> > 
> > I tyred to use it as a keyboard/ mouse with hidd. The phone and 
> computer can connect to each other the phone shows the input map ( 
> just as it does in windows when you use this function). And hidd 
> dosent report any failures...
> > 
> > Now I want hidd to do something useful like creating a mouse 
> device and a keyboard!
> > 
> > A list of questions:
> > 
> > Which implementations do I need to chage?
> > How to I make hidd k700i aware?
> > Shoud I create an new application that uses the hidp module 
> directly?> How do I inspect the traffic?
> > It there anyway to make hidd print debug info?
> > Is this possible to do?
> > Wich specifications do I need, where can I get them?
> > I found a nice document on ericssons dev site 
> http://developer.sonyericsson.com/getDocument.do?docId=66147 will 
> it help?
> 
> the problem with the K700i is that it only supports two L2CAP
> connections at the same, but for our implementation we will need
> actually three of them. Otherwise we can't get the HID descriptor and
> thus we can only do boot. However I successfully used a K700i with the
> --nosdp option.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real 
> users.Discover which products truly live up to the hype. Start 
> reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
