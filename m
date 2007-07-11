Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300707111456s5d53d26dq5074c6aac0920501@mail.gmail.com>
Date: Wed, 11 Jul 2007 15:56:06 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46951480.3060107@free.fr>
MIME-Version: 1.0
References: <46852386.8050608@free.fr> <468DF298.5010205@free.fr>
	<2d5a2c100707060612g6ed3a543g9f36b6db49a97a95@mail.gmail.com>
	<468E446A.1000204@free.fr> <468E46E5.2050206@access-company.com>
	<2d5a2c100707060801s413d8bdclb0b25a4f5a340773@mail.gmail.com>
	<468E76DD.6070303@free.fr>
	<d89ddf300707061644p5483ff3t8c6cb972e867e1d9@mail.gmail.com>
	<2d5a2c100707062329n5999472dv9159d5f3700dde80@mail.gmail.com>
	<46951480.3060107@free.fr>
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
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

Fabien

> The only valid case of MP3 streaming is the one when you build a
> dedicated audio path between the application(multimedia player) and the
> hardware device(bt headset).

ok... this makes sense. I started hacking the old "a2play" to detect
the mp3 decoder but never did get it to send mp3 directly. A symbian
developer told me he would have a whack at it but I never heard if it
worked for him.

> However a decicated gstreamer support would be nice to have, too.

especially if you are trying to do something that is too complicated for alsa.

> I guess one of those days i'm gonna hack a gstreamer element just for
> fun :-)... and to prove it's feasible :-)

some of the guys at the uni in Brazil told me the same thing :)

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
