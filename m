Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1110013987.422978238ef72@mail.orbitel.bg>
From: Todor Todorov <dr_doom@engineer.bg>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BNEP connection destroing :(
References: <1109664374.42242276c644b@mail.orbitel.bg>  <1109691651.42248d0394218@mail.orbitel.bg> <1109697370.17256.174.camel@pegasus>
In-Reply-To: <1109697370.17256.174.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
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
Date: Sat,  5 Mar 2005 11:13:07 +0200

> Hi Todor,
> 
> > < HCI Command: Disconnect (0x01|0x0006) plen 3
> >     handle 41 reason 0x13
> >     Reason: Remote User Teminated Connection
> 
> this means that we terminate the connection. This is funny, because I
> have no idea why that happens. Maybe you should use a 2.6.11-rc5 kernel
> instead of an old 2.4 kernel.
> 
> Regards
> 
> Marcel

OK. After few days of testing with the latest - 2.6.11 kernel, i can confurm that the problem is fixed :).

Thanks  Marcel.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
