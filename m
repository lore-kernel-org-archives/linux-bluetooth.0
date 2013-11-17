Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 Nov 2013 20:47:44 +0100
From: Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <581763626.20131117204744@eikelenboom.it>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Gustavo Padovan <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Subject: BUG: unable to handle kernel paging request at 00000015832a8e23 RIP  [<ffffffff81a57c30>] rfcomm_sock_getsockopt+0x140/0x240
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This 3.13 merge window seems to have introduced the following bluetooth regression for me:

[   62.040810] BUG: unable to handle kernel paging request at 00000015832a8e23
[   62.049196] IP: [<ffffffff81a57c30>] rfcomm_sock_getsockopt+0x140/0x240
[   62.057800] PGD 0 
[   62.064574] Oops: 0000 [#1] PREEMPT SMP 
[   62.070653] Modules linked in:
[   62.076596] CPU: 4 PID: 5575 Comm: bluetoothd Not tainted 3.12.0-mw-20131117+ #1
[   62.082708] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
[   62.088827] task: ffff88005863a180 ti: ffff880057688000 task.ti: ffff880057688000
[   62.095020] RIP: e030:[<ffffffff81a57c30>]  [<ffffffff81a57c30>] rfcomm_sock_getsockopt+0x140/0x240
[   62.101372] RSP: e02b:ffff880057689ec8  EFLAGS: 00010246
[   62.107668] RAX: 00000015832a8e23 RBX: 0000000000000003 RCX: 00007fff610ca0e8
[   62.113957] RDX: 0000000000000003 RSI: 0000000000000012 RDI: ffff8800572a9e00
[   62.120174] RBP: ffff880057689f18 R08: 00007fff610ca0ec R09: 00007fff610ca360
[   62.126481] R10: 00007fff610ca0e8 R11: 0000000000000202 R12: ffff8800569c3000
[   62.132872] R13: 00007fff610ca0e8 R14: 0000000000000000 R15: 00007fff610ca0ec
[   62.139187] FS:  00007f0d0b348720(0000) GS:ffff88005f700000(0000) knlGS:0000000000000000
[   62.145551] CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
[   62.151919] CR2: 00000015832a8e23 CR3: 0000000056f53000 CR4: 0000000000000660
[   62.158338] Stack:
[   62.164798]  ffff880057689f18 ffffffff81a5799f 0015832a8e23001f ffff880057689f40
[   62.171410]  ffff880057689f44 ffff8800572a9e00 0000000000000012 0000000000000003
[   62.178096]  0000000000000000 00007fff610ca0e8 ffff880057689f78 ffffffff81905bc2
[   62.184781] Call Trace:
[   62.191344]  [<ffffffff81a5799f>] ? rfcomm_sock_setsockopt+0x5f/0x1b0
[   62.197978]  [<ffffffff81905bc2>] SyS_getsockopt+0x62/0xb0
[   62.204645]  [<ffffffff81a8aa79>] system_call_fastpath+0x16/0x1b
[   62.211366] Code: 84 24 40 04 00 00 4c 89 e9 83 e0 01 e8 ea 0a 9d ff 85 c0 75 b5 45 31 f6 e9 42 ff ff ff 66 0f 1f 44 00 00 49 8b 84 24 50 04 00 00 <48> 8b 00 48 89 45 b8 e8 04 e7 6f ff 4c 89 f8 e8 2c fa 9c ff 85 
[   62.225815] RIP  [<ffffffff81a57c30>] rfcomm_sock_getsockopt+0x140/0x240
[   62.232986]  RSP <ffff880057689ec8>
[   62.240128] CR2: 00000015832a8e23
[   62.247221] ---[ end trace 88f75f0c791ac25b ]---

My bluetooth device is USB stick:
Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

--

Sander
