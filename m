Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1165849102.5344.71.camel@ODole-Ubuntu>
References: <1165849102.5344.71.camel@ODole-Ubuntu>
Date: Mon, 11 Dec 2006 16:03:06 +0100
Message-Id: <1165849386.20733.9.camel@localhost>
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

> I work on PAN profile and there is maybe a bug if we refer to the specs
> (PAN profile v1.0).
> I've run a PANU server with pand daemon on my Linux machine and I was
> able to connect 2 different devices to this server. And according to the
> specification (page 15):
>         2.1.3 PANU-PANU
>         In this scenario, a point to point connection between two PANUs
>         allows direct communication between these two nodes only.
> 
> So the second connection should fail, isn't it ? I suppose (not test it)
> that the same behavior occurs with GN or NAP role. I mean that you can
> connect more than 7 peers to the server.

I can't follow you and I also don't see a problem here. Everything
depends on the way you setup the bridge or the routing for the bnep0
Ethernet devices.

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
