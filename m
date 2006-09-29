Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <451A35A1.6020309@brainhub.org>
References: <451A1A54.3020903@brainhub.org>
	<1159343538.22162.11.camel@localhost> <451A35A1.6020309@brainhub.org>
Date: Fri, 29 Sep 2006 13:52:35 +0200
Message-Id: <1159530755.6131.34.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Microsoft IntelliMouse with kernel 2.6.1
	and	patch-2.6.18-mh1 is broken (fix provided)
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

Hi Andrey,

> here is the patch against linux-2.6.18-mh1 to fix 
> IntelliMouse. That's the best range of changes I have time to provide: 
> somewhere in these changes IntelliMouse was broken. I believe this 
> happened between patch-2.6.15-mh2 and linux-2.6.18-mh1. While there are 
> a lot of changes in these 17 files, but most of them are variable 
> renames. I hope this helps you to narrow down the issue.

I only care about changes in net/bluetooth/hidp/. All others are not
relevant. Can't you show me your changes from that directory.

> [ Does sending compressed patched works? Trying uncompressed first. ]

Keep them uncompressed, then I can read them in my email client.

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
