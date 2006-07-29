Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060728225605.90189.qmail@web51403.mail.yahoo.com>
References: <20060728225605.90189.qmail@web51403.mail.yahoo.com>
Date: Sat, 29 Jul 2006 14:53:28 +0200
Message-Id: <1154177608.25939.8.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] rfcomm connection disconnects immediately
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

Hi Manoj,

> I am trying to make RFcomm connection with Motorola
> HS850 through a DBT120 dongle. I am using linux
> 2.4.21-40 kernel and bluez 3.1 .
> I see that the rfcomm connection gets disconnected
> immediately. Is this how it is supposed to work? I
> have pasted hcidump below.

it would be best if you switch to a recent 2.6 kernel instead of using
an old 2.4 kernel.

What commands are using to connect to that headset? Are you sure that
you are using the correct RFCOMM channel.

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
