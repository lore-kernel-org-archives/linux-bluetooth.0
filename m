Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Bearcat@feline-soul.com
In-Reply-To: <200607272126.48317.Bearcat@feline-soul.com>
References: <44C8FB2F.9070403@kernelconcepts.de>
	<1171.216.47.50.125.1154031396.squirrel@webmail.feline-soul.net>
	<1154049725.7650.8.camel@localhost>
	<200607272126.48317.Bearcat@feline-soul.com>
Date: Fri, 28 Jul 2006 09:21:30 +0200
Message-Id: <1154071290.2298.1.camel@localhost>
Mime-Version: 1.0
Cc: BlueZ users <bluez-users@lists.sourceforge.net>,
        Nils Faerber <nils.faerber@kernelconcepts.de>
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
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

Hi Bearcat,

> I installed the hcidump program (and made/distributed a package for my 
> distro).
> 
> When i press buttons on my keyboards hcidump reports nothing. There is nothing 
> about a pin or security when i turn auth on and try to reestablish 
> connections with the mouse. After auth is off the mouse works fine.
> 
> When trying to connect the keyboard i get a lot of:
> < HCI Command: Role Discovery (0x02|0x0009) plen 2
>     handle 41
> > HCI Event: Command Complete (0x0e) plen 7
>     Role Discovery (0x02|0x0009) ncmd 1
>     0000: 00 29 00 00                                       .)..
> < HCI Command: Read RSSI (0x05|0x0005) plen 2
>     handle 41
> > HCI Event: Command Complete (0x0e) plen 7
>     Read RSSI (0x05|0x0005) ncmd 1
>     status 0x00 handle 41 rssi 0
> < HCI Command: Role Discovery (0x02|0x0009) plen 2
>     handle 41
> 
> Does that mean anything?

this is totally out of context. Make sure that we at least see the
create connection command.

And don't use "hciconfig hci0 auth" unless you know what you are doing.
This is security mode 3 and its config option has been removed for a
very good reason.

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
