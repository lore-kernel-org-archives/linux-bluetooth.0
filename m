Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100707062329n5999472dv9159d5f3700dde80@mail.gmail.com>
Date: Sat, 7 Jul 2007 03:29:57 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300707061644p5483ff3t8c6cb972e867e1d9@mail.gmail.com>
MIME-Version: 1.0
References: <46852386.8050608@free.fr> <468CE233.8000909@free.fr>
	<d89ddf300707050940n7ffece6cs2ec5836def9e3ae9@mail.gmail.com>
	<468DF298.5010205@free.fr>
	<2d5a2c100707060612g6ed3a543g9f36b6db49a97a95@mail.gmail.com>
	<468E446A.1000204@free.fr> <468E46E5.2050206@access-company.com>
	<2d5a2c100707060801s413d8bdclb0b25a4f5a340773@mail.gmail.com>
	<468E76DD.6070303@free.fr>
	<d89ddf300707061644p5483ff3t8c6cb972e867e1d9@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Brad,

On 7/6/07, Brad Midgley <bmidgley@gmail.com> wrote:
> Although this is really cool to deliver mp3 to the headset (less cpu
> load, less transcoding noise), it might go too far down the road of an
> early optimization for the case of a single audio client.
>
> Mikko L at Nokia basically said they wouldn't consider anything along
> these lines since it gets so complicated when a system sound needs to
> interrupt mp3 playback. Do you:
>
>  - mix two mp3 streams together (technically possible)
>  - reconfigure the set for sbc and encode the streams to sbc (best
> case is a delay, worst case a crash in the set during reconfiguration)
>  - stop the mp3 player and play the system sound mp3 instead (tricky)
>
> It doesn't help that there's not much notion of a sound "card" that
> can natively decode mp3. The audio servers don't account for this
> possibility at all.

I wont consider going with gstreamer set of elements instead of an
alsa plugin for system wide, as you said we might have some
technical challengers and as a sound "card" this is not exactly a
good idea. So as a system wide solution we must have a alsa plugin
that just deliver sbc codec.

A future work perhaps we may be possible to deliver something more
flexible to application, but in this case application would have to handle
the stream by it' s own.

Why Im already considering this advanced usage? We have an ipc
system that should be flexible enough to be able to work with
those applications. I guess it should be possible for someone to
add native support for multimedia frameworks such as gstreamer,
but the support itself is outside the scope of bluez.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
