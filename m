Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44D20E67.5060802@flcd.net>
Date: Thu, 03 Aug 2006 17:55:35 +0300
From: Denis <denis@flcd.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44D1CEA0.4080205@flcd.net>
	<1154621543.3905.68.camel@aeonflux.holtmann.net>
In-Reply-To: <1154621543.3905.68.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] can't change HCI and LMP version
	on	Cellink	BTA-6030
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

Hi Marcel! First of all let me thank you for making great peace of 
software, I'd be lost without it!
> In general if you don't know what you are doing, then don't touch the PS
> keys.
yeah I know this rule, but I'd like to learn this, and correct the way 
dongle behave so I can utilize it at full power. So maybe you can 
provide me with more information on this issue, I'd like to take a risk 
and wouldn't blame you if dongle become not useable.

> the bccmd defaults for the used stores are chosen the way that you can't
> mess up your dongle. This means that you have explicitly choose a store
> that is persistent. However the best is to use psread and then simply
> use psclr to remove the bogus PS key.
not sure which key to remove as I've run psread before and didn't find 
key representing bluetooth protocol for remote PC.

Maybe you can point me on where to look for information so I can 
understand how it works or maybe I can post readout of psread and you 
advice me what needs to be corrected?

Thank you!
Best Regards,
Denis Stenderchuck
http://forum.weblamp.net/linux
http://www.pharos-search.com



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
