Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "mrkiko" <mrkiko.rs@gmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 30 Dec 2006 11:33:07 +0000
Message-ID: <elmo11674783871759394055518@atlantide>
MIME-Version: 1.0
Subject: [Bluez-devel] A bug in the bluetooth stack?
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




From: "mrkiko" <mrkiko.rs@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: a grave bug in bluez
Date: Wed, 27 Dec 2006 17:02:41 +0000



I was helped by: Omar. He gave to me his phone because I had to send him a song 
via Obex Push (OBEX OBJECT PUSH PROTOCOL). Many Nokia phones like this, will 
forbid you make more than just one connection. If you try to connect more than 
once simultaneously the bluetooth stack will bring down some layers of the 
kernel!

To reproduce this bug follow the following steps: I here use obexftp but may be 
any application might reproduce the problem as yuo can see with rfcomm...
1 - Connect to the phone sending a relatively big file:
obexftp -b xx:xx:xx:xx:xx:xx -p location/nomefile.ext

And while the phone is receiving the file, in another session type:
rfcomm -i hci1 connect /dev/rfcomm0 xx:xx:xx:xx:xx:xx 1

And you will see the following happen:

Dec 27 16:43:05 atlantide hcid[1022]: link_key_request (sba=00:0B:0D:62:55:00, dba=00:0E:6D:BE:54:9B)
Dec 27 16:45:43 atlantide kernel: add_conn: Failed to register connection device
Dec 27 16:46:03 atlantide kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000c
Dec 27 16:46:03 atlantide kernel:  printing eip:
Dec 27 16:46:03 atlantide kernel: c02440dd
Dec 27 16:46:03 atlantide kernel: *pde = 00000000
Dec 27 16:46:03 atlantide kernel: Oops: 0000 [#1]
Dec 27 16:46:03 atlantide kernel: PREEMPT 
Dec 27 16:46:03 atlantide kernel: Modules linked in: rfcomm l2cap processor af_packet reiserfs hci_usb bluetooth usbhid w83781d hwmon_vid hwmon i2c_isa i2c_i801 i2c_core snd_emu10k1 snd_rawmidi snd_seq_device snd_util_mem snd_hwdep uhci_hcd snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc iTCO_wdt b44 mii ehci_hcd ohci_hcd usbcore atkbd libps2 rtc pcspkr
Dec 27 16:46:03 atlantide kernel: CPU:    0
Dec 27 16:46:03 atlantide kernel: EIP:    0060:[<c02440dd>]    Not tainted VLI
Dec 27 16:46:03 atlantide kernel: EFLAGS: 00010282   (2.6.19.1 #1)
Dec 27 16:46:03 atlantide kernel: EIP is at klist_del+0x6/0x45
Dec 27 16:46:03 atlantide kernel: eax: 00000000   ebx: cee63aa8   ecx: cee63a7c   edx: c1920748
Dec 27 16:46:03 atlantide kernel: esi: cee63ab8   edi: cee63a78   ebp: f7e8b94c   esp: c1949f4c
Dec 27 16:46:03 atlantide kernel: ds: 007b   es: 007b   ss: 0068
Dec 27 16:46:03 atlantide kernel: Process events/0 (pid: 3, ti=c1948000 task=c192d030 task.ti=c1948000)
Dec 27 16:46:03 atlantide kernel: Stack: cee63aa8 c1920740 c01e0e68 00000286 c1920740 cee63a78 cee63a00 c012073a 
Dec 27 16:46:03 atlantide kernel:        00000000 0000a57f 08074116 f89b62e8 c1920750 c1920740 c1920748 00000000 
Dec 27 16:46:03 atlantide kernel:        c0120c36 00000001 00000000 c192da50 00010000 00000000 00000000 c192d030 
Dec 27 16:46:03 atlantide kernel: Call Trace:
Dec 27 16:46:03 atlantide kernel:  [<c01e0e68>] device_del+0x15/0x169
Dec 27 16:46:03 atlantide kernel:  [<c012073a>] run_workqueue+0x8a/0xe6
Dec 27 16:46:03 atlantide kernel:  [<f89b62e8>] del_conn+0x0/0xa [bluetooth]
Dec 27 16:46:03 atlantide kernel:  [<c0120c36>] worker_thread+0xe8/0x11a
Dec 27 16:46:03 atlantide kernel:  [<c01108ea>] default_wake_function+0x0/0xc
Dec 27 16:46:03 atlantide kernel:  [<c0120b4e>] worker_thread+0x0/0x11a
Dec 27 16:46:03 atlantide kernel:  [<c0123083>] kthread+0xad/0xda
Dec 27 16:46:03 atlantide kernel:  [<c0122fd6>] kthread+0x0/0xda
Dec 27 16:46:03 atlantide kernel:  [<c01033cf>] kernel_thread_helper+0x7/0x10
Dec 27 16:46:04 atlantide kernel:  =======================
Dec 27 16:46:04 atlantide kernel: Code: 04 89 42 04 89 10 c7 43 f8 00 01 10 00 c7 41 04 00 02 20 00 8d 43 04 e8 57 ce ec ff c7 43 f4 00 00 00 00 5b c3 56 53 89 c6 8b 00 <8b> 58 0c 89 e0 25 00 e0 ff ff ff 40 14 89 f0 e8 a9 ff ff ff 85 
Dec 27 16:46:04 atlantide kernel: EIP: [<c02440dd>] klist_del+0x6/0x45 SS:ESP 0068:c1949f4c

The key to reproduce this bug is to attempt to connect to the same device 
which allows only one connection with two different hci interfaces!
Please CC me: I'm not subscribed to the list.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
