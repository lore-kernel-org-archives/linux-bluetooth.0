Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050406070077389f4c@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] NAP service records attributes
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
Date: Wed, 6 Apr 2005 11:00:20 -0300

Hi,

According with Bluetooth PAN Profile specification IP4vSubnet and
IPv6Subnet NAP service record attributeID is a displayable string
containing subnet definition of the network, e.g.  10.0.0.0/8  for
IPv4 and  fe80::/48  for IPv6. Based on this informartion I would like
to know if is possible add an extra attribute(IPv4Gateway).

I am working with Bluetooth linux statck(BlueZ). Considering a NAP
scenario, where a PANU connects to the NAP. After establish a PAN, it
is necessary add a route to the default gateway(NAP Bluetooth
interface). However, only the IPv4Subnet is provided and this
information is not enough for IP setup. Attach a DHCP server on NAP
interface or use a standard addressing based on subnet
information(e.g. for 10.0.0.0 the gw  should be 10.0.0.1) can solve my
problem, but I want avoid these approachs.

What is the process to submit a profile change to Bluetooth SIG? Is it
feasible add an IPv4Gateway attribute?

Regards,
Claudio


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
