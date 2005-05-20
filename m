Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <428E4445.7080509@gmx-topmail.de>
From: Jan H <jan.h@gmx-topmail.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <c1afa04d0505151420720b5bad@mail.gmail.com> <4287C079.20208@gmx.ch>	 <428825B8.2070103@metalan.net>	 <c1afa04d050516134921746de0@mail.gmail.com> <c1afa04d05052010462a27c0d6@mail.gmail.com>
In-Reply-To: <c1afa04d05052010462a27c0d6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Subject: [Bluez-users] Re: btsco - headset profile activated but no sco packets transmitted
 ???
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 20 May 2005 22:10:45 +0200

Lars Steinke wrote:

> Phew, got it finally,
> 
> it was the bloody ehci_hcd audio problem others have come across:
> http://sourceforge.net/mailarchive/message.php?msg_id=11431438
> 
> Using ohci_hcd, btsco works a treat in recording and playing, thanks for 
> the good work !!!
>  
>
Hi List, Hi Lars,
it seems to me I have the same problems at least the same symptoms as
you. I am trying to get a logitech mobil pro (HS01 V16) headset to work
with avm bluefritz usb dongle on my acer notebook. There ist some noise
but no sound.

Peering works fine and all modules seem to work too


user@name:/$ lsmod | grep sco
snd_bt_sco             14496  1
snd_hwdep               9632  2 snd_bt_sco
sco                    15812  0
bluetooth              53252  8 sco,hci_usb,rfcomm,l2cap
snd_pcm                96456  4
snd_bt_sco,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd                    55332  11
snd_bt_sco,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         10116  3 snd_bt_sco,snd_intel8x0,snd_pcm


After that i did esctl stop and startet btsco. while playing a test wav
i get


btsco v0.4
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
speaker volume: 11 mic volume: 0
driver is in use
connected SCO channel
Done setting sco fd
recieved AT+VGS=11
Sending up speaker change 11
speaker volume: 11 mic volume: 1
driver is not in use
disconnected SCO channel

name:/# aplay -B 1000000 -D plughw:Headset /home/user/Desktop/test.wav
Playing WAVE '/home/user/Desktop/test.wav' : Signed 16 bit Little
Endian, Rate 8000 Hz, Mono
aplay: pcm_write:1146: write error: Input/output error


Now i can set volume by pushing the headset buttons but there is no
sound just some noisy with max Volume settings.
My question is who did you find out ehci_hcd driver is used?
And how did you load ohci_hcd?
lspci shows me
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
2.0 EHCI Controller (rev 03)

This is really driving me crazy, thanks for help
Jan


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
