Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4238804C.4070607@indt.org>
From: Claudio Takahasi <takahasi@indt.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] PAN Attributes
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
Date: Wed, 16 Mar 2005 15:51:56 -0300


Hi folks,

Which modification should be done in order to get
NAP/GN attribute values?

I need get the NAP/GN IPv4Subnet attribute from a PANU.

I found following structure in the bluez source code, but I didn't find 
references!

static struct attrib_def pan_attrib_names[] = {
        { 0x200, "IpSubnet", NULL, 0 },         /* Obsolete ??? */
        { 0x30A, "SecurityDescription", NULL, 0 },
        { 0x30B, "NetAccessType", NULL, 0 },
        { 0x30C, "MaxNetAccessrate", NULL, 0 },
        { 0x30D, "IPv4Subnet", NULL, 0 },
        { 0x30E, "IPv6Subnet", NULL, 0 },
};


Thanks in advance,
Claudio.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
