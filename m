Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Stefan <stv_vt@yahoo.com>
Date: Sun, 4 Jun 2006 12:34:47 +0000 (UTC)
Message-ID: <loom.20060604T140324-862@post.gmane.org>
References: <loom.20060602T160736-77@post.gmane.org>
	<1149260862.23555.5.camel@localhost>
	<200606021531.k52FVqi8028691@news01.csr.com>
Mime-Version: 1.0
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

Peter Stephenson <pws <at> csr.com> writes:

> 
> Marcel Holtmann wrote:
> ...
> > one of these ISSC chips again. The MAC address is bogus and as far as I
> > recall not valid for Ethernet.
> 
> Right, that looks like a group address (the lowest bit is set), i.e.
> valid for multicast or broadcast only.  That's definitely going to get
> you into trouble with Ethernet/802 addressing logic.
> 

Yes, it is! I now can confirm that the wrong MAC address is the only source of
trouble. I borrowed a dongle from a friend, which looks exactly the same - the
shape and the "hciconfing -a" output. The "only" difference was the MAC address
- the new one looks like a real one. And it works now!

So thank you guys for pointing me out!

Nowever, I guess there should be a workaround. The same bogus dongle, but under
Windows with the software, which comes along the dongle (BlueSoleil), works on a
NAP side. Connections from PANU under Windows and Bluez PANU under Linux are
both ok. Well, almost. Things stop working after reboot of the NAP, but this is,
may be, a completely different story. ;)

Regards,
Stefan



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
