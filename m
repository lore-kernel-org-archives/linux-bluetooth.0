Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <418BA616.8080707@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Matthias Thomae <bluez@thomae-privat.de>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] News: Stereo BT Headset from BlueTake
References: <416D8520.5060102@thomae-privat.de> <418B2B9F.7000703@xmission.com> <418B4124.8050505@thomae-privat.de>
In-Reply-To: <418B4124.8050505@thomae-privat.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 05 Nov 2004 09:11:02 -0700

Matthias

> I hope so too :)
> What about your report to the snd-bt-sco mailing list:
> 
>  > It comes with a dongle to get stereo audio from a non-bluetooth
>  > device. It works ok, but only consistently at short ranges (<1 meter).
>  > It drops audio randomly or if I turn my head an unfortunate way  :(

Oh yeah. I changed two things and I think both helped it:

- turned off "auto range extender" on my 2.4Ghz cordless vtech phones
- charged the headset and dongle through another charge cycle (The 
headset does not have a low-power indicator... the audio just starts to 
break up.)

Now I can get about 5 meters away with good audio. I can get a little 
over 10 meters away if I'm using my cellphone or the computer with 
voice-quality audio. I'm not sure if the difference is that's because 
A2DP needs so much more reliable bandwidth or because the dongle could 
use a better antenna.

BT Musicool 300 claims to get up to 20 meters in good conditions. Are 
they using Class 1 adapters?

> Marcel seems to have something :)
> http://www.holtmann.org/linux/bluetooth/audio.html

nice

Brad


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
