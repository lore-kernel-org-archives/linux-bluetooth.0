Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300809131212h2e1fbfb6k4d4d50763b2a0299@mail.gmail.com>
Date: Sat, 13 Sep 2008 13:12:15 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <f21e7dc80809131154s7d0b7e99t23201743f65e1f50@mail.gmail.com>
MIME-Version: 1.0
References: <f21e7dc80809131026g15f66f3eq81980dc507607065@mail.gmail.com>
	<1221330440.6695.53.camel@californication>
	<f21e7dc80809131132udb89654hf2b76149b4b03203@mail.gmail.com>
	<1221331676.6695.55.camel@californication>
	<f21e7dc80809131154s7d0b7e99t23201743f65e1f50@mail.gmail.com>
Subject: Re: [Bluez-devel] A2DP over DBUS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Choi

> That's interesting. What about platforms like Android that are only
> Java (If I am not wrong) ? Can they connect directly to those sockets
> from Java applications ?

Check the android API docs. I'd heard the API for bluetooth was
incomplete in the latest android but I haven't read up.

The sun embedded java APIs specify a way to run L2CAP (at least) using
java. Can't remember about SCO. Android breaks with the sun API (for
good reason).

The right way to do it in android would be integrating the bt audio
services with their multimedia hooks, so you wouldn't deal with the
underlying implementation.

-- 
Brad

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
