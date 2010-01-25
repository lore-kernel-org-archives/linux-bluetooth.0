Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8396c2281001242007n5ae20eccj53d496f1297e5d22@mail.gmail.com>
References: <8396c2281001242007n5ae20eccj53d496f1297e5d22@mail.gmail.com>
Date: Mon, 25 Jan 2010 12:13:25 +0800
Message-ID: <8396c2281001242013y1246bcaaq73ad85ff82f57cab@mail.gmail.com>
Subject: Re: headset target seems to be playing but no sound
From: Chao Deng <dcs1983@gmail.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Brain,

I have the same problem like you. Do you find the root cause of it?
The kernel I used is 2.6.31, and the bluez is 4.51. I use Motorola
S805 for testing.


>>Hi all,
>
>>
>>I am using bluez 4.51.  After much fiddling, I seem to have my audio
>>headset doing something -- something other than reporting errors anyway.
>>
>>I can do:
>>
>>$ aplay /mnt/mp3/bad_mouth.wav -Dplug:bluetoothraw
>
>>Playing WAVE '/mnt/mp3/bad_mouth.wav' : Signed 16 bit Little Endian, Rate
>> 44100 Hz, \
>>Stereo
>
>>to the device defined as:
>
>>pcm.bluetoothraw {
>
>>   type bluetooth
>>   device 00:1A:45:1B:19:89
>>}
>
>>and aplay appears to be doing something and
>
>>$ hcidump -t -X -V
>
>>reports lots of:
>
> 2009-12-31 00:08:57.233899 > SCO data: handle 1 flags 0x00 dlen 48
>
>
>     0000: fd ff e6 ff af ff 4e ff  41 ff 5a ff 20 ff 53 ff  ......N.A.Z. .S.
>     0010: a0 ff 6b ff 89 ff bc ff  5d ff 85 ff 3c ff d9 fe  ..k.....]...<...
>     0020: 2b ff 28 ff 58 ff 53 ff  1b ff 3c ff 29 ff 49 ff  +.(.X.S...<.).I.
>
>
> 2009-12-31 00:08:57.233901 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: 9b ff b1 ff a2 ff 71 ff  b5 ff 9f ff 52 ff fa fe  ......q.....R...
>     0010: 8e fe 4e ff 98 ff ed ff  13 00 88 ff 91 ff f3 fe  ..N.............
>
>
>     0020: 2f ff c2 ff 6d ff 95 ff  62 ff d2 fe ec fe 61 ff  /...m...b.....a.
> 2009-12-31 00:08:57.233903 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: 5e ff 2b ff 26 ff 01 ff  a5 ff 9c ff 5a ff 2f ff  ^.+.&.......Z./.
>
>
>     0010: 8b fe 1b ff c7 ff fa ff  f0 ff 53 ff e1 fe 28 ff  ..........S...(.
>     0020: b7 ff be ff 41 ff 55 ff  16 ff 3f ff de ff fa fe  ....A.U...?.....
> 2009-12-31 00:08:57.233905 > SCO data: handle 1 flags 0x00 dlen 48
>
>
>     0000: 0f ff a1 ff 66 ff f6 ff  06 00 c8 ff 75 ff 16 ff  ....f.......u...
>     0010: f4 fe f0 fe e5 fe d3 fe  eb fe 5d ff e5 ff e9 ff  ..........].....
>     0020: 84 ff 7b ff c7 ff de ff  ae ff 85 ff a1 ff 58 ff  ..{...........X.
>
>
> 2009-12-31 00:08:57.243898 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: f0 fe 3c fe a6 fe 49 ff  3d ff c0 ff 93 ff 73 ff  ..<...I.=.....s.
>     0010: 41 ff 85 ff c5 ff 67 ff  63 ff 2c ff 1a ff 23 ff  A.....g.c.,...#.
>
>
>     0020: 51 ff af ff 28 ff d5 fe  50 ff 83 ff e8 ff e4 ff  Q...(...P.......
> 2009-12-31 00:08:57.243901 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: 01 ff 15 ff d0 fe ba fe  95 ff a2 ff b7 ff ed ff  ................
>
>
>     0010: 7e ff a9 ff a1 ff e5 fe  3b ff 70 ff 63 ff 7f ff  ~.......;.p.c...
>     0020: 3c ff 2b ff be fe ee fe  58 ff 7c ff 40 ff fb fe  <.+.....X.|.@...
> 2009-12-31 00:08:57.243903 > SCO data: handle 1 flags 0x00 dlen 48
>
>
>     0000: 39 ff 34 ff b6 ff c1 ff  7d ff a0 ff 6a ff 79 ff  9.4.....}...j.y.
>     0010: 37 ff 0c ff 4d ff 15 ff  43 ff 66 ff 3e ff 71 ff  7...M...C.f.>.q.
>     0020: 8e ff 8c ff 06 ff d4 fe  0e ff 2e ff 8a ff 24 ff  ..............$.
>
>
> 2009-12-31 00:08:57.253914 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: da fe 57 ff b3 ff bf ff  7f ff 49 ff 41 ff ee fe  ..W.......I.A...
>     0010: 08 ff 91 ff a2 ff 9d ff  48 ff da fe 52 ff 55 ff  ........H...R.U.
>
>
>     0020: 87 ff 98 ff 25 ff 1d ff  35 ff b9 ff 83 ff b1 ff  ....%...5.......
> 2009-12-31 00:08:57.253918 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: 7d ff 37 ff 5e ff 40 ff  3b ff 08 ff 01 ff dc fe  }.7.^.@.;.......
>
>
>     0010: 15 ff 1c ff 8b ff 8b ff  40 ff 90 ff 3a ff c6 ff  ........@...:...
>     0020: 71 ff 4a ff 88 ff 3c ff  bc ff 3e ff e4 fe fe fe  q.J...<...>.....
> 2009-12-31 00:08:57.253920 > SCO data: handle 1 flags 0x00 dlen 48
>
>
>     0000: f9 fe 2c ff a2 ff bb ff  89 ff 65 ff 21 ff 62 ff  ..,.......e.!.b.
>     0010: b9 ff b4 ff 48 ff f4 fe  42 ff 86 ff ad ff 53 ff  ....H...B.....S.
>     0020: 20 ff 00 ff dd fe 71 ff  79 ff 59 ff a6 ff 8f ff   .....q.y.Y.....
>
>
> 2009-12-31 00:08:57.263898 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: 57 ff c2 ff a8 ff d9 fe  eb fe 5a ff 89 ff 71 ff  W.........Z...q.
>     0010: 1f ff 1e ff 27 ff 3f ff  3e ff 63 ff 71 ff 26 ff  ....'.?.>.c.q.&.
>
>
>     0020: fd fe 03 ff 63 ff 9b ff  b6 ff 91 ff 75 ff 79 ff  ....c.......u.y.
> 2009-12-31 00:08:57.263901 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: 29 ff 51 ff ee fe c9 fe  12 ff 85 ff a6 ff 45 ff  ).Q...........E.
>
>
>     0010: 38 ff 52 ff d7 ff f7 ff  96 ff e9 fe 99 fe d5 fe  8.R.............
>     0020: 5e ff 9c ff 4d ff 1e ff  c5 fe 2f ff b8 ff cf ff  ^...M...../.....
> 2009-12-31 00:08:57.263903 > SCO data: handle 1 flags 0x00 dlen 48
>
>
>     0000: f1 ff b2 ff aa ff 82 ff  8a ff 5f ff 47 ff 50 ff  .........._.G.P.
>     0010: 4a ff ad ff 58 ff 1a ff  43 ff 78 ff 44 ff ef fe  J...X...C.x.D...
>     0020: 02 ff 05 ff 42 ff 61 ff  bb ff d8 ff cd ff 01 00  ....B.a.........
>
>
> 2009-12-31 00:08:57.263905 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: 28 ff e5 fe f4 fe f1 fe  ad ff 33 ff f6 fe ed fe  (.........3.....
>     0010: 7b fe 45 ff be ff 9c ff  ac ff 2b ff 34 ff 7a ff  {.E.......+.4.z.
>
>
>     0020: 3e ff af ff d3 ff 00 ff  6f ff 69 ff 26 ff 9d ff  >.......o.i.&...
> 2009-12-31 00:08:57.273899 > SCO data: handle 1 flags 0x00 dlen 48
>     0000: 7d ff 8e ff 52 ff 36 ff  2a ff fe fe 63 ff d2 ff  }...R.6.*...c...
>
>
>     0010: eb ff 92 ff 7a ff 36 ff  22 ff 68 ff d6 ff e0 ff  ....z.6.".h.....
>     0020: 66 ff b8 fe 68 fe f0 fe  3a ff 69 ff 85 ff a5 ff  f...h...:.i.....
>>............
>
>
>

BRs,
/Chao
