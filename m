Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406241009.i5OA9wFo030305@news01.csr.com>
Message-ID: <Pine.BSO.4.58.0406241335110.23949@nemo.student.utwente.nl>
References: <200406241009.i5OA9wFo030305@news01.csr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] BT_ADDR Address Resolution
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
Date: Thu, 24 Jun 2004 13:39:52 +0200 (CEST)


Hi,

Just wondering...

Does anyone know how IP addresses in the Bluez PAN get resolved to 
BT_ADDRs that will be used by BNEP? Is there an ARP broadcast (i.e. query 
like slave -> master -> broadcast to all slaves) or some sort of proxy ARP
mechanism at master (e.g. query from slave->master and then a reply 
master->slave).


Thanks,
Assed


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
