Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060714164706.GB25533@inf.fu-berlin.de>
References: <20060714161657.GA25533@inf.fu-berlin.de>
	<1152894175.25660.35.camel@localhost>
	<20060714164706.GB25533@inf.fu-berlin.de>
Date: Tue, 18 Jul 2006 13:01:31 +0200
Message-Id: <1153220491.4639.23.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] SCO mapping, bccmd mapsco
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

Hi Marcus,

> > >   coach:~# bccmd psset mapsco 0
> > >   coach:~# bccmd psget mapsco
> > >   Map SCO over PCM: 0x0001 (1)
> > >   coach:~# bccmd psset mapsco 1
> > >   coach:~# bccmd psget mapsco
> > >   Map SCO over PCM: 0x0001 (1)
> > 
> > use "bccmd psset --stores psf mapsco 0".
> 
> Wow, that was quick. But using "--stores psf" doesn't seem to
> help; and even the hciconfig output remains unchanged:
> 
>   coach:~# hciconfig hci0 revision
>   hci0:   Type: USB
>           BD Address: 08:00:46:EB:0E:B6 ACL MTU: 192:8 SCO MTU: 64:8
>           HCI 18.1
>           Chip version: BlueCore02-External
>           Max key size: 56 bit
>           SCO mapping:  PCM
>   coach:~# bccmd psset --stores psf mapsco 0
>   coach:~# bccmd psget mapsco
>   Map SCO over PCM: 0x0001 (1)
>   coach:~# hciconfig hci0 revision
>   hci0:   Type: USB
>           BD Address: 08:00:46:EB:0E:B6 ACL MTU: 192:8 SCO MTU: 64:8
>           HCI 18.1
>           Chip version: BlueCore02-External
>           Max key size: 56 bit
>           SCO mapping:  PCM
> 
> I'll be happy to try anything else. :-)

try "bccmd psset --stores psi mapsco 0". If this still doesn't work then
replace "psi" with "0".

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
