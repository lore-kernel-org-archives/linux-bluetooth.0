Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <feb8dc070609190416w53ce1836x82d751cef7099be3@mail.gmail.com>
References: <feb8dc070609190416w53ce1836x82d751cef7099be3@mail.gmail.com>
Date: Mon, 25 Sep 2006 23:52:42 +0200
Message-Id: <1159221162.20997.29.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bnep network not working properly
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

Hi Jinesh,

> I was trying to network two systems using pand. But it seem that even
> after the bnep0 interfaces are provided with IP addresses they are not
> able to ping each other. What could be wrong? I'm using FC5 on both
> systems. One of my system is x86 and the other is x86_64. Are there
> any issues for bluez with any of these architectures which prevent me
> from setting up a complete network? I did my network configuration
> according to the HOWTO-PAN document.

not to my knowledge. Run "hcidump -X -V" to check what is going on.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
