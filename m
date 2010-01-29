Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jan 2010 21:50:42 -0600
From: pigiron@gmx.com
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: headset target seems to be playing but no sound
Message-ID: <20100128215042.4cfc0eb1@atom.pigiron.org>
In-Reply-To: <8396c2281001261928r31d2a5a9w6e4a2a3b5b96221e@mail.gmail.com>
References: <8396c2281001242007n5ae20eccj53d496f1297e5d22@mail.gmail.com>
	<8396c2281001242013y1246bcaaq73ad85ff82f57cab@mail.gmail.com>
	<1264393316.22989.862.camel@pc.interlinx.bc.ca>
	<20100125192334.6725779d@atom.pigiron.org>
	<8396c2281001261928r31d2a5a9w6e4a2a3b5b96221e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 27 Jan 2010 11:28:54 +0800 Chao Deng <dcs1983@gmail.com> wrote:

> On Tue, Jan 26, 2010 at 9:23 AM,  <pigiron@gmx.com> wrote:
> > On Sun, 24 Jan 2010 23:21:56 -0500 "Brian J. Murrell"
> > <brian@interlinx.bc.ca> wrote:
> >
> >> On Mon, 2010-01-25 at 12:13 +0800, Chao Deng wrote:
> >> > Hi, Brain,
> >> >
> >> > I have the same problem like you. Do you find the root cause of it?
> >>
> >> Nope, not a clue.  Unfortunately my posting here didn't get any ideas of
> >> why or what I should do to debug either.  I kinda gave up, yet again, as
> >> I have done many times in the last 2-3 years of simply trying to get a
> >> Bluetooth headset working on Linux.  Sadly it always seems like the
> >> answer is "next [kernel|bluez] release -- it should work great".
> >>
> >> > The kernel I used is 2.6.31, and the bluez is 4.51
> >>
> >> Seems we are in the same boat.
> >>
> >> Sorry I don't have better answers for you.
> >>
> >> b.
> >>
> >
> > Yep. It's unfortunate that no one responded. I've spent many hours digging
> > into this bug, and was hoping that others my have some valid
> > pointers/directions.
> >
> > Anyway, I'm not a Bluez developer, nor do I speak fluent "Bluetooth", but
> > here's what I've found so far...
> >
> > This is not a new bug. Galaha Shine found the crux of the problem back in
> > 2008:
> >
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2008-September/010721.html
> >
> > and after firing up my debugger, this still seems to be the same issue today
> > (at least when I looked at the previous releases).
> >
> > As you may know, headsets can have different bluetooth capabilities
> > described in their profiles. There's the HSP/HFP profiles for doing things
> > like talking on the phone, and then there's the A2DP profile for listening
> > in stereo. And there are others.
> >
> > Brian, you don't state which profile you're using when it fails, but from
> > looking at your hcidump info, it appears like it's HSP or HFP because your
> > data packets are 48 bytes long... which is the MTU size in Bluez for
> > HSP/HFP. When using the A2DP profile (if supported by your headset), the
> > data packets are much larger.
> >
> > Chao, I have 2 sets of Motorola S805's also, and it can do both of those
> > "types" of profiles. If the headset is put into HFP mode, then you
> > experience the joy of this problem. In A2DP mode, it (mostly) works if you
> > only want to listen in stereo.
> >
> > The root cause of the problem (at least from my debugging experience) is
> > that if you are using HSP or HFP mode... and your application is talking
> > directly to ALSA (like "aplay" does)... then your audio data eventually
> > makes it's way to the snd_pcm_rate_commit_area() function in ALSA in 48
> > byte (MTU sized) "chunks". But, if this function receives less than a
> > "slave_size" amount of data, it simply drops it by calling the
> > snd_pcm_rewind() function.
> >
> > To super simplify the problem description, Bluez keeps sending 48 byte
> > "chunks" of audio data, that ALSA happily ignores... nice.
> >
> > Just like Galaha, I'm stuck trying finding a solution. I tried his Bluez
> > patch, but it doesn't work. And so far, I've not been able to get my head
> > wrapped around even a "big picture" of the Bluez SCO data path to find an
> > acceptable alternative. With the goal being to create a (hopefully
> > suitable) patch to some component, somewhere... anywhere. Or possibly
> > there's another solution??? Any help would be appreciated.
> >
> > It *appears* that others *may* be having some success using PulseAudio for
> > this, but I prefer not to go there... just call me stubborn.
> > --
> 
> You are right that I want to test the HSP/HFP profile, and A2DP works
> well for me.
> Thank you for your suggestions for debugging.
> 
> Maybe you don't use 8000Hz mono stream to test, so it needs to
> resample the stream
> to 8Khz to send. But I use a 8khz stream, the program don't go to function
> snd_pcm_rate_commit_area. I trace the calling procedure like following:
>     aplay--->playback (aplay.c)--->pcm_write(aplay.c)--->snd_pcm_writei(pcm.c)
>     --->snd_pcm_ioplug_writei(pcm_ioplug.c)--->snd_pcm_write_areas(pcm.c)--->
>    ioplug_priv_transfer_areas(pcm_ioplug.c)--->bluetooth_hsp_write(pcm_bluetooth.c)
>    --->send
> I think that the audio date has been sent by bluetooth, but still no sound.
> Do you have any ideas?
> --

