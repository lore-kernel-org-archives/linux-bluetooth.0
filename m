Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <423CB216.8050006@email.it>
From: Antonio-Blasco Bonito <blasco.bonito@email.it>
MIME-Version: 1.0
To: Antonio-Blasco Bonito <blasco.bonito@email.it>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, bluez-devel@lists.sourceforge.net,
   ms419@freezone.co.uk, durtro@ginnungagap.de
Subject: Re: [Bluez-devel] Fwd: alsa bluetooth module
References: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk> <1111098892.19889.88.camel@pc7.dolda2000.com> <423B6547.5040001@email.it>
In-Reply-To: <423B6547.5040001@email.it>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Sun, 20 Mar 2005 00:13:26 +0100

Antonio-Blasco Bonito ha scritto:

> Fredrik Tolf ha scritto:
>
>> Try to check the output of `grep kcalloc /proc/kallsyms' and compare
>> that to the output of `nm /path/to/snd-bt-sco.ko | grep kcalloc'.
>>  
>>
> $ grep kcalloc /proc/kallsyms
> ce9f6a40 U snd_kcalloc  [snd_opl3_lib]
> ce9f6a40 U snd_kcalloc  [snd_hwdep]
> ce9f6a40 U snd_kcalloc  [snd_mpu401_uart]
> ce9f6a40 U snd_kcalloc  [snd_rawmidi]
> ce9f6a40 U snd_kcalloc  [snd_seq_device]
> ce9f6a40 U snd_kcalloc  [snd_cs4231_lib]
> ce9f6a40 U snd_kcalloc  [snd_pcm_oss]
> ce9f6a40 U snd_kcalloc  [snd_mixer_oss]
> ce9f6a40 U snd_kcalloc  [snd_pcm]
> ce9f6a40 U snd_kcalloc  [snd_timer]
> ce9fc4d8 r __kcrctab_snd_kcalloc        [snd]
> ce9fc634 r __kstrtab_snd_kcalloc        [snd]
> ce9fca40 r __ksymtab_snd_kcalloc        [snd]
> ce9f6a40 T snd_kcalloc  [snd]
> 4da9e78a a __crc_snd_kcalloc    [snd]
>
> $ nm /lib/modules/2.6.8-2-686/extra/snd-bt-sco.ko |grep kcalloc
>         U kcalloc
>
Having seen that, knowing almost nothing about that, I tried editing the 
source code of the module btsco.c
I replaced the three occurrences of kcalloc with snd_kcalloc. It 
compiled without errors. And then OK!!! ... I've been able to modprobe it.

# lsmod
Module                  Size  Used by
sco                    15108  0
isofs                  37240  1
snd_bt_sco             13088  3
rfcomm                 39420  3
l2cap                  25796  7 rfcomm
ipv6                  264644  12
ds                     18756  4
appletalk              36628  20
lp                     11176  0
snd_cs4236             18568  4
snd_opl3_lib           10656  1 snd_cs4236
snd_hwdep               9412  3 snd_bt_sco,snd_opl3_lib
snd_cs4236_lib         16896  1 snd_cs4236
snd_mpu401_uart         7968  1 snd_cs4236
snd_rawmidi            25124  1 snd_mpu401_uart
snd_seq_device          8200  2 snd_opl3_lib,snd_rawmidi
snd_cs4231_lib         27744  2 snd_cs4236,snd_cs4236_lib
snd_pcm_oss            55080  0
snd_mixer_oss          20096  4 snd_pcm_oss
snd_pcm                98728  4 
snd_bt_sco,snd_cs4236_lib,snd_cs4231_lib,snd_pcm_oss
snd_timer              25668  3 snd_opl3_lib,snd_cs4231_lib,snd_pcm
snd                    57156  20 
snd_bt_sco,snd_cs4236,snd_opl3_lib,snd_hwdep,snd_cs4236_lib,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_cs4231_lib,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10336  4 snd
snd_page_alloc         11752  3 snd_bt_sco,snd_cs4231_lib,snd_pcm
...

I get the address of my headset:
# hcitool scan
Scanning ...
        00:0B:2E:30:9B:03       Motorola HS805

I connect it:

# btsco 00:0B:2E:30:9B:03
Device is 1:0                                  (here I'm asked to key in 
the pin)
Voice setting: 0x0060
RFCOMM channel 1 connected
                                                       (I press the 
connect button on the headset)
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=09
Sending up speaker change 9

I can see the alsa audio device

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: CS4239 [CS4239], device 0: CS4231 [CS4239]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Headset [BT Headset], device 0: Bluetooth SCO PCM [BT SCO PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

But if I play some audio:
# aplay -t wav -B 1000000 -D plughw:Headset audiofile.wav

I hear nothing   :-(
while syslog says:
Mar 19 23:41:57 localhost kernel: snd-bt-sco: playback_open
Mar 19 23:41:57 localhost kernel: snd-bt-sco: prepare ok bps: 16000 
size: 16002 count: 4000
Mar 19 23:41:57 localhost kernel: snd-bt-sco: playback_trigger 1
Mar 19 23:41:57 localhost kernel: snd-bt-sco: setting playback to bspcm

I'm so close... what else I have to do now? Please...

 

 

 --

 Email.it, the professional e-mail, gratis per te: http://www.email.it/f

 

 Sponsor:

 Solo 10 Euro per chiamare in tutto il mondo!! Scopri il vantaggio di Email Phone Card,        clicca subito

 Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=2685&d=20-3


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
