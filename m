Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A936C6.70209@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] encoding delay, librarifying a2play
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
Date: Sat, 27 Nov 2004 19:24:06 -0700

Hey guys

I was able to encode audio in real time with:

arecord -c 2 -r 44100 -f S16_BE -t au /dev/stdout | ./sbc/sbcenc - | 
./a2play 00:08:F4:30:05:BB

But I estimate the delay is about 300ms. The bluetake encoder dongle was 
bothering me with its delay which is probably under 200ms... I really 
want to get our encoder under 100ms. I read somewhere that 60ms is 
achievable.

I think the place to start to get shorter latency is to write something 
that reads audio itself, uses the encoder library and writes out to the 
headset. Context switches between the 3 userland apps could be wiped 
out. I imagine the app will have command-line args for rate and mode, 
will open/ioctl the audio device appropriately, and then write to the 
headset.

What's the ultimate destination for a2play? A library somewhere? I need 
to break a2play into at least 3 files: headers, library, and a fairly 
simple main(). Is this a good time?

BTW, I did try a class 1 adapter this time and the usable range 
increased from about 8 meters to about 16... it will be better still 
when headsets have class 1.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
