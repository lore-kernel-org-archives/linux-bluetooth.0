Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCIDump Problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <d1f423d3050324103340daebcc@mail.gmail.com>
References: <d1f423d3050324103340daebcc@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1111689618.9311.1.camel@pegasus>
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
Date: Thu, 24 Mar 2005 19:40:18 +0100

Hi Anderson,

> I am trying to compile Bluez-HCIDump 2.18 but I am facing the following error:
> 
> hci.c: In function `cmd_complete_dump':
> hci.c:998: error: `OCF_READ_LINK_QUALITY' undeclared (first use in
> this function)
> hci.c:998: error: (Each undeclared identifier is reported only once
> hci.c:998: error: for each function it appears in.)
> hci.c:1001: error: `OCF_READ_CLOCK' undeclared (first use in this function)
> make[1]: *** [hci.o] Error 1
> 
> should I update hci.c ? any help will be welcome.

look at http://article.gmane.org/gmane.linux.bluez.devel/4400

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
