Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] encoding delay, librarifying a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A936C6.70209@xmission.com>
References: <41A936C6.70209@xmission.com>
Content-Type: text/plain
Message-Id: <1101624988.18467.32.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 28 Nov 2004 07:56:28 +0100

Hi Brad,

> I was able to encode audio in real time with:
> 
> arecord -c 2 -r 44100 -f S16_BE -t au /dev/stdout | ./sbc/sbcenc - | 
> ./a2play 00:08:F4:30:05:BB
> 
> But I estimate the delay is about 300ms. The bluetake encoder dongle was 
> bothering me with its delay which is probably under 200ms... I really 
> want to get our encoder under 100ms. I read somewhere that 60ms is 
> achievable.
> 
> I think the place to start to get shorter latency is to write something 
> that reads audio itself, uses the encoder library and writes out to the 
> headset. Context switches between the 3 userland apps could be wiped 
> out. I imagine the app will have command-line args for rate and mode, 
> will open/ioctl the audio device appropriately, and then write to the 
> headset.

the pipes and too small buffers can be really a problem here.

> What's the ultimate destination for a2play? A library somewhere? I need 
> to break a2play into at least 3 files: headers, library, and a fairly 
> simple main(). Is this a good time?

I propose a generic AVDTP library that will handle all AVDTP related
things. I checked in some basic code into the avdtp directory. My idea
is to make the library look like a socket interface so we can later move
things very easy to a kernel AVDTP implementation.

The a2play is then only a frontend for the AVDTP library, SBC library
and some audio input library (libmad for exmaple). And I think we should
also include the rcplay stuff into it and provide an alternate RFCOMM
streaming with an extra parameter.

However the final goal should be an ALSA library extension like their
JACK plugin. But from my first tests I realized that it is impossible to
create such an extension outside the ALSA PCM directory. I must talk
with the ALSA developers about that issue.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
