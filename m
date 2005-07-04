Return-Path: <ville.tervo@nokia.com>
Subject: rfcomm oops
From: Ville Tervo <ville.tervo@nokia.com>
Reply-To: ville.tervo@nokia.com
To: bluez-devel@lists.sourceforge.net
Cc: marcel@holtmann.org
Content-Type: text/plain
Date: Mon, 04 Jul 2005 18:19:30 +0300
Message-Id: <1120490370.30194.50.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

I found reproducible way to make rfcomm layer oops. I attached oops and
some notes how they were produced. I used several Nokia phones and IBM
T40 laptop in these tests.


PPP Deflate Compression module registered
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
Unable to handle kernel NULL pointer dereference at virtual address
00000047
 printing eip:
c0294798
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async
ppp_generic slhc af_packet hci_usb radeon drm rfcomm l2cap bluetooth
binfmt_misc pcmcia md5 ipv6 fan irtty_sir sir_dev irda crc_ccitt
parport_pc parport i2c_i801 i2c_core hw_random uhci_hcd intel_agp
agpgart ipw2100 firmware_class ieee80211 ieee80211_crypt e1000
yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
ehci_hcd usbcore aes_i586 thermal processor ibm_acpi ac button battery
ide_cd cdrom genrtc unix
CPU:    0
EIP:    0060:[<c0294798>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc5)
EIP is at sock_sendmsg+0xb8/0xe0
eax: 0000000f   ebx: f67c601b   ecx: c9668060   edx: f6d17e0c
esi: 00000004   edi: f6d17d40   ebp: f6d17dcc   esp: f6d17ce0
ds: 007b   es: 007b   ss: 0068
Process rfcomm (pid: 8320, threadinfo=f6d16000 task=c9668060)
Stack: f6d17d40 f67c601b f6d17e0c 00000004 f6d17d08 c03553c0 f6d17d68
00000004
       f67c601b f6d17d20 00000000 f6d17e0c d16154c0 a6119780 a6119780
00108eeb
       f6d17d40 f6d17d48 c01147a8 c03fa0d0 00108eeb ce724510 00000046
00000000
Call Trace:
 [<c01037cf>] show_stack+0x7f/0xa0
 [<c0103976>] show_registers+0x156/0x1c0
 [<c0103b8a>] die+0xea/0x180
 [<c0113406>] do_page_fault+0x326/0x6a2
 [<c01033df>] error_code+0x4f/0x54
 [<c0294802>] kernel_sendmsg+0x42/0x50
 [<f8d5ebef>] rfcomm_send_frame+0x4f/0x60 [rfcomm]
 [<f8d5ed5a>] rfcomm_send_disc+0x6a/0x70 [rfcomm]
 [<f8d5e5b7>] __rfcomm_dlc_close+0xc7/0xf0 [rfcomm]
 [<f8d5e604>] rfcomm_dlc_close+0x24/0x40 [rfcomm]
 [<f8d630c1>] rfcomm_tty_close+0x61/0xb0 [rfcomm]
 [<c0238e7c>] release_dev+0x7bc/0x7d0
 [<c0239376>] tty_release+0x16/0x30
 [<c015ad0d>] __fput+0x13d/0x150
 [<c01593e7>] filp_close+0x57/0x90
 [<c0159492>] sys_close+0x72/0xb0
 [<c01031c5>] syscall_call+0x7/0xb
Code: 3c ff ff ff 8b 45 0c 89 9d 34 ff ff ff 89 b5 30 ff ff ff 89 85 40
ff ff ff 8b 43 08 89 74 24 0c 89 54 24 08 89 5c 24 04 89 3c 24 <ff> 50
38 3d ef fd ff ff 74 0e 81 c4 e0 00 00 00 5b 5e 5f 5d c3


I connected to Nokia 6630 with commands "rfcomm connect 1 bdaddr 1" and
"rfcomm connect 2 bdaddr 15" which are dun and obex channels. Then
started to disconnect and connect continously using ctrl-c. After a
while phone crashed and after phone rebooted kernel oopsed when I hit
ctrl-c for obex channel.

Second case

Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Unable to handle kernel NULL pointer dereference at virtual address
00000038
 printing eip:
c0294798
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: rfcomm l2cap binfmt_misc pcmcia md5 ipv6 fan
irtty_sir sir_dev irda crc_ccitt parport_pc parport i2c_i801 i2c_core
hw_random hci_usb bluetooth uhci_hcd intel_agp agpgart ipw2100
firmware_class ieee80211 ieee80211_crypt e1000 yenta_socket
rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd
usbcore aes_i586 thermal processor ibm_acpi ac button battery ide_cd
cdrom genrtc unix
CPU:    0
EIP:    0060:[<c0294798>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc5) 
EIP is at sock_sendmsg+0xb8/0xe0
eax: 00000000   ebx: f75a4c40   ecx: f6da3ac0   edx: f6e1fe0c
esi: 00000004   edi: f6e1fd40   ebp: f6e1fdcc   esp: f6e1fce0
ds: 007b   es: 007b   ss: 0068
Process rfcomm (pid: 3935, threadinfo=f6e1e000 task=f6da3ac0)
Stack: f6e1fd40 f75a4c40 f6e1fe0c 00000004 00000010 c03553c0 f6e1fd68
00000004 
       f75a4c40 f6e1fd20 00000000 f6e1fe0c f737f4c0 0d1a3a40 0d1a3a40
000f421c 
       f6e1fd40 f6e1fd48 c01147a8 c03fa548 000f421c f747c060 00000046
00000000 
Call Trace:
 [<c01037cf>] show_stack+0x7f/0xa0
 [<c0103976>] show_registers+0x156/0x1c0
 [<c0103b8a>] die+0xea/0x180
 [<c0113406>] do_page_fault+0x326/0x6a2
 [<c01033df>] error_code+0x4f/0x54
 [<c0294802>] kernel_sendmsg+0x42/0x50
 [<f8d6abef>] rfcomm_send_frame+0x4f/0x60 [rfcomm]
 [<f8d6ad5a>] rfcomm_send_disc+0x6a/0x70 [rfcomm]
 [<f8d6a5b7>] __rfcomm_dlc_close+0xc7/0xf0 [rfcomm]
 [<f8d6a604>] rfcomm_dlc_close+0x24/0x40 [rfcomm]
 [<f8d6f0c1>] rfcomm_tty_close+0x61/0xb0 [rfcomm]
 [<c0238e7c>] release_dev+0x7bc/0x7d0
 [<c0239376>] tty_release+0x16/0x30
 [<c015ad0d>] __fput+0x13d/0x150
 [<c01593e7>] filp_close+0x57/0x90
 [<c0159492>] sys_close+0x72/0xb0
 [<c01031c5>] syscall_call+0x7/0xb
Code: 3c ff ff ff 8b 45 0c 89 9d 34 ff ff ff 89 b5 30 ff ff ff 89 85 40
ff ff ff 8b 43 08 89 74 24 0c 89 54 24 08 89 5c 24 04 89 3c 24 <ff> 50
38 3d ef fd ff ff 74 0e 81 c4 e0 00 00 00 5b 5e 5f 5d c3 
 
I connected to Nokia 6630 with command "rfcomm connect 1 bdaddr 1" and
"rfcomm connect 2 bdaddr 15" they are dun and obex channels. Then
disconnected and reconnected dun channel about 20 times and after that
disconnecting obex channel triggered this oops. I also tested Nokia 6680
and 9500 with same results.

-- 
Ville
 
