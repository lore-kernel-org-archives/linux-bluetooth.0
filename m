Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] oops when playing audio
From: Marcel Holtmann <marcel@holtmann.org>
To: Dagfinn Ilmari =?ISO-8859-1?Q?Manns=E5ker?= <ilmari@ilmari.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d8jpt8413da.fsf@wirth.ping.uio.no>
References: <d8jpt8413da.fsf@wirth.ping.uio.no>
Content-Type: text/plain
Message-Id: <1087228927.13792.17.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 14 Jun 2004 18:02:07 +0200

Hi Ilmari,

> I was just playing around with hstest and my new Bluetooth headset (a
> Jabra BT250, to be precise) when I got this oops after a few minutes'
> playback:
> 
> usb 1-1: new full speed USB device using address 3
> usb 1-1: USB disconnect, address 3
> __tx_submit: hci0 tx submit failed urb cff5a614 type 3 err -19
> __tx_submit: hci0 tx submit failed urb cff5a614 type 3 err -19
> usb 1-1: new full speed USB device using address 4
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c021d454
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> Modules linked in: sco hci_usb af_packet prism54 firmware_class nfs lockd sunrpc rfcomm l2cap bluetooth md5 ipv6 smsc_ircc2 ds iptable_nat ipt_state ip_conntrack iptable_mangle iptable_filter ip_tables e100 mii snd_maestro3 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_timer snd soundcore uhci_hcd usbcore yenta_socket pcmcia_core intel_agp agpgart ircomm_tty ircomm irda ide_cd cdrom mousedev joydev evdev psmouse apm i8k unix
> CPU:    0
> EIP:    0060:[<c021d454>]    Not tainted VLI
> EFLAGS: 00210287   (2.6.7-rc3-mm1) 
> EIP is at skb_release_data+0x34/0xa0
> eax: cffc7cd8   ebx: 00000000   ecx: cffc7cd8   edx: 00000000
> esi: c1d26560   edi: cbc9af38   ebp: cc9c57c0   esp: cbc9ae64
> ds: 007b   es: 007b   ss: 0068
> Process hstest (pid: 1437, threadinfo=cbc9a000 task=cf80f830)
> Stack: c1d26560 00000030 c021d4c8 00000000 c021d56c c1d26560 c1d26560 00000030 
>        c1d26560 c1d26560 d09d252e 00000030 00000000 00000000 d09fe660 cbc9aed8 
>        00000800 c0219f40 00000800 00000000 bfffee30 00000000 00000000 00000000 
> Call Trace:
>  [<c021d4c8>] kfree_skbmem+0x8/0x20
>  [<c021d56c>] __kfree_skb+0x8c/0x120
>  [<d09d252e>] bt_sock_recvmsg+0x7e/0xb0 [bluetooth]
>  [<c0219f40>] sock_aio_read+0xb0/0xd0
>  [<c014e7ed>] do_sync_read+0x6d/0xb0
>  [<c016007d>] sys_select+0x24d/0x4b0
>  [<c014e917>] vfs_read+0xe7/0x110
>  [<c014eb38>] sys_read+0x38/0x60
>  [<c0103ef9>] sysenter_past_esp+0x52/0x71
> 
> Code: 0f 8b 80 a8 00 00 00 ff 08 0f 94 c2 84 d2 74 7a 8b 8e a8 00 00 00 8b 51 04 89 c8 85 d2 74 38 31 db 39 d3 73 32 89 f6 8b 54 d8 10 <8b> 02 f6 c4 08 75 17 8b 42 04 40 74 48 83 42 04 ff 0f 98 c0 84 
>  <3>hci_scodata_packet: hci0 SCO packet for unknown connection handle 43
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 43
> 
> hsplay segfaulted, but I was able to start playing again afterwards.
> Also, the kernel disconnects and reconnects the device spontaneously
> every once in a while while playing (both before and after the oops),
> like this:
> 
> Jun 13 06:13:22 galadriel kernel: usb 1-1: new full speed USB device using address 5
> Jun 13 06:15:19 galadriel kernel: usb 1-1: USB disconnect, address 5
> Jun 13 06:15:20 galadriel kernel: usb 1-1: new full speed USB device using address 6
> Jun 13 06:15:57 galadriel kernel: usb 1-1: USB disconnect, address 6
> Jun 13 06:15:57 galadriel kernel: usb 1-1: new full speed USB device using address 7
> 
> I'm running 2.6.7-rc3-mm1 on a Dell Inspiron 4000 (P-III 800Mhz) and
> using an MSI USB Bluetooth dongle. The relevant .config snippet is:

try it without the --mm1 patch. What does "hciconfig -a" say about your
Bluetooth dongle?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
