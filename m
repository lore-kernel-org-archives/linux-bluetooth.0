Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 22 Nov 2006 23:21:53 -0800
From: Andres Vargas - zodman <zod@linuxmerida.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061122232153.00cfe612@localhost.localdomain>
In-Reply-To: <456487C5.3070502@gmail.com>
References: <456487C5.3070502@gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Can't init device hci0: Connection timed out (110)
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

get more errors

first kill hcid process

run:

$ hcid -n -f /dirof/hcid.conf

and it get more errors 

On Wed, 22 Nov 2006 17:24:21 +0000
Simon Williams <systemparadox@googlemail.com> wrote:

> Hello again. I've finally managed to get the device (my 3Com 3CRWB6096 
> Version 2.0 PCMCIA Card) to show up in hciconfig (I had the wrong firmware).
> 
> Dbus is running, all the bluetooth services are running.
> But I get the following...
> 
> # hciconfig
> hci0:   Type: PCCARD
>          BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>          DOWN INIT RUNNING
>          RX bytes:0 acl:0 sco:0 events:0 errors:0
>          TX bytes:4 acl:0 sco:0 commands:1 errors:0
> 
> # hciconfig hci0 up
> Can't init device hci0: Connection timed out (110)
> # hciconfig
> hci0:   Type: PCCARD
>          BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>          DOWN
>          RX bytes:0 acl:0 sco:0 events:0 errors:0
>          TX bytes:4 acl:0 sco:0 commands:2 errors:0
> 
> Is there some way I can manually probe the card for it's address to find 
> out if it's bluez or the driver?
> Shouldn't it have an address even when it's down?
> 
> Please, any other suggestions very much appreciated.
> Thanks in advance
> Simon
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-- 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
