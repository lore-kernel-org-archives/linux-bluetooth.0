Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <s0adece8.044@EMAIL>
From: "Kishore A K" <kishoreak@myw.ltindia.com>
To: <dwmw2@infradead.org>, <shemminger@osdl.org>
Cc: <bridge@lists.osdl.org>, <bluez-devel@lists.sourceforge.net>,
   <liziero.diego@unimore.it>
Subject: Re: [Bluez-devel] Re: [Bridge] bridging bluetooth bnep
	deviceswith kernel 2.6.6-*
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Fri, 21 May 2004 11:49:33 +0530

The ifreq structure to br_dev_do_ioctl() gives you the interface index
(rq->ifr_ifindex) which is currently not being used.

May be it can help..

-Kishore

>>> David Woodhouse <dwmw2@infradead.org> 05/19/04 10:30PM >>>

On Tue, 2004-05-18 at 15:36 -0700, Stephen Hemminger wrote:
> Hmm, since all the blue tooth devices have the same address.
> Deleting the first one will cause the entry in the forwarding table
> to be deleted, that might cause your problem.  Perhaps we need a
> reference count on the number of interfaces with the same address =
(yuck).

That seems like a reasonable answer. I believe there's also some
workstation hardware with multiple Ethernet devices, all sharing the
same MAC address (=3D=3D hostid). It's not just Bluetooth. How does this
work with VLAN bridging?

Precisely what is it that's indexed on the interface's MAC address,
rather than the (index of the) physical interface itself?

--=20
dwmw2




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
