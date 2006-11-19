Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45608C40.3050307@free.fr>
Date: Sun, 19 Nov 2006 17:54:24 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455CCAF4.8020007@silicom.fr><7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA7@eumonex01.palmsource.com>	<455EE00B.80504@free.fr>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EAE@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EAE@eumonex01.palmsource.com>
Subject: Re: [Bluez-devel] RE : RE : SCO on bluez : some architectural tips
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

> =

> We won't be able to use +/- in a game or system sound!

Of course we can't :-). But a2dp has never been designed for that =

either. It has been designed so that handset makers be able to stream =

music over headsets.

> =

>> Let' say you use a unix socket. Sco sockets have a fixed queue length
>> (something like 1 kb if i remember : this should be checked). Each SCO
>> packets is 48 bytes, with 'lasts' 3 msec. Which means we can fit
>> 20 packets, or 60 ms data.
>> Congratulations, we just added more delay that the network itself !! ;-)
> =

> Did you mean Unix socket have a fixed queue length? =


Yes they did. I had to dig into kernel sources to find that :-)

> If buffering takes place
> inside the SCO socket, then work is due to the socket itself. In both cas=
es,
> I would be surprised if this wasn't tunable.

SCO socket queue is tunable, provided you use my flow control patch... =

otherwise it's not.

> =

> Nevertheless, there is no need to know the buffer size : if the buffer was
> 1 Mb long would you wait for it to be full before reading data? =


Frederic, this is not the point. Of course we won't wait the buffer to =

be full before sending audio data to the remote device.
But if buffer is 1 MB long, then the application that plays sound will =

fill up the buffer faster that the device reads. Which means at one =

point or another, the buffer will be full, thus introducing audio =

latency equal to the time it takes to empty the buffer

> =

> Last, benchmarks on the net measure unix socket latency using =B5s unit.
> =


That easy to say. Just give it a try and you might have some surprises :-)

> =

> Probably the best way to figure out the best architecture is to have both=
 and
> measure.

I 100% agree with that. :-)

I can provide wome source code that doe just that to whoever is =

interested in testing this daemon approach.

Cheers,

Fabien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
