Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: marcel@holtmann.org
Date: Fri, 09 Mar 2007 08:31:16 +0000
Message-Id: <1173429077.3461.554.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] HID disconnect oops with 2.6.21-rc3
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Is it time to move the lists off sourceforge yet?

When my Bluetooth mouse disconnects and reconnects, I sometimes see
this. I can't easily reproduce just by turning it off.

PM: Removing info for bluetooth:acl000A94C07E17
Unable to handle kernel paging request for data at address 0x6b6b6b6b
Oops: Kernel access of bad area, sig: 11 [#1]

Modules linked in: radeon(U) drm(U) hidp(U) hci_usb(U) rfcomm(U) l2cap(U) blueto
oth(U) arc4(U) ecb(U) blkcipher(U) ieee80211_crypt_wep(U) ipv6(U) nls_utf8(U) hf
splus(U) dm_mirror(U) dm_mod(U) therm_adt746x(U) parport_pc(U) lp(U) parport(U) 
snd_aoa_i2sbus(U) bcm43xx(U) ieee80211softmac(U) snd_powermac(U) snd_seq_dummy(U
) ieee80211(U) snd_seq_oss(U) snd_seq_midi_event(U) snd_seq(U) snd_seq_device(U)
 ieee80211_crypt(U) sungem(U) snd_pcm_oss(U) snd_mixer_oss(U) sungem_phy(U) snd_
pcm(U) snd_timer(U) snd_page_alloc(U) snd(U) soundcore(U) snd_aoa_soundbus(U) id
e_cd(U) cdrom(U) fw_ohci(U) fw_core(U) ext3(U) jbd(U) mbcache(U) ehci_hcd(U) ohc
i_hcd(U) uhci_hcd(U)
NIP: C001890C LR: C012C760 CTR: C01CCEBC
REGS: ef65fdb0 TRAP: 0300   Not tainted  (2.6.20-1.2967.fc7)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000224  XER: 20000000
DAR: 6B6B6B6B, DSISR: 40000000
TASK = c0e0ecf0[2599] 'khidpd_00000000' THREAD: ef65e000
GPR00: 6B6B6B6B EF65FE60 C0E0ECF0 6B6B6B6B 6B6B6B6A C1C57D3C 0000001A ED22EECE 
GPR08: 000007AA 00000014 FFFFFFFF 00000005 00000000 2002160C 22204422 00000000 
GPR16: 00000000 7FE59006 00000003 C1C57D24 00000000 C1F03ED8 C037AEB8 ED22EE78 
GPR24: C0369F0C ED22EECE 0000001A 000007AA 00000001 C0F7E728 C0F7E728 000000D0 
NIP [C001890C] strlen+0x4/0x18
LR [C012C760] kobject_get_path+0x34/0xc4
Call Trace:
[EF65FE60] [C0092884] __kmalloc_track_caller+0x144/0x164 (unreliable)
[EF65FE80] [C01CCF04] class_uevent+0x48/0x1c0
[EF65FEC0] [C012CED8] kobject_uevent_env+0x278/0x490
[EF65FF10] [C01CC6A0] class_device_del+0x178/0x1a0
[EF65FF30] [C01CC6E0] class_device_unregister+0x18/0x30
[EF65FF50] [C021DD38] input_unregister_device+0x13c/0x178
[EF65FF70] [C023EF3C] hidinput_disconnect+0x2c/0x60
[EF65FF90] [F27B1B50] hidp_session+0x550/0x584 [hidp]
[EF65FFF0] [C0013F7C] kernel_thread+0x44/0x60
Instruction dump:
4082fff4 4e800020 38a3ffff 3884ffff 8c650001 2c830000 8c040001 7c601851 
4d860020 4182ffec 4e800020 3883ffff <8c040001> 2c000000 4082fff8 7c632050 
PM: Adding info for bluetooth:acl000A94C07E17
PM: Removing info for bluetooth:acl000A94C07E17
PM: Adding info for bluetooth:acl000A94C07E17


-- 
dwmw2


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
