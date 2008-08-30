Return-Path: <cyrus@holtmann.org>
Message-ID: <e96e9eeb0808300016l7b0118cbj13c8e410cd8dcb95@mail.gmail.com>
Date: Sat, 30 Aug 2008 10:16:09 +0300
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

On Fri, Aug 29, 2008 at 3:13 PM, jayjwa <jayjwa@atr2.ath.cx> wrote:
> I've tried obex-data-server and obexd, but I couldn't get either one working.
> I asked on the list but there wasn't a reply. The one I use currently is one I

Also there is an 'obex' project in the bluez cvs, i think it is obex
client, but i can't use it because it requires libxml and we use
libexpat in our embedded system (libxml is bloated!)

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
