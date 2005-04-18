Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
In-Reply-To: <1113607333.16433.46.camel@pegasus>
References: <805b11d45747c1dc166defb93f587cf1@pepper.com> <1113607333.16433.46.camel@pegasus>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a0b3fcf839d24cc684e86db701108bb6@pepper.com>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] hcitool scan while hidd connection..
To: bluez-devel@lists.sourceforge.net
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
Date: Mon, 18 Apr 2005 10:51:15 -0400

Marcel,

Here is the dump when trying to scan while a dvice is connected.

root@(none):~# hcitool scan
Scanning ...
< HCI Command: Inquiry (0x01|0x0001) plen 5
   0000: 33 8b 9e 08 64                                    3...d
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 07 01 04                                       ....
 > HCI Event: Inquiry Complete (0x01) plen 1
   0000: 00                                                .
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 08 00 00                                       ....

Does this give you any clue?

Michael

On Apr 15, 2005, at 7:22 PM, Marcel Holtmann wrote:

> hcidump -X -V



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
