Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 01 Dec 2011 18:09:09 +0100
From: krisztian.kocsis@optimaster.eu
To: <linux-bluetooth@vger.kernel.org>
Subject: Cracking Sound (aplay output)
Message-ID: <d724bdf93e0c10a1810aaf0288e7aa41@optimaster.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

Here is the output of aplay, it knows that the sound has to be 
converted to big endian:

Playing WAVE '/usr/share/sounds/alsa/Noise.wav' : Signed 16 bit Little 
Endian, Rate 48000 Hz, Mono
Plug PCM: Rate conversion PCM (8000, sformat=S16_BE)
Converter: linear-interpolation
Protocol version: 10002
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 1
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 24000
   period_size  : 6000
   period_time  : 125000
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 6000
   period_event : 0
   start_threshold  : 24000
   stop_threshold   : 24000
   silence_threshold: 0
   silence_size : 0
   boundary     : 1572864000
Slave: Bluetooth Audio Device
Its setup is:
   stream       : PLAYBACK
   access       : MMAP_INTERLEAVED
   format       : S16_BE
   subformat    : STD
   channels     : 1
   rate         : 8000
   exact rate   : 8000 (8000/1)
   msbits       : 16
   buffer_size  : 4000
   period_size  : 1000
   period_time  : 125000
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 1000
   period_event : 0
   start_threshold  : 4000
   stop_threshold   : 4000
   silence_threshold: 0
   silence_size : 0
   boundary     : 2097152000

