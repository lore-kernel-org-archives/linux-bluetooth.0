Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Mark RISON" <mrison@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bd_addr question
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F42nTe1CIGj0gs000015e1@hotmail.com>
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
Date: Wed, 10 Mar 2004 16:04:32 +0000

Steven Singer <steven.singer@csr.com>:

>Michael Schmidt wrote:
> > Keep in mind that you break some of the BT functionality when you use
> > variable BD_ADDRs: The pairing-based security mechanisms (authentication
> > and encryption) rely on a constant BD_ADDR. I guess there is more
> > functionality that is affected by the change.
>Don't forget that Bluetooth addresses must be unique otherwise unpleasant
>things happen.
>Bluetooth addresses come out of the same address space as MAC addresses,
>if you want to use your own then you need to get an OUI or IAB allocation
>from the IEEE.

Well, you could use a MAC address with the U(niversal)/L(ocal) bit set,
which would correspond to a BD_ADDR with bit 9 of the NAP set, as long
as you can guarantee its uniqueness (which in practice means you have
control of all the devices which might participate in your network; bear in
mind that some MAC addresses were allocated with that bit set in pre-IEEE
days).  You don't have to buy/register locally-administered MAC addresses.

>The BD ADDR <-> MAC point is important. If you start running BNEP
>(Bluetooth Network Encapsulation Protocol = Ethernet over Bluetooth)
>then the Bluetooth device will use its Bluetooth address as its Ethernet
>MAC address. This means that you can't simply take the MAC address from
>another device on your system (say an Ethernet card) and use it as your
>Bluetooth address.

Unless you refrain from using that Ethernet card in the same network as
your Bluetooth device.  (This is/was the basis of a popular way to buy a few
MAC addresses: buy a few bargain-basement NICs, read their BD_ADDRs,
and junk the NICs).

Another top tip: don't pick addresses with the I(ndividual)/G(roup) bit set
(i.e. multicast addresses), which would correspond to a BD_ADDR with
bit 8 of the NAP set.  BNEP devices are almost certain to get very confused
by this!

Mark

--
CPC/IP - A TCP/IP stack for Amstrad CPCs
-- http://www.nenie.org/cpcip/
"Z88 vs CPC? Christ. How did we miss that platform war?"
-- http://www.ntk.net/index.cgi?back=archive00/now0128.txt&line=110#l

_________________________________________________________________
Create a Job Alert on MSN Careers and enter for a chance to win $1000! 
http://msn.careerbuilder.com/promo/kaday.htm?siteid=CBMSN_1K&sc_extcmp=JS_JASweep_MSNHotm2



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