Good point. I set up a debug environment (again), created some 8k Hz audio
files, and confirmed that you are correct. The code path doesn't go thru the
ALSA snd_pcm_rate_commit_area() function if the audio doesn't need to be
resampled.

But the 8k mono file worked in my environment.

I put the S805 headset into HFP mode and did this:

  $ aplay -D s805 8k.wav
  Playing WAVE '8k.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

and verified that I was using the SCO path (HSP/HFP) by firing up hcidump
during playback:

  # hcidump -x

  [snip]

  < SCO data: handle 1 flags 0x00 dlen 48
      00 21 00 2E 00 30 00 1A 00 00 00 FB 00 F1 00 E3 00 E6 00 E4
      00 DA 00 D0 00 DA 00 E4 00 E8 00 00 00 13 00 0C 00 F8 00 F0
      00 07 00 28 00 3F 00 54
  < SCO data: handle 1 flags 0x00 dlen 48
      00 38 00 07 00 E4 00 E2 00 05 00 20 00 05 00 E0 00 C5 00 B6
      00 D3 00 F8 00 0E 00 04 00 E3 00 F0 00 18 00 32 00 4A 00 4C
      00 2C 00 01 00 F0 00 01

  [snip]

It also worked with a 8k Hz, S16_LE, 2 channel audio file:

  $ aplay -D s805 big8k.wav
  Playing WAVE 'big8k.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo

This got me excited enough to try this:

  $ arecord -D s805 junk.wav
  Recording WAVE 'junk.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

But alas, playing back 'junk.wav' thru a known good audio card only produced a
"ticking" sound. I haven't dug any deeper into this yet.

It also still failed to play a 44.1k Hz, S16_LE, 2 channel audio file. The
debugger showed that it's still the same problem Galaha found (i.e. resampling
doesn't work).

Not sure why 8k Hz mono is failing for you.

I put a breakpoint at bluetooth_hsp_write(), then played the 8K Hz mono file,
and here's the stack trace on my box:

(gdb) where
#0  bluetooth_hsp_write (io=0x805fb08, areas=0x80568c0, offset=0, size=1000)
    at audio/pcm_bluetooth.c:906
#1  0xb7f83d09 in ioplug_priv_transfer_areas (pcm=0x8060cd0, areas=0x80568c0,
    offset=0, size=1000) at pcm_ioplug.c:546
#2  0xb7f84328 in snd_pcm_ioplug_mmap_commit (pcm=0x8060cd0, offset=0,
    size=1000) at pcm_ioplug.c:615
