Return-Path: <t.schorpp@gmx.de>
Message-ID: <3FFABD90.1020903@gmx.de>
Date: Tue, 06 Jan 2004 14:52:16 +0100
From: "thomas.schorpp" <t.schorpp@gmx.de>
Reply-To: "t.[NO_SPAM]schorpp"@gmx.de
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout, VIA USB HUBS
References: <3FF9E3F2.4040506@gmx.de> <1073393043.2508.50.camel@pegasus>	 <3FFAB0C5.4050407@gmx.de> <1073396288.2508.72.camel@pegasus>
In-Reply-To: <1073396288.2508.72.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

thx marcel,

Marcel Holtmann wrote:
> Hi Thomas,
> 
> 
>>hi marcel, thx for your fast acknowledge, heres some extended 
>>information, i could provide a hcidump -tsw in afew hours too:
> 
> 
> the hcidump won't help here, because I am pretty sure that this is a
> problem on the USB bus.

agree, will go to their mailing list later...

> 
> 
>>root@TOM1:~# hciconfig -a
>>hci0:   Type: USB
>>         BD Address: 00:10:60:A5:0F:EA ACL MTU: 192:8  SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:99 acl:0 sco:0 events:13 errors:0
>>         TX bytes:296 acl:0 sco:0 commands:12 errors:0
>>         Features: 0xff 0xff 0x0f 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: HOLD SNIFF PARK
>>         Link mode: ACCEPT MASTER
>>         Name: 'TOM1'
>>         Class: 0x000100
>>         Service Classes: Unspecified
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
>>Subver: 0x20d
>>         Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> This is HCI 16.4 firmware and it should work fine. Do you use the SCO
> audio support for the HCI USB driver? If yes, disable it, because I
> heard of problems with ISOC transfers on VIA chips if I remember
> correctly.

NO sco module loaded(?)

schorpp@TOM1:~$ lsmod
Module                  Size  Used by    Not tainted
bnep                    9716   1 (autoclean)
l2cap                  15884   2 (autoclean) [bnep]
sr_mod                 14936   0 (autoclean)
snd-mixer-oss          12080   3 (autoclean)
joydev                  5888   0 (unused)
keybdev                 1952   0 (unused)
mousedev                4244   0 (unused)
scanner                10936   0
hid                    21156   0 (unused)
printer                 7040   0
w9968cf-vpp            12864   6 (autoclean)
w9968cf                60568   0
hci_usb                 7832   1
bluez                  30436   2 [bnep l2cap hci_usb]
dvb-ttpci             304596   5
alps_bsrv2              3992   1
input                   3200   0 [joydev keybdev mousedev hid dvb-ttpci]
dvb-core               41220  16 [dvb-ttpci alps_bsrv2]
8139too                13384   1
mii                     2304   0 [8139too]
crc32                   2880   0 [bnep 8139too]
tuner                  10240   1 (autoclean)
tvaudio                13628   0 (autoclean) (unused)
msp3400                16396   1 (autoclean)
bttv                   94688   0
i2c-algo-bit            6984   1 [bttv]
videodev                5984   6 [w9968cf dvb-ttpci bttv]
snd-bt87x               5036   1
uhci                   24528   0 (unused)
usbcore                58752   1 [scanner hid printer w9968cf hci_usb uhci]
snd-via82xx            12032   3
snd-pcm                56288   0 [snd-bt87x snd-via82xx]
snd-timer              13412   0 [snd-pcm]
snd-ac97-codec         43436   0 [snd-via82xx]
snd-page-alloc          6004   0 [snd-bt87x snd-via82xx snd-pcm]
snd-mpu401-uart         3136   0 [snd-via82xx]
snd-rawmidi            12640   0 [snd-mpu401-uart]
snd-seq-device          3904   0 [snd-rawmidi]
snd                    29924   1 [snd-mixer-oss snd-bt87x snd-via82xx 
snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3332   2 [bttv snd]
ovcamchip              16872   1
i2c-core               12740   0 [w9968cf tuner tvaudio msp3400 bttv 
i2c-algo-bit ovcamchip]
ide-scsi                9424   0
schorpp@TOM1:~$

> 
> 
>>root@TOM1:~# uname -r
>>2.4.23
> 
> 
> Use 2.4.23-mh1 or 2.4.24-mh1.

roger that. what change do you think in the changelogs should target the 
problem?

> 
> 
>>P.S. what linux devenv and kernel debugging env do you use? i wasted 
>>years with visual c++ ;)
> 
> 
> I use anjuta and vi as editor and for debugging it is simply printk ;)
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 

thx
y
tom
