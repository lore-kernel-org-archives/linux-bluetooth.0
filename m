Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E91B7A.1070303@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] btsco crash without daemon
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
Date: Sat, 15 Jan 2005 14:32:42 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


- ---------------------- from demesg after a ls > /dev/dsp1
- --------------------

snd-bt-sco revision 1.4 $
snd-bt-sco: snd-bt-scod thread starting
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 32768 count: 8192
snd-bt-sco: playback_trigger 1
Unable to handle kernel NULL pointer dereference at virtual address
00000098
~ printing eip:
e0af9067
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: snd_pcm_oss snd_mixer_oss snd_bt_sco snd_hwdep
ipw2100 firmware_class ieee80211 ieee80211_crypt ohci1394 ieee1394 tg3
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore
snd_page_alloc reiserfs asus_acpi cpufreq_userspace cpufreq_powersave
cpufreq_ondemand usbserial rfcomm l2cap hci_usb bluetooth
CPU:    0
EIP:    0060:[<e0af9067>]    Not tainted VLI
EFLAGS: 00010046   (2.6.10)
EIP is at snd_card_bt_sco_playback_trigger+0x67/0x80 [snd_bt_sco]
eax: 00000022   ebx: 00000001   ecx: c03acabc   edx: 00000086
esi: 00000000   edi: df355720   ebp: de6292c0   esp: df5f6d64
ds: 007b   es: 007b   ss: 0068
Process ls (pid: 8042, threadinfo=df5f6000 task=dfa2e560)
Stack: e0afa2a0 00000001 00000000 e0a43f74 00000003 e0a33168 de6292c0
00000001
~       e0a32e88 de6292c0 00000003 de62933c de6292c0 00000003 e0a43f74
e0a32f70
~       e0a43f74 de6292c0 00000003 de360000 00001000 00001000 00000000
df541800
Call Trace:
~ [<e0a33168>] snd_pcm_do_start+0x28/0x30 [snd_pcm]
~ [<e0a32e88>] snd_pcm_action_single+0x38/0x80 [snd_pcm]
~ [<e0a32f70>] snd_pcm_action+0xa0/0xb0 [snd_pcm]
~ [<e0a33260>] snd_pcm_start+0x20/0x30 [snd_pcm]
~ [<e0a3b92d>] snd_pcm_lib_write1+0x3ad/0x480 [snd_pcm]
~ [<c011dfa7>] printk+0x17/0x20
~ [<e0a3ba91>] snd_pcm_lib_write+0x91/0xb0 [snd_pcm]
~ [<e0a3b4d0>] snd_pcm_lib_write_transfer+0x0/0xb0 [snd_pcm]
~ [<e0b1f165>] snd_pcm_oss_write3+0x55/0xb0 [snd_pcm_oss]
~ [<e0b23bfa>] snd_pcm_plug_write_transfer+0x9a/0x100 [snd_pcm_oss]
~ [<e0b1f4f9>] snd_pcm_oss_write2+0x99/0xf0 [snd_pcm_oss]
~ [<e0b1fb08>] snd_pcm_oss_sync1+0x78/0x150 [snd_pcm_oss]
~ [<c01197e0>] default_wake_function+0x0/0x20
~ [<c0203132>] copy_from_user+0x42/0x70
~ [<e0b1fe21>] snd_pcm_oss_sync+0x241/0x290 [snd_pcm_oss]
~ [<e0b21216>] snd_pcm_oss_release+0x26/0xd0 [snd_pcm_oss]
~ [<c015e51b>] __fput+0x11b/0x130
~ [<c015cc19>] filp_close+0x59/0x90
~ [<c015ccbd>] sys_close+0x6d/0x90
~ [<c01031af>] syscall_call+0x7/0xb
Code: ff ff ff 75 16 31 c0 89 86 98 00 00 00 c7 04 24 e0 a2 af e0 e8
3b 4f 62 df 31 c0 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 <89>
be 98 00 00 00 c7 04 24 20 a3 af e0 eb da 8d 76 00 8d bc 27
~ <6>note: ls[8042] exited with preempt_count 2

- --- ----------------------------------------


that was all because i cant get the daemon working with kernle 2.6.10
- - in 2.6.9 evrything was working fine. Something very wicked is going
on with alsa because nothing is going on in hcidump.

bash-2.05b# ./btsco 00:0E:16:01:06:ED
Device is 1:0
Error: btsco open (1-0): No such device or address

but
bash-2.05b# lsmod
Module                  Size  Used by
sg                     31648  0
snd_pcm_oss            49824  1
snd_mixer_oss          18688  1 snd_pcm_oss
snd_bt_sco             11552  1
snd_hwdep               8608  1 snd_bt_sco
ipw2100               142532  0
firmware_class          8832  1 ipw2100
ieee80211              34212  1 ipw2100
ieee80211_crypt         5832  1 ieee80211
ohci1394               32644  0
ieee1394               95156  1 ohci1394
tg3                    83588  0
snd_intel8x0           30240  0
snd_ac97_codec         76000  1 snd_intel8x0
snd_pcm                84996  4
snd_pcm_oss,snd_bt_sco,snd_intel8x0,snd_ac97_codec
snd_timer              22660  1 snd_pcm
snd                    50404  8
snd_pcm_oss,snd_mixer_oss,snd_bt_sco,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               8672  2 snd
snd_page_alloc          8708  3 snd_bt_sco,snd_intel8x0,snd_pcm
reiserfs              239440  1
asus_acpi              11156  0
cpufreq_userspace       6112  0
cpufreq_powersave       2560  0
cpufreq_ondemand        6568  0
usbserial              27368  0
rfcomm                 35224  0
l2cap                  23680  5 rfcomm
hci_usb                13568  2
bluetooth              45316  7 rfcomm,l2cap,hci_usb


thanx 4 attention
ligi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6Rt63NorRo/jFWIRAoT1AJ9TQ5OPcZEhi55CGZXqdo2b6bEGPgCgkdZ2
vgVKOBQlyUTVIkOq0Q+o1gQ=
=z/Mi
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
