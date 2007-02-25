Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070225202324.26b0f039.fotopiper@o2.pl>
References: <20070225202324.26b0f039.fotopiper@o2.pl>
Date: Mon, 26 Feb 2007 00:45:43 +0100
Message-Id: <1172447143.20450.6.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Passkey-agent and pin list.
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

Hi,

> i've decided to go for bluez 3.9.. and even found a way to operate
> it ;) especially as the example pass-agent is concerned... yet I would
> like to have more or less the same fect as with the 2.X releses and a
> pin_helper...
> A passkey-agent that would read a file with device addresses and pins,
> and used the passkey from the list.
> Does anyone has an idea how to acheve suc trick?

you simply write such a passkey agent. This makes this interface so
great, because the agent is really simple to replace with your own code.
You can even write this in Python or Perl (actually any language with a
D-Bus binding).

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
