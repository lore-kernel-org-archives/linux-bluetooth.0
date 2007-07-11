Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46951480.3060107@free.fr>
Date: Wed, 11 Jul 2007 19:33:52 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46852386.8050608@free.fr>
	<468CE233.8000909@free.fr>	<d89ddf300707050940n7ffece6cs2ec5836def9e3ae9@mail.gmail.com>	<468DF298.5010205@free.fr>	<2d5a2c100707060612g6ed3a543g9f36b6db49a97a95@mail.gmail.com>	<468E446A.1000204@free.fr>
	<468E46E5.2050206@access-company.com>	<2d5a2c100707060801s413d8bdclb0b25a4f5a340773@mail.gmail.com>	<468E76DD.6070303@free.fr>	<d89ddf300707061644p5483ff3t8c6cb972e867e1d9@mail.gmail.com>
	<2d5a2c100707062329n5999472dv9159d5f3700dde80@mail.gmail.com>
In-Reply-To: <2d5a2c100707062329n5999472dv9159d5f3700dde80@mail.gmail.com>
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

Hi All,

Please find below some comments

>> Mikko L at Nokia basically said they wouldn't consider anything along
>> these lines since it gets so complicated when a system sound needs to
>> interrupt mp3 playback. Do you:
>>
>>  - mix two mp3 streams together (technically possible)
>>  - reconfigure the set for sbc and encode the streams to sbc (best
>> case is a delay, worst case a crash in the set during reconfiguration)
>>  - stop the mp3 player and play the system sound mp3 instead (tricky)

I agree with you : none of those are acceptable. However you may have 
missed something : MP3 is not to be used as an output format if 
bluetooth is plugged to a sound mixing daemon :-).
In this case SBC is to be used :-)

The only valid case of MP3 streaming is the one when you build a 
dedicated audio path between the application(multimedia player) and the 
hardware device(bt headset). In this case there is no notion of "system 
sounds" that would appear and would need to be mixed in :-)

>>
>> It doesn't help that there's not much notion of a sound "card" that
>> can natively decode mp3. The audio servers don't account for this
>> possibility at all.
> 
> I wont consider going with gstreamer set of elements instead of an
> alsa plugin for system wide

My remark was not one against the other.
Obviously there are so many ALSA applications that an ALSA option is a 
must have. :-)
However a decicated gstreamer support would be nice to have, too.

, as you said we might have some
> technical challengers and as a sound "card" this is not exactly a
> good idea. So as a system wide solution we must have a alsa plugin
> that just deliver sbc codec.

Agreed. Alsa plugin should implement sbc codec only (no mp3 needed here 
:-) )

> 
> A future work perhaps we may be possible to deliver something more
> flexible to application, but in this case application would have to handle
> the stream by it' s own.

Like a GStreamer based application for instance, that is already used to 
build its own media pipeline :-)

> 
> Why Im already considering this advanced usage? We have an ipc
> system that should be flexible enough to be able to work with
> those applications. 

Agreed. We should be able to plug whatever system using this ipc 
mechanism, including:
   - an ALSA plugin
   - a GStreamer bt element
   - a sound server


> I guess it should be possible for someone to
> add native support for multimedia frameworks such as gstreamer,
> but the support itself is outside the scope of bluez.
> 

I guess one of those days i'm gonna hack a gstreamer element just for 
fun :-)... and to prove it's feasible :-)

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
