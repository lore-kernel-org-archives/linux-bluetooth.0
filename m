Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Keyboarch encryption howto?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411242141.53437.cijoml@volny.cz>
References: <200411241701.07891.cijoml@volny.cz>
	 <1101313747.27351.122.camel@pegasus>  <200411242141.53437.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1101336298.7538.12.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 24 Nov 2004 23:44:58 +0100

Hi Michal,

> starting hidd --server -E and reconnecting the keyboard totally freezes my 
> keyboard, mouse not worked too.
> After killing hidd, mouse reconnected, but keyboard not. It started to work 
> after removing the batteries :)

as I said, it might not work, because some device don't accept the
encryption request at any time. To issue it at the correct time you need
to know inside the kernel if it is a keyboard or a mouse and we don't
have this information right now. The policy manager will change this.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
