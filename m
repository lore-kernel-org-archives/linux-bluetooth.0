Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Sebastian Eichner <mailsp@sebastian-eichner.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412010839.06669.mailsp@sebastian-eichner.de>
Subject: [Bluez-devel] A2DP working :-) , voice not :-(
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
Date: Wed, 1 Dec 2004 08:39:06 +0100

Hi all!

First of all: thank you very much for your work and your help!

As suggested i installed a vanilla 2.6.9 kernel with mh4-patches, and 
also updated bluez-libs and bluez-utils to the current version 2.11.

And, success: with yesterdays cvs version i have a2dp audio working 
with my BT420! BTW: As sox plays only a very few of my mp3's i use 
mpg123 for decoding:
mpg123  -s test.mp3 |sox -t raw -r 44100 -s -w -c 2 - -r 44100 -s -w 
-t au  - |sbc/sbcenc - | ./a2play 00:08:F4:30:03:71


But: i cannot get the normal voice headset to work.
The aplay command starts but then i do not hear anything, nor does 
aplay finish:
aplay  -D plughw:Headset test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 22050 Hz, 
Mono

In the system log i get the following entries:

Dec  1 08:32:08 linux kernel: snd-bt-sco: playback_trigger 0
Dec  1 08:32:08 linux kernel: snd-bt-sco: setting playback to NULL
Dec  1 08:32:09 linux kernel: snd-bt-sco: playback_open
Dec  1 08:32:09 linux kernel: snd-bt-sco: prepare ok bps: 16000 size: 
8000 count: 2000
Dec  1 08:32:09 linux kernel: snd-bt-sco: playback_trigger 1
Dec  1 08:32:09 linux kernel: snd-bt-sco: setting playback to bspcm

Looks alright, doesn't it?
Do you have an idea what could be wrong? I checked the mixer settings 
via alsamixer, which are fine too (BTW: what is this 
"loopback"-switch?).

Thanks for any suggestions!
 Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
