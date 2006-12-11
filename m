Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1165849742.5344.75.camel@ODole-Ubuntu>
References: <1165849102.5344.71.camel@ODole-Ubuntu>
	<1165849386.20733.9.camel@localhost>
	<1165849742.5344.75.camel@ODole-Ubuntu>
Date: Mon, 11 Dec 2006 21:51:25 +0100
Message-Id: <1165870285.20733.19.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] PAN profile BUG?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Olivier,

> The problem from my point of view is that if you run a PANU server (so
> no need of Ethernet bridging), you must only have one slave and you are
> able to have 2 slaves (or more) connected to the server... Even if that
> is not really a bug, it does not strictly follow PAN specifications.

so you wanna have a mode that stops listening on the PSM 15 when it has
a bnep0 connection and starts again once this connection has been
terminated. It is doable, but I am not sure if it is worth changing the
source code this way and first you have to convince me that we would
fail the qualification tests if we keep supporting this. Otherwise it is
a nice feature of BlueZ, because all this UUID stuff in the BNEP
specification is crap anyway.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
