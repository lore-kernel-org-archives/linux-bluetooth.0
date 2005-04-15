Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Stefan Jonasson <sjond00@student.vxu.se>
To: bluez-devel@lists.sourceforge.net
Message-id: <4c513c4c7893.4c78934c513c@vxu.se>
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252
Subject: [Bluez-devel] SonyEricsson K700i and HID
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
Date: Fri, 15 Apr 2005 13:26:20 +0200

Hi all!

I just bought an SonyEricsson K700i and it have support for bluetooth HID=
=2E
After researching a bit I realized that there probably isent any way to m=
ake it work in linux atm=2E=2E

I tyred to use it as a keyboard/ mouse with hidd=2E The phone and compute=
r can connect to each other the phone shows the input map ( just as it do=
es in windows when you use this function)=2E And hidd dosent report any f=
ailures=2E=2E=2E

Now I want hidd to do something useful like creating a mouse device and a=
 keyboard!

A list of questions=3A

Which implementations do I need to chage=3F
How to I make hidd k700i aware=3F
Shoud I create an new application that uses the hidp module directly=3F
How do I inspect the traffic=3F
It there anyway to make hidd print debug info=3F
Is this possible to do=3F
Wich specifications do I need=2C where can I get them=3F
I found a nice document on ericssons dev site http=3A//developer=2Esonyer=
icsson=2Ecom/getDocument=2Edo=3FdocId=3D66147 will it help=3F

-- =

-----------------------
Stefan Jonasson

Wipmind AB
Storgatan 4
352 52 V=E4xj=F6

Tel=3A 0470-74 95 00
Fax=3A 0470-74 95 01
-----------------------




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
