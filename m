Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth/gprs problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Marian Gasparovic <marosg@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040426132331.16051.qmail@web20415.mail.yahoo.com>
References: <20040426132331.16051.qmail@web20415.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1082986337.28880.161.camel@pegasus>
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
Date: Mon, 26 Apr 2004 15:32:17 +0200

Hi Marian,

> Now a question I hate to ask : How can it work under
> XP ? It works there without a problem.

I think it uses another MTU on L2CAP level or the granting of credits on
the RFCOMM layer is done in another way which actually may results in a
slower connection, but also may not causes a link manager problem.

The point is that the phone detects a LMP response timeout, so I would
say that the phone works correct and the dongle has the problem. But
without a protocol analyser that can sniff LMP I can't tell you anything
more. Try to buy a CSR based dongle and see if the problem still exists.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
