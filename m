Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN-BNEP-and TCP/IP
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050208125725.38505.qmail@web26402.mail.ukl.yahoo.com>
References: <20050208125725.38505.qmail@web26402.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1107880667.7327.182.camel@pegasus>
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
Date: Tue, 08 Feb 2005 17:37:47 +0100

Hi,

> Tanks for your help I see the bnep.c file and the
> pand.h, when we perform a connection the pan call a
> bnep fonction which create the bnep0 interface. Bnep
> interface interact directlly with the TCP/IP stack so
> we can immagine that bnep is in the layer 2 just under
> IP.

and again. OSI is only model and you may know that TCP/IP exists before
the ISO/OSI model.

> ps: pand.c doesn't exist because we dosen't need it.
> All is being do by bnep, isn't it? 

And who should create the connection then?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
