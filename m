Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <436F70C4.7060006@in.tum.de>
From: Maximilian Michel <michel@in.tum.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] rfcomm + pppd Kernel oops
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
Date: Mon, 07 Nov 2005 16:20:36 +0100

Hallo,

when i try to tear down a Bluetooth rfcomm-ppp connection, this happens.
I hope, someone finds this interesting and knows what to do.

Thanks,

max




Nov  7 16:10:57 fry pppd[25016]: Terminating on signal 15.
Nov  7 16:10:57 fry pppd[25016]: Script /etc/ppp/ip-down started (pid 25257)
Nov  7 16:10:57 fry pppd[25016]: sent [LCP TermReq id=0x2 "User request"]
Nov  7 16:10:58 fry pppd[25016]: Script /etc/ppp/ip-down finished (pid 
25257), status = 0x1
Nov  7 16:11:01 fry pppd[25016]: sent [LCP TermReq id=0x3 "User request"]
Nov  7 16:11:04 fry pppd[25016]: Connection terminated.
Nov  7 16:11:04 fry pppd[25016]: Connect time 15.5 minutes.
Nov  7 16:11:04 fry pppd[25016]: Sent 529 bytes, received 508 bytes.
Nov  7 16:11:05 fry kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000008
Nov  7 16:11:05 fry kernel:  printing eip:
Nov  7 16:11:05 fry kernel: c02c77fd
Nov  7 16:11:05 fry kernel: *pde = 00000000
Nov  7 16:11:05 fry kernel: Oops: 0000 [#1]
Nov  7 16:11:05 fry kernel: PREEMPT
Nov  7 16:11:05 fry kernel: Modules linked in: ppp_deflate zlib_deflate 
zlib_inflate bsd_comp ppp_async ppp_generic slhc rfcomm l2cap hci_usb 
bluetooth wlan_wep ath_pci ath_rate_onoe wlan ath_hal md5 ipv6 
snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq 
snd_seq_device ohci_hcd irtty_sir sir_dev irda crc_ccitt parport_pc 
parport 8250_pnp 8250 serial_core floppy yenta_socket rsrc_nonstatic 
pcmcia_core snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm snd_timer 
snd soundcore snd_page_alloc tpm_nsc tpm ehci_hcd usbmouse usbhid 
uhci_hcd usbcore ntfs rtcmosram smapi thinkpad ibm_acpi e1000 nvram
Nov  7 16:11:05 fry kernel: CPU:    0
Nov  7 16:11:05 fry kernel: EIP:    0060:[<c02c77fd>]    Tainted: P      VLI
Nov  7 16:11:05 fry kernel: EFLAGS: 00210246   (2.6.12-gentoo-r6)
Nov  7 16:11:05 fry kernel: EIP is at sock_sendmsg+0xdd/0x150
Nov  7 16:11:05 fry kernel: eax: 00000000   ebx: 00000000   ecx: 
d0771a20   edx: da34c000
Nov  7 16:11:05 fry kernel: esi: 00000004   edi: da34de24   ebp: 
da34dd5c   esp: da34dcfc
Nov  7 16:11:05 fry kernel: ds: 007b   es: 007b   ss: 0068
Nov  7 16:11:05 fry kernel: Process pppd (pid: 25016, 
threadinfo=da34c000 task=d0771a20)
Nov  7 16:11:05 fry kernel: Stack: 00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000004
Nov  7 16:11:05 fry kernel:        00000000 00000000 00000000 da34de24 
00000000 00000000 00000000 00000000
Nov  7 16:11:05 fry kernel:        00000000 00000000 00000000 00000000 
00000000 00000000 da34dd70 c01157fc
Nov  7 16:11:05 fry kernel: Call Trace:
Nov  7 16:11:05 fry kernel:  [<c01157fc>] recalc_task_prio+0x8c/0x160
Nov  7 16:11:05 fry kernel:  [<c01157fc>] recalc_task_prio+0x8c/0x160
Nov  7 16:11:05 fry kernel:  [<c012f1b0>] autoremove_wake_function+0x0/0x60
Nov  7 16:11:05 fry kernel:  [<c02c78b6>] kernel_sendmsg+0x46/0x60
Nov  7 16:11:05 fry kernel:  [<e1be5b94>] rfcomm_send_frame+0x54/0x60 
[rfcomm]
Nov  7 16:11:05 fry kernel:  [<e1be5cfc>] rfcomm_send_disc+0x6c/0x70 
[rfcomm]
Nov  7 16:11:05 fry kernel:  [<e1be5580>] __rfcomm_dlc_close+0xe0/0x100 
[rfcomm]Nov  7 16:11:05 fry kernel:  [<e1bea0d0>] 
rfcomm_tty_close+0x0/0xa0 [rfcomm]
Nov  7 16:11:05 fry kernel:  [<e1be55c3>] rfcomm_dlc_close+0x23/0x40 
[rfcomm]
Nov  7 16:11:05 fry kernel:  [<e1bea135>] rfcomm_tty_close+0x65/0xa0 
[rfcomm]
Nov  7 16:11:05 fry kernel:  [<c0203d5e>] release_dev+0x6ae/0x800
Nov  7 16:11:05 fry kernel:  [<c02061f0>] n_tty_flush_buffer+0x0/0x50
Nov  7 16:11:05 fry kernel:  [<c0204de3>] tty_ioctl+0x133/0x5d0
Nov  7 16:11:05 fry kernel:  [<c02043a4>] tty_release+0x14/0x20
Nov  7 16:11:05 fry kernel:  [<c015fcda>] __fput+0x15a/0x1a0
Nov  7 16:11:05 fry kernel:  [<c015e0d2>] filp_close+0x52/0xa0
Nov  7 16:11:05 fry kernel:  [<c015e178>] sys_close+0x58/0xa0
Nov  7 16:11:05 fry kernel:  [<c01031d5>] syscall_call+0x7/0xb
Nov  7 16:11:05 fry kernel: Code: 00 8d 84 24 c0 00 00 00 89 84 24 c0 00 
00 00 89 84 24 c4 00 00 00 8d 44 24 10 89 84 24 d4 00 00 00 31 c0 89 44 
24 28 89 74 24 1c <8b> 43 08 89 74 24 0c 89 7c 24 08 89 5c 24 04 89 2c 
24 ff 50 38



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
