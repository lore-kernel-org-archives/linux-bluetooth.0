Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40DB2EFB.6060000@nue.et-inf.uni-siegen.de>
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: topsyturvy@nemo.student.utwente.nl
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BT_ADDR Address Resolution
References: <E1BdWwI-0003pn-Dn@sc8-sf-list2.sourceforge.net>
In-Reply-To: <E1BdWwI-0003pn-Dn@sc8-sf-list2.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 24 Jun 2004 21:43:55 +0200

Hi Assed,

If BlueZ hasn't introduced a mechanism of its own recently, there is no 
dedicated BueZ IP address assignment mechanism. Of course, you may use 
DHCP if a suitable server is available.

The Bluetooth PAN specification ("Personal Area Networking Profile 
v1.0") recommends the "Zero Configuration Networking (Zeroconf)" 
standard (http://www.zeroconf.org/) with 
draft-ietf-zeroconf-ipv4-linklocal-02.txt (or actually one of its 
successors) as instant ("zero configuration") IP address assignment 
algorithm. The code for UNIX (called 'zcip') used to be available at 
http://zeroconf.sourceforge.net/?selected=zcip, but currently there seem 
to be intellectual property problems with it (see explanation on web 
page), so that the code has been removed. Actually it creates an IP 
address out of the 169.254/16 address range with a mathematical 
transform that is seeded by the network adapter's MAC address. It 
queries for potential collisions via AR, and defends an assigned IP 
address against subsequent collisions via ARP.


Hope this helps,

Michael


> Does anyone know how IP addresses in the Bluez PAN get resolved to 
> BT_ADDRs that will be used by BNEP? Is there an ARP broadcast (i.e. query 
> like slave -> master -> broadcast to all slaves) or some sort of proxy ARP
> mechanism at master (e.g. query from slave->master and then a reply 
> master->slave).
> 
> 
> Thanks,
> Assed

-- 
=================================================
Michael Schmidt
-------------------------------------------------
Institute for Data Communications Systems
University of Siegen, Germany
-------------------------------------------------
http:   www.nue.et-inf.uni-siegen.de
e-mail: schmidt@nue.et-inf.uni-siegen.de
mobile: +49 179 7810214
=================================================


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
