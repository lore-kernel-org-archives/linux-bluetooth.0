Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: mohalik@india.hp.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4100F85D.5080200@india.hp.com>
References: <200401302209.52396.raydar@nwlink.com>
	 <4100F85D.5080200@india.hp.com>
Content-Type: text/plain
Message-Id: <1090583514.4791.42.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 23 Jul 2004 13:51:54 +0200

Hi Swarup,

> I have bluez with bluez-utils-2.7 on two RH 8.0 systems (lx1 and lx2).

please upgrade to bluez-utils-2.8 first. What kernel do you use?

> When I start rctest -r on lx1 without starting rctest -s on lx2, lx2 hangs
> and I have to switch it off and on to restart. This happens EVERY TIME
> I try this.

I don't get the point how lx2 can hang when you listen at lx1. Are these
two different machines or two dongles connected to the same machine?

> This does not happen when I run l2test in any way. Does it prove that
> there is a problem with RFCOMM? I have not seen this problem in
> the mailing list. If I have missed it, please inform.

Actually I don't know. Show us "hcidump -x" from both machines.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
