Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0808300011k1d65b69fkb58f33c256aabf0f@mail.gmail.com>
References: <e96e9eeb0808250349s6491c78bub21ee742c2e1a795@mail.gmail.com>
	<e96e9eeb0808250356u595a3005t6a0046ee5fc67622@mail.gmail.com>
	<alpine.LNX.1.10.0808290445110.26779@nge2.ngu.pk>
	<e96e9eeb0808300011k1d65b69fkb58f33c256aabf0f@mail.gmail.com>
Date: Sat, 30 Aug 2008 11:34:35 +0200
Message-Id: <1220088875.7145.58.camel@californication>
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

> > I've tried obex-data-server and obexd, but I couldn't get either one working.
> 
> maybe they only give dbus api ? and they are not meant to be used from
> the command line ?

obexd is only a server and it needs some interaction with the UI to some
degree for authorization callbacks and so on. Feel free to propose
patches since we can add switches for a fully command line based use
cases.

The current assumption is it runs in the user session and hence
requiring a D-Bus session bus. However the end goal is to give the
choice to run it at system level if you don't have a fine grained
security model anyway.

For these case it really helps if you just state what you wanna do with
it. Otherwise we will focus on our current plans and do everything else
when we have time. Also patches are always welcome.

> > I asked on the list but there wasn't a reply.
> 
> I also tried on IRC but no one responded..  :(

Be patient. Even while some of us look online 24/7, we are not :)

> > I also use obexftp and obexfs.
> 
> What is obexfs btw ?

OpenOBEX into FUSE integration.

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
