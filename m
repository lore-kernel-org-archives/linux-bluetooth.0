Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: David Elze <wegwerf@datenschrott.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <472DFD88.6060108@pagema.net>
References: <1194192865.2823.20.camel@aero64.datenschrott.de>
	<472DFD88.6060108@pagema.net>
Date: Sun, 04 Nov 2007 18:46:37 +0100
Message-Id: <1194198397.2823.29.camel@aero64.datenschrott.de>
Mime-Version: 1.0
Subject: Re: [Bluez-users] headset via bluetooth-headset not fully working
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hey maHo, 

Am Sonntag, den 04.11.2007, 18:12 +0100 schrieb maho+bluez:
> What aplay -v -Dplug:headset /usr/share/sounds/alsa/Front_Center.wav says?
> Doesn't it say that "Prorotocol not available (92)" ?

Nope, the output is just:

# aplay -v -Dplug:headset /usr/share/sounds/alsa/Front_Center.wav
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
Plug PCM: Rate conversion PCM (8000, sformat=S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24048
  period_size  : 144
  period_time  : 3000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 144
  xfer_align   : 144
  start_threshold  : 24048
  stop_threshold   : 24048
  silence_threshold: 0
  silence_size : 0
  boundary     : 1576009728
Slave: Bluetooth SCO Audio
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4008
  period_size  : 24
  period_time  : 3000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 24
  xfer_align   : 24
  start_threshold  : 4008
  stop_threshold   : 4008
  silence_threshold: 0
  silence_size : 0
  boundary     : 2101346304

Rate conversion is done (48kHz->8kHz) so this can't be the problem
anyways. Furthermore, if I play some longer file (or for example a
mp3 via xmms with the headset as alsa output device selected) the
same happens. Headset beeps initially, sound is playing according to the
user level in Linux quite normally but there is no sound at the headset,
just this very low noise (that goes away when the user level player,
aplay or xmms, is done). 

Oh, and I also tried to record something off the headset via arecord: 
the sound seems to be recorded (again, no errors at all) but the
resulting wav-file is just empty.

Greets, David


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
