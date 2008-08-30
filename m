Return-Path: <cyrus@holtmann.org>
Message-ID: <e96e9eeb0808300011k1d65b69fkb58f33c256aabf0f@mail.gmail.com>
Date: Sat, 30 Aug 2008 10:11:32 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <alpine.LNX.1.10.0808290445110.26779@nge2.ngu.pk>
MIME-Version: 1.0
References: <e96e9eeb0808250349s6491c78bub21ee742c2e1a795@mail.gmail.com>
	<e96e9eeb0808250356u595a3005t6a0046ee5fc67622@mail.gmail.com>
	<alpine.LNX.1.10.0808290445110.26779@nge2.ngu.pk>
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

Thank you jayjwa !

On Fri, Aug 29, 2008 at 3:13 PM, jayjwa <jayjwa@atr2.ath.cx> wrote:
> I've tried obex-data-server and obexd, but I couldn't get either one working.

maybe they only give dbus api ? and they are not meant to be used from
the command line ?

> I asked on the list but there wasn't a reply.

I also tried on IRC but no one responded..  :(

> The one I use currently is one I
> found, made by someone, and patched a bit to compile here by myself. Credits
> are in the files, but I can't remember the author right now. It has both
> server and client. It is as it is, I can't say how functional or secure it is,
> but it meets my needs. You'll need openobex, glib, bluez, zlib, pcre and
> be able to compile stuff with it.

Thanks I will try it

> I also use obexftp and obexfs.

What is obexfs btw ?

Did you succeed to cross compile obexftp ? (I succeeded to 'make' it,
but when i tried to 'make install' it weirdly failed)

thank you
voni

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
