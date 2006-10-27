Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4541CA6E.4010003@free.fr>
Date: Fri, 27 Oct 2006 10:59:26 +0200
From: =?ISO-8859-1?Q?fabrice_r=E9gnier?= <regnier.fab@free.fr>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
References: <4540D480.1030203@free.fr>
In-Reply-To: <4540D480.1030203@free.fr>
Subject: [Bluez-users] btsco fails: control open (hw:1): No such device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi to all,

i try to use my headset with btsco:

is my headset recognize and connected ?
I think YES.

FR-PORT:~# hcitool con
Connections:
         > ACL 00:03:89:AB:3D:76 handle 6 state 1 lm SLAVE
FR-PORT:~# hcitool info 00:03:89:AB:3D:76
Requesting information ...
         BD Address: 00:03:89:AB:3D:76
         Device Name: PLT 510 v.G
         LMP Version: 1.2 (0x2) LMP Subversion: 0x958
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xbc 0xe8 0x01 0x00 0x18 0x18 0x00 0x00
            <encryption> <slot offset> <timing accuracy> <role switch>
            <sniff mode> <SCO link> <HV3 packets> <u-law log> <A-law log>
            <CVSD> <AFH cap. slave> <AFH class. slave> <AFH cap. master>
            <AFH class. master>


then i modprobe btsco

FR-PORT:/# lsmod| grep sco
snd_bt_sco             11308  0
snd_hwdep               6560  1 snd_bt_sco
snd_pcm                67976  4 =

snd_bt_sco,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd                    39268  10 =

snd_bt_sco,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,=
snd_pcm,snd_timer
snd_page_alloc          7560  3 snd_bt_sco,snd_intel8x0,snd_pcm

then i hciconfig hci0 voice 0x0060

then:
FR-PORT:~# btsco -v 00:03:89:AB:3D:76
btsco v0.42
Error: control open (hw:1): No such device
Error: Can't find device. Bail

where should i look in to make it working ?

thanx ;)

fabrice r=E9gnier.



My configuration:

FR-PORT:/# cat /etc/bluetooth/hcid.conf
options {
         autoinit yes;
         security auto;
         pairing multi;
         passkey "0000";
}

device {
         name "%h-%d";
         class 0x3e0100;
         iscan enable; pscan enable;
         lm accept;
         lp rswitch,hold,sniff,park;
}

FR-PORT:/etc/bluetooth# cat rfcomm.conf
rfcomm0 {
         bind yes;
         device 00:03:89:AB:3D:76;
         channel 1;
         comment "Oreillette";
}

I'm running debian etch 2.6.15 with alsa integrated as module

FR-PORT:/usr/src/linux# grep SND .config
CONFIG_SND=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_AC97_BUS=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_EMU10K1=3Dm
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_USB_AUDIO=3Dm


automake1.7                       1.7.9-9
bluez-cups                        3.7-1
bluez-hcidump                     1.32-1
bluez-utils                       3.7-1
kernel-patch-2.6-bluez            20050328-1
libasound2-dev                    1.0.13-1


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
