Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41ED692D.9070006@gmx.de>
From: jksd <jksd@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------080105070904020807090003"
Subject: [Bluez-users] BlueFritz USB and FC3 - CAPI not installed
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
Date: Tue, 18 Jan 2005 20:53:17 +0100

This is a multi-part message in MIME format.
--------------080105070904020807090003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by post.webmailer.de id j0IJr8BQ020518

I'm trying to setup BlueFritz USBv2.0 with Fedora Core 3 (Kernel 2.6.9).=20
I've no problems connecting the access point (ciptool connect). But when=20
I try "capiinfo", there is no capi device available. Same result if I=20
try pppd..

[root@jd2 ~]# capiinfo
capi not installed - No such device or address (6)

/var/log/messages:
------------------
Jan 15 17:25:35 jd2 kernel: CAPI Subsystem Rev 1.1.2.8
Jan 15 17:25:35 jd2 kernel: Bluetooth: CMTP (CAPI Emulation) ver 1.0
Jan 15 17:25:46 jd2 hcid[2576]: link_key_request (sba=3D00:04:0E:88:70:44=
,=20
dba=3D00:04:0E:88:5E:2F)
Jan 15 17:25:46 jd2 hcid[2576]: pin_code_request (sba=3D00:04:0E:88:70:44=
,=20
dba=3D00:04:0E:88:5E:2F)
Jan 15 17:25:54 jd2 hcid[2576]: link_key_notify (sba=3D00:04:0E:88:70:44)
Jan 15 17:25:54 jd2 hcid[2576]: Replacing link key 00:04:0E:88:70:44=20
00:04:0E:88:5E:2F
Jan 15 17:25:54 jd2 kernel: Bluetooth: Found 1 CAPI controller(s) on=20
device 00:04:0E:88:5E:2F
Jan 15 17:25:54 jd2 kernel: kcapi: Controller 1: 00:04:0E:88:5E:2F attach=
ed
Jan 15 17:25:54 jd2 kernel: kcapi: card 1 "00:04:0E:88:5E:2F" ready.
Jan 15 17:35:28 jd2 pppd[4167]: Plugin userpass.so loaded.
Jan 15 17:35:28 jd2 pppd[4167]: userpass: $Revision: 1.4 $
Jan 15 17:35:28 jd2 pppd[4167]: Plugin capiplugin.so loaded.
Jan 15 17:35:28 jd2 pppd[4167]: capiplugin: $Revision: 1.32 $
Jan 15 17:35:28 jd2 pppd[4167]: capiconn:  1.7
Jan 15 17:35:28 jd2 pppd[4167]: capiplugin: CAPI_REGISTER failed - CAPI=20
not installed (0x1009) [No such file or directory (2)]
Jan 15 17:35:28 jd2 pppd[4167]: Exit.

I think, in /var/log/messages is something like "kcapi: appl 1 up "=20
missing.

/dev/capixx is missing, too. If I load module "capi" manually, the nodes=20
/dev/capixx are installed - but no change to the capiinfo. udev is=20
installed.

The output of lsmod is attached.


Any hints are welcome,
J=F6rg.


--------------080105070904020807090003
Content-Type: text/plain;
 name="lsmod.log"
Content-Disposition: inline;
 filename="lsmod.log"
Content-Transfer-Encoding: 7bit


lsmod after ciptool connect:

Module                  Size  Used by
cmtp                   18304  1 
kernelcapi             44704  1 cmtp
vfat                   15104  1 
fat                    46112  1 vfat
vmnet                  29212  14 
vmmon                 165164  0 
parport_pc             25152  1 
lp                     11756  0 
parport                42312  2 parport_pc,lp
autofs4                24452  0 
i2c_dev                10624  0 
i2c_core               22528  1 i2c_dev
rfcomm                 37020  0 
l2cap                  25604  8 cmtp,rfcomm
sunrpc                161380  1 
arc4                    2176  1 
ieee80211_crypt_wep     5120  1 
ds                     17284  4 
ipt_REJECT              6784  1 
ipt_state               2176  1 
ip_conntrack           41268  1 ipt_state
iptable_filter          3072  1 
ip_tables              16512  3 ipt_REJECT,ipt_state,iptable_filter
nls_utf8                2304  4 
ntfs                  133648  4 
dm_mod                 55444  0 
button                  6928  0 
battery                 8964  0 
asus_acpi              11284  0 
ac                      5124  0 
md5                     4352  1 
ipv6                  233664  8 
hci_usb                15360  3 
bluetooth              47492  8 cmtp,rfcomm,l2cap,hci_usb
sd_mod                 17280  2 
ohci1394               35480  0 
ieee1394              303956  1 ohci1394
usb_storage            62280  1 
scsi_mod              119632  2 sd_mod,usb_storage
yenta_socket           19328  1 
pcmcia_core            60616  2 ds,yenta_socket
uhci_hcd               31768  0 
ehci_hcd               31876  0 
snd_intel8x0m          18504  2 
snd_usb_audio          60256  0 
snd_usb_lib            12416  1 snd_usb_audio
snd_intel8x0           35148  2 
snd_ac97_codec         64720  2 snd_intel8x0m,snd_intel8x0
snd_pcm_oss            48184  0 
snd_mixer_oss          17536  3 snd_pcm_oss
snd_pcm                98952  4 snd_intel8x0m,snd_usb_audio,snd_intel8x0,snd_pcm_oss
snd_timer              30212  1 snd_pcm
snd_page_alloc          9992  3 snd_intel8x0m,snd_intel8x0,snd_pcm
gameport                5120  1 snd_intel8x0
snd_mpu401_uart         9088  1 snd_intel8x0
snd_rawmidi            27172  2 snd_usb_lib,snd_mpu401_uart
snd_seq_device          8456  1 snd_rawmidi
snd                    54884  15 snd_intel8x0m,snd_usb_audio,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore              10336  3 snd
ipw2200               114316  0 
ieee80211              28228  1 ipw2200
ieee80211_crypt         7044  2 ieee80211_crypt_wep,ieee80211
8139too                26880  0 
mii                     4992  1 8139too
ext3                  116744  1 
jbd                    75416  1 ext3

--------------080105070904020807090003--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
