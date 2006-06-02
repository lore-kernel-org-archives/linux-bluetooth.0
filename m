Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <200606021531.k52FVqi8028691@news01.csr.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <1149260862.23555.5.camel@localhost> 
References: <loom.20060602T160736-77@post.gmane.org>
	<1149260862.23555.5.camel@localhost>
Date: Fri, 02 Jun 2006 16:31:52 +0100
From: Peter Stephenson <pws@csr.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] PAN over bluetooth - no TCP/IP activity
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> > The problem is, that I can not even ping them. After a lot of tries, I
> > figured out, that if I put the bnep0 interface in promiscuous mode, using 
> > ifconfig bnep0 promisc (at the NAP side)
> > then ICMP packets starts flowing, and the both nodes are able to ping each
> > other. But that's all. 
...
> > bnep0     Link encap:Ethernet  HWaddr 11:11:11:11:11:11
...
> one of these ISSC chips again. The MAC address is bogus and as far as I
> recall not valid for Ethernet.

Right, that looks like a group address (the lowest bit is set), i.e.
valid for multicast or broadcast only.  That's definitely going to get
you into trouble with Ethernet/802 addressing logic.

-- 
Peter Stephenson <pws@csr.com>                  Software Engineer
CSR PLC, Churchill House, Cambridge Business Park, Cowley Road
Cambridge, CB4 0WZ, UK                          Tel: +44 (0)1223 692070


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
