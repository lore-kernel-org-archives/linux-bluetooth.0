Return-Path: <cyrus@holtmann.org>
Message-ID: <477CF705.1090006@kameleon-media.com>
Date: Thu, 03 Jan 2008 15:53:57 +0100
From: Laurent BARBIER <lbarbier@kameleon-media.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <d89ddf300801021040o28e16943t2c51ac0190bd4e91@mail.gmail.com>	<E21A90CDB9591542899EFC7FB4ED5CC90776A695@tfmail02.TFMAIL.COM>
	<359782e70801030510p5abedbe4m6d7e129d8a5b0692@mail.gmail.com>
In-Reply-To: <359782e70801030510p5abedbe4m6d7e129d8a5b0692@mail.gmail.com>
Subject: Re: [Bluez-users] slave - slave talk in a piconet
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

When you wan't to make B talk to C all need to be forward from and to A. =

Something like brctl do the job quite sufficiently.
Have a look there : http://bluez.sourceforge.net/contrib/HOWTO-PAN
section "Ethernet Bridging"

Laurent

bsd user a =E9crit :
> So, B or C has no knowledge about each other when they are slaves of =

> master A, right? Then, can I say if B want to talk with C, they need =

> higher level protocol support, such as telnet, ftp. And, all data =

> exchange will be forwarded by Master A. right?
>
> Thanks!
>
> On Jan 3, 2008 9:07 AM, guoyun <guoyun@techfaith.cn =

> <mailto:guoyun@techfaith.cn>> wrote:
>
>     Hi, Brad
>
>     > hey
>     >
>     > > If there is a piconet that has 2 slave B,C, the master is A.
>     Does B
>     > > know the existence of C? can B talk to C directly without
>     > A(master)'s intervention?
>     >
>     > if they did talk to each other directly, one would have to be
>     > master and you'd have a scatternet.
>
>     one bluetooth could be in two or more piconet, but it just can
>     play as slave _not_ master for the bluetooth clock.
>
>     Please refer to Core SPEC. chapter 4.1. Piconet topology.
>
>     BRs
>     Yun
>
>
>     ---------------------------------------------------------------------=
----
>     This SF.net email is sponsored by: Microsoft
>     Defy all challenges. Microsoft(R) Visual Studio 2005.
>     http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>     _______________________________________________
>     Bluez-users mailing list
>     Bluez-users@lists.sourceforge.net
>     <mailto:Bluez-users@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/bluez-users
>     <https://lists.sourceforge.net/lists/listinfo/bluez-users>
>
>
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   =


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
