Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabien Chevalier <fabchevalier@free.fr>
In-Reply-To: <48BFDB04.3060003@free.fr>
References: <48BEE75C.9050008@free.fr>
	<1220471377.6714.52.camel@californication> <48BFBBED.5010504@free.fr>
	<48BFDB04.3060003@free.fr>
Date: Thu, 04 Sep 2008 15:51:44 +0200
Message-Id: <1220536304.6714.71.camel@californication>
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

> >> retest with 2.6.27-rc5 since that has full Simple Pairing support and is
> >> the kernel version that counts.
> > 
> > I'm gonna rebase on this one then.
> 
> The issue with sniff mode & disconnect has vanished with 2.6.27-rc5 :-)

are you sure? I am not recalling that I fixed anything in this area. The
ACL link setup has changed to do proper features retrieval before
allowing L2CAP do get into it. However it cools down the phase for the
first L2CAP package.

Btw. report this bug to your hardware manufacturer, because they are not
working according to the HCI specification. It is a bug if disconnect
fails when they are in sniff mode.

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
