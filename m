Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <935275.31792.qm@web50211.mail.re2.yahoo.com>
References: <935275.31792.qm@web50211.mail.re2.yahoo.com>
Date: Tue, 10 Apr 2007 16:21:33 +0200
Message-Id: <1176214893.18096.0.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Mutliple Dongles with Bluez
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

Hi Shaun,

> Anybody knows if its possible to interface multiple bluetooth dongles
> with Bluez? I would like to get pass the maximum 7 connections per
> dongle limitation of Bluetooth by installing more than one bluetooth
> dongle to a computer and thus increasing the number of connections
> available.

you can do that. It simply works. There is a limit of 16 adapters per
host, but that can be changed with a simple recompilation of the
Bluetooth library.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
