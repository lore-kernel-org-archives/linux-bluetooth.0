Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44CDD529.6030001@infitsrl.com>
Date: Mon, 31 Jul 2006 12:02:17 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44BE5DB3.7090406@gmail.com>	<1153356539.4094.9.camel@aeonflux.holtmann.net>	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>	<20060724103824.1ff98fa6@McGee-XPC>
	<44C4CC37.1060308@infitsrl.com>	<20060724155621.02cd5e11@localhost.localdomain>	<1153758912.25058.3.camel@localhost>	<20060724203433.7184d301@localhost.localdomain>	<7359D844-F738-4AD1-A1FD-F59BEFD149EC@infitsrl.com>	<1153775541.25058.6.camel@localhost>
	<44C881B5.7060809@infitsrl.com>
	<1154085261.2298.34.camel@localhost>
In-Reply-To: <1154085261.2298.34.camel@localhost>
Subject: [Bluez-devel] About l2cap patch to handle multiple connections....
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi I'm trying to play with the patch to make it work (as Marcel said it =

hangs my machine).

First I'm trying a simple debug by printing to find where it hangs...

There is a first question about this: various BT_DBG statements that =

print bluetooth address
in string format (using batostr) print them in reverse =

order(00:01:02.... is printed 02:01:00).
My test machine is a powerpc based mac, I've used in user-space the =

ba2str  without problems in same architecture
so I'm confused about this.

An other dubt is about following log :

Jul 31 10:36:39 localhost kernel: [  596.604617] Bluetooth: =

00:00:00:00:00:00 -> 44:53:25:E3:01:00 psm 0x300
Jul 31 10:36:39 localhost kernel: [  596.606752] Bluetooth: =

00:00:00:00:00:00 -> 20:68:2A:2D:09:00 psm 0x300
(address are in reverse order as I said above)

Why psm is 0x300? May be also the psm in reverse order and really it's =

0x003 (RFCOMM) as I would have expected ?

Many thanks
Fabrizio


Marcel Holtmann ha scritto:
> Hi Fabrizio,
>
>   =

>> I'm trying to use the patch to handle multiple l2cap connection, I'm not =

>> a kernel/modules expert developer so
>> I need a little help.
>> Firts I'm trying to understand what the patch do and I think it's clear =

>> (is used a linked list to handle multiple connection).
>>     =

>
> one warning up-front. I never actually ran this patch on any machine. It
> is only compile tested. So it might crash your system.
>
>   =

>> My problems are with kernel programming enviromnment:
>>
>> 1) I'm using kernel-2.6.10 I have to update to a more recent version?
>>     =

>
> It might work, but I advise you to develop against 2.6.18-rc2 or even
> the Git repository from Linus.
>
>   =

>> 2) Is there some documentation about bluez kernel modules? I need to =

>> understand how modules works to make try to make the patch.
>>     =

>
> Check out the kernel documentation itself. There exists no specific
> BlueZ documentation for kernel programming.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>   =



-- =

______________________________
Fabrizio Guglielmino =

Infit Srl
Software Engineering
Tel. +39 11 7410915
Fax. +39 11 7410915
www.infitsrl.com
C.so Svizzera, 79/8 - Torino
______________________________

Il presente messaggio ed ogni eventuale allegato hanno natura
confidenziale e sono riservati ai destinatari indicati. La diffusione a
terzi e qualsiasi altro uso non autorizzato sono proibiti. I messaggi ed
i relativi allegati possono essere soggetti ad alterazioni. Il mittente
declina ogni responsabilit=E0 per le eventuali alterazioni, modificazioni
o falsificazioni.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
