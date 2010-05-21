Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 21 May 2010 13:16:22 +0200
Subject: RE: How to use a2dp avrcp controls
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E0332D6012A@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E032D4EB9A2@NL0105EXC01V01.eur.slb.com>
 <44EE5C37ADC36343B0625A05DD408C4850DA702DD0@CHEXMB-01.global.atheros.com>
 <6AC5A55546F64545AE996F8200E3AC4E032D544173@NL0105EXC01V01.eur.slb.com>
  <6AC5A55546F64545AE996F8200E3AC4E0332918F4C@NL0105EXC01V01.eur.slb.com>
 <6AC5A55546F64545AE996F8200E3AC4E0332AC0248@NL0105EXC01V01.eur.slb.com>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E0332AC0248@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > > -----Original Message-----
> > > From: John Frankish
> > > Sent: Thursday, 06 May, 2010 12:48
> > > To: 'linux-bluetooth-owner@vger.kernel.org'
> > > Subject: RE: How to use a2dp avrcp controls
> > >
> > > > >
> > > > > Although I can pair with and play music to a set of a2dp
> > > > > headphones without problems, I cannot figure out how to enable the "track skip"
> > > > > and similar remote controls on the headphones.
<snip>
> > > 1. compiling bluez-4.63 did not install /usr/local/etc/bluetooth/audio.conf
> > > - is this depreciated or is it required to get a2dp/avrcp working?

In my testing audio.conf is apparently not required.

Since I found the solution to my problem outside of "bluez space", it is not strictly relevant to this list, but I'm posting it here in case others find it of help.

After using "blueman" to pair with my Bluetooth headphones, setting them as trusted and setting them up as an a2dp sink, dmesg shows the following:

input: 00:1B:66:00:31:88 as /devices/virtual/input/input11

and..

$ sudo evtest /dev/input/event11
Input driver version is 1.0.0
Input device ID: bus 0x5 vendor 0x0 product 0x0 version 0x0
Input device name: "00:1B:66:00:31:88"
Supported events:
  Event type 0 (Sync)
  Event type 1 (Key)
    Event code 163 (NextSong)
    Event code 165 (PreviousSong)
    Event code 166 (StopCD)
    Event code 168 (Rewind)
    Event code 200 (PlayCD)
    Event code 201 (PauseCD)
    Event code 208 (Fast Forward)
  Event type 2 (Relative)
  Event type 20 (Repeat)
Testing ... (interrupt to exit)
Event: time 1274200254.037702, type 1 (Key), code 163 (NextSong), value 1
Event: time 1274200254.037709, -------------- Report Sync ------------
Event: time 1274200254.092604, type 1 (Key), code 163 (NextSong), value 0
Event: time 1274200254.092608, -------------- Report Sync

But..

$ xev | sed -n 's/^.*keycode *\([0-9]\+\).*$/keycode \1 = /p' | uniq
...
keycode 144 =

So, using xev to make up an .Xmodmap that looks like this:

keycode 144 = XF86AudioPrev
keycode 153 = XF86AudioNext
keycode 164 = XF86AudioStop
keycode 168 = XF86AudioPlay

i.e. completely different to that reported by evtest...

and using xset to stop the AVRCP key press repeating at warp speed:

xset -r 144 -r 153 -r 164 -r 168

then the sequence is:

AVRCP signal -> bluetoothd -> uinput -> X -> Xmodmap -> rhythmbox

..and rhythmbox responds correctly to play, stop, next track and previous track when pressed on the remote Bluetooth headphones controls  :)
