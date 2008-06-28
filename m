Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jun 2008 21:16:16 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <141182A5-019F-43A8-B772-AA194053CF83@gmail.com>
Message-ID: <alpine.LNX.1.10.0806272104530.24625@nge2.ngu.pk>
References: <alpine.LNX.1.00.0806021644270.9709@nge2.ngu.pk>
	<141182A5-019F-43A8-B772-AA194053CF83@gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez-3.22: hcid segfault
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


On Sun, 22 Jun 2008, Johan Hedberg wrote:



-> > hcid[10625]: segfault at 10 ip b7c65586 sp bfe39700 error 6 in
-> > libaudio.so[b7c5b000+1e000]
-> 
-> I took a look at the code that the backtrace refers to and it has been
-> changed a little bit since 3.32. Could you try with 3.33 or even better with
-> CVS HEAD and see if the problem still exists?


Must be a lag in this digest... anyway, I see 3.34 is out, so I'll see what 
happens with those.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
