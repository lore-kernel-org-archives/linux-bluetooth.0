Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <1140.216.47.50.197.1168454364.squirrel@webmail.feline-soul.net>
In-Reply-To: <1168450887.5241.2.camel@violet>
References: <042F6BC7-A46A-4D9D-8810-1C66347B60C7@gmail.com>
	<45A5105B.7050705@xmission.com>
	<6D8DB734-3C02-4CED-80CE-F770D73FD6BA@gmail.com>
	<45A51999.3010108@xmission.com>
	<ABCE48BD-8B79-4C00-9ADE-B7DDB0940DE2@gmail.com>
	<45A51EC4.4030803@glidos.net>
	<076A94F3-C853-4A56-A4E1-5B5259353D5F@gmail.com>
	<1168450887.5241.2.camel@violet>
Date: Wed, 10 Jan 2007 11:39:24 -0700 (MST)
From: "Bearcat M. Sandor" <linux@feline-soul.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] What happened with pin_helper (hcid.conf)?
Reply-To: linux@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

The reason this is being discussed to death is that there is no
documention telling us how to apply a pass code. If you don't have
documentation be prepared for things to be discussed.  Postings on a
mailing list is not documentation.

I realise that the bluez agent in gnome may be the desired way to go, but
as a linux user surely you realise that not all of us use Gnome.  Since
the bluez activity is happening at a lower level, i feel that the gui apps
should be simply an optional interface to the process not the idea process
itself.

That said, thank you for the great work on this stack. It is very
appreciated.

Bearcat M. Sandor
> this has been discussed to death. Starting with bluez-utils-3.x the PIN
> helper concept has been deprecated and you have to provide a passkey
> agent. Nobody said that this agent has to use a display. Check the
> example passkey-agent.c in the source code.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
