Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 28 Apr 2016 16:50:28 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: hci_intel problem
Message-ID: <20160428135028.GB13659@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

Commit 765ea3abd116 ("Bluetooth: hci_intel: Retrieve host-wake IRQ")
seems to create a little regression:

[    2.734749] hci_intel INT33E1:00: No corresponding irq for gpio
[    2.736426] BUG: unable to handle kernel NULL pointer dereference at           (null)
[    2.738631] IP: [<ffffffff8132bee1>] desc_to_gpio+0x1/0x20
[    2.740175] PGD 0 
[    2.740742] Oops: 0000 [#1] SMP 
[    2.741652] Modules linked in:
[    2.742512] CPU: 3 PID: 1 Comm: swapper/0 Tainted: G          I     4.6.0-rc5+ #152
[    2.744663] task: ffff88017ab28000 ti: ffff88017ab14000 task.ti: ffff88017ab14000
[    2.746764] RIP: 0010:[<ffffffff8132bee1>]  [<ffffffff8132bee1>] desc_to_gpio+0x1/0x20
[    2.748990] RSP: 0000:ffff88017ab17d20  EFLAGS: 00010202
[    2.750482] RAX: ffffffff81cb9710 RBX: ffff88007ad85c28 RCX: ffff88017a5032c0
[    2.752486] RDX: 0000000000000000 RSI: ffff88017ab28000 RDI: 0000000000000000
[    2.754490] RBP: ffff88017ab17d48 R08: ffff88017ab14000 R09: 0000000000000000
[    2.756494] R10: 0000000000001c00 R11: 0000000000000000 R12: ffff88017a17a010
[    2.758498] R13: 00000000ffffffea R14: 0000000000000000 R15: ffffffff81c4e220
[    2.760502] FS:  0000000000000000(0000) GS:ffff88017fd80000(0000) knlGS:0000000000000000
[    2.762772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.764386] CR2: 0000000000000000 CR3: 0000000001c06000 CR4: 00000000003406e0
[    2.766390] Stack:
[    2.766954]  ffff88017ab17d48 ffffffff8152efdb ffff88017a17a010 ffffffff81cb9648
[    2.769037]  ffffffff81cb9648 ffff88017ab17d70 ffffffff813e8606 ffff88017a17a010
[    2.771122]  ffff88017a17a010 0000000000000000 ffff88017ab17da0 ffffffff813e69dd
[    2.773206] Call Trace:
[    2.773893]  [<ffffffff8152efdb>] ? intel_probe+0xdb/0x180
[    2.775434]  [<ffffffff813e8606>] platform_drv_probe+0x36/0x90
[    2.777073]  [<ffffffff813e69dd>] driver_probe_device+0x1fd/0x2c0
[    2.778784]  [<ffffffff813e6b36>] __driver_attach+0x96/0xa0
[    2.780349]  [<ffffffff813e6aa0>] ? driver_probe_device+0x2c0/0x2c0
[    2.782109]  [<ffffffff813e4a1f>] bus_for_each_dev+0x5f/0x90
[    2.783698]  [<ffffffff813e61c9>] driver_attach+0x19/0x20
[    2.785214]  [<ffffffff813e5dec>] bus_add_driver+0x1ac/0x220
[    2.786804]  [<ffffffff81d4a4f3>] ? dm_zero_init+0x2a/0x2a
[    2.788344]  [<ffffffff813e734b>] driver_register+0x5b/0xd0
[    2.789909]  [<ffffffff813e8581>] __platform_driver_register+0x31/0x40
[    2.791741]  [<ffffffff81d4a641>] intel_init+0x12/0x20
[    2.793185]  [<ffffffff81d4a5cb>] hci_uart_init+0xd8/0xe2
[    2.794701]  [<ffffffff810003b1>] do_one_initcall+0x81/0x1a0
[    2.796291]  [<ffffffff81d05030>] kernel_init_freeable+0x14a/0x1d0
[    2.798027]  [<ffffffff816873a9>] kernel_init+0x9/0x100
[    2.799495]  [<ffffffff8168ced2>] ret_from_fork+0x22/0x40
[    2.801011]  [<ffffffff816873a0>] ? rest_init+0x80/0x80

I think it's usually ill-advised to convert the gpio descriptors to
numbers unless there is a real need for it. Maybe you can just fix the
dev_info() back to way it was.


thanks,

-- 
heikki
