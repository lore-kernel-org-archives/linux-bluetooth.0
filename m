Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0808300144y19c285a0l7156e6fb9a415547@mail.gmail.com>
References: <e96e9eeb0808250349s6491c78bub21ee742c2e1a795@mail.gmail.com>
	<e96e9eeb0808250356u595a3005t6a0046ee5fc67622@mail.gmail.com>
	<alpine.LNX.1.10.0808290445110.26779@nge2.ngu.pk>
	<e96e9eeb0808300011k1d65b69fkb58f33c256aabf0f@mail.gmail.com>
	<1220088875.7145.58.camel@californication>
	<e96e9eeb0808300144y19c285a0l7156e6fb9a415547@mail.gmail.com>
Date: Sat, 30 Aug 2008 12:50:26 +0200
Message-Id: <1220093426.7145.86.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] easiest way to get OBEX support (client/server) ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Voni,

> > The current assumption is it runs in the user session and hence
> > requiring a D-Bus session bus. However the end goal is to give the
> > choice to run it at system level if you don't have a fine grained
> > security model anyway.
> >
> > For these case it really helps if you just state what you wanna do with
> > it. Otherwise we will focus on our current plans and do everything else
> > when we have time. Also patches are always welcome.
> 
> I need to be able to demonstrate OBEX profiles on a bluez-based
> embedded system which is very early in its development. No GUI
> whatsover. I only have the shell. I have DBUS obviously (although I
> only run system session currently). It's really important because this
> way managers here will be able to choose between bluez and other
> stacks.

just go into the code and replace SESSION with SYSTEM and create a D-Bus
security policy file for org.openobex.

> I guess that currently my only option is obexftp  ?  Unfortunately it
> doesn't cross compile cleanly.. (I did manage to cross compile
> openobex without a problem though).
> 
> IIRC the obex project in the bluez cvs worked pretty nice on a PC.
> unfortunately we use expat and not libxml so I can't use it on my
> embedded system..

I am not touching that code anymore, but that could be easily fixed :)

You will have to do some development since you can't expect that you can
just take open source stuff without any integration work. And that is
exactly what you have to do, integrate it. If patches come up during
this, then send them upstream and we likely include them and then next
time (next product) the integration work goes down.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