#3  0xb7f355e7 in snd_pcm_mmap_commit (pcm=0x8060cd0, offset=0, frames=1000)
    at pcm.c:6490
#4  0xb7f4565b in snd_pcm_plugin_write_areas (pcm=0x8061ed8, areas=0xbffff650,
    offset=0, size=1000) at pcm_plugin.c:290
#5  0xb7f359f5 in snd1_pcm_write_areas (pcm=0x8061ed8, areas=0xbffff650,
    offset=0, size=1000, func=0xb7f45505 <snd_pcm_plugin_write_areas>)
    at pcm.c:6656
#6  0xb7f45a26 in snd_pcm_plugin_writei (pcm=0x8061ed8, buffer=0x8060f50,
    size=1000) at pcm_plugin.c:361
#7  0xb7f2ca75 in _snd_pcm_writei (pcm=0x8060e28, buffer=0x8060f50, size=1000)
    at pcm_local.h:516
#8  0xb7f2df29 in snd_pcm_writei (pcm=0x8060e28, buffer=0x8060f50, size=1000)
    at pcm.c:1247
#9  0x0804f30d in pcm_write (
    data=0x8060f50 "\200", '\177' <repeats 11 times>"\200,
\200\200\177\177\177\177\200\200\177\177\200\200\200\200\177\200\201\202\177|\200\201\177~\177\202\201~~\205\203x}\205\200{z\201\205}z\202\203\177~\200\204\204\201}{~~}y{\202\202||\205\211\203z\200\211\204z}\206\204}w}\206\177x\200\205\200}~\203\203|z}|uux{{y~\203\205\211\216\223\226\224\214\206\203{rnnpv{}\204\204\206\213\213\206\203~xtlknmpxz|\201\213\226\244\242\212\224\230\205k\\nqXYx\201v\177\232\266\240x\213\235\205e\\mo_\\ouoz\222\227\206y}\223\262\271\214w\226\232|W[\203uRf\212"...,
count=1000) at aplay.c:1529 #10 0x08051790 in playback_go (fd=9, loaded=0,
count=45898, rtype=2, name=0xbffffbb9 "./8k.wav") at aplay.c:2272
#11 0x08051b30 in playback (name=0xbffffbb9 "./8k.wav") at aplay.c:2332
#12 0x0804bd96 in main (argc=4, argv=0xbffffa24) at aplay.c:659

It's pretty much the same path you describe, execpt that it includes the
*_mmap_commit() calls.


Here's my setup:

>From ~/.asoundrc:

  pcm.s805 {
     type plug
     slave {
           pcm {
               type bluetooth
               device AA:BB:CC:DD:EE:FF
               profile "auto"
           }
     }
     hint {
          show on
          description "Motorola S805 bluetooth headset"
     }
  }

Everything is commented out in /etc/bluetooth/audio.conf except for these:

  [General]
  SCORouting=HCI
  [Headset]
  HFP=true
  MaxConnected=3

I haven't changed any of other config files in /etc/bluetooth/*.

Version Levels:

  alsa-lib   1.0.22
  alsa-utils 1.0.22
  bluez      4.59

The bluetooth USB computer dongle:

  # hciconfig -a
  hci0:   Type: USB
        BD Address: AA:BB:CC:DD:EE:FF ACL MTU: 1021:7 SCO MTU: 64:1
        UP RUNNING PSCAN
        RX bytes:64829124 acl:41 sco:1271103 events:139 errors:0
        TX bytes:3077 acl:43 sco:0 commands:85 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'atom-0'
        Class: 0x4a0104
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.1 (0x4) HCI Rev: 0x5332 LMP Ver: 2.1 (0x4) LMP Subver: 0x420e
        Manufacturer: Broadcom Corporation (15)

Keep me posted (maybe privately???) if you find any good nuggets.
