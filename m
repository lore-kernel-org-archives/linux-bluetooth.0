Return-Path: <cyrus@holtmann.org>
Message-ID: <48008B46.3080601@suse.de>
Date: Sat, 12 Apr 2008 12:13:26 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <194c6ea30804110133x276fd249p245cb6cbfd699f48@mail.gmail.com>
	<E673024B-BC5B-44C7-806D-38CA69FD680E@holtmann.org>
In-Reply-To: <E673024B-BC5B-44C7-806D-38CA69FD680E@holtmann.org>
Subject: Re: [Bluez-users] bluez3.30 audio/serial plugin issue
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

Marcel Holtmann wrote:
> it seems the solution to this is to use --enable-glib. For some reason  =

> our eglib plugin loader doesn't work always. I never saw this problem  =

> and still can't reproduce it.

If you want to debug it, i could e.g. provide you with a qemu image of
openSUSE FACTORY where it is reproducible.

OTOH, if eglib is going away anyway, maybe there are more important things =
to
debug ;-)
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
