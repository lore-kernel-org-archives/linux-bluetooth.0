Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] A2DP working :-) , voice not :-(
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200412010839.06669.mailsp@sebastian-eichner.de>
References: <200412010839.06669.mailsp@sebastian-eichner.de>
Content-Type: text/plain
Message-Id: <1101887686.18840.38.camel@pegasus>
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
Date: Wed, 01 Dec 2004 08:54:46 +0100

Hi Sebastian,

> And, success: with yesterdays cvs version i have a2dp audio working 
> with my BT420! BTW: As sox plays only a very few of my mp3's i use 
> mpg123 for decoding:
> mpg123  -s test.mp3 |sox -t raw -r 44100 -s -w -c 2 - -r 44100 -s -w 
> -t au  - |sbc/sbcenc - | ./a2play 00:08:F4:30:03:71

there is no need to put sox in between:

mpg123 --au - test.mp3 | sbc/sbcenc - | ./a2play 00:08:F4:30:03:71

> But: i cannot get the normal voice headset to work.
> The aplay command starts but then i do not hear anything, nor does 
> aplay finish:
> aplay  -D plughw:Headset test.wav
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 22050 Hz, 
> Mono
> 
> In the system log i get the following entries:
> 
> Dec  1 08:32:08 linux kernel: snd-bt-sco: playback_trigger 0
> Dec  1 08:32:08 linux kernel: snd-bt-sco: setting playback to NULL
> Dec  1 08:32:09 linux kernel: snd-bt-sco: playback_open
> Dec  1 08:32:09 linux kernel: snd-bt-sco: prepare ok bps: 16000 size: 
> 8000 count: 2000
> Dec  1 08:32:09 linux kernel: snd-bt-sco: playback_trigger 1
> Dec  1 08:32:09 linux kernel: snd-bt-sco: setting playback to bspcm
> 
> Looks alright, doesn't it?

What does "hciconfig hci0 revision" say?

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
