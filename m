Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabien Chevalier <fabchevalier@free.fr>
In-Reply-To: <48CC2BEE.7020207@free.fr>
References: <48BEE75C.9050008@free.fr>
	<1220471377.6714.52.camel@californication> <48CC2BEE.7020207@free.fr>
Date: Sun, 14 Sep 2008 02:05:29 +0200
Message-Id: <1221350729.6695.72.camel@californication>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sniff mode issues regarding
	Sony	Ericsson	headsets: kernel	patch proposal.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien,

> Here are patches against 2.6.27-rc6 and latest bluez git that add 
> support for point 1 below.

problem with these patches is that they are a layer violation between
L2CAP and HCI. It should also work on incoming and outgoing connections
the same way. Also when using socket options, I prefer that we set them
and store the value and the execute it once the connections is up.

Personally I prefer if we would enhance hci_send_acl() to indicate that
we expect it got get out of any power state before processing this data
packet.

And of course this socket option also has to work for RFCOMM.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
