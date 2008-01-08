Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jan 2008 14:32:16 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Tejun Heo <htejun@gmail.com>
Message-ID: <20080108133215.GA15814@boogie.lpds.sztaki.hu>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>
	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>
	<20080102151642.GA7273@boogie.lpds.sztaki.hu>
	<20080105075039.GF27894@ZenIV.linux.org.uk>
	<20080107141300.GB12763@boogie.lpds.sztaki.hu>
	<47824415.80703@gmail.com>
	<20080107210024.GA13537@boogie.lpds.sztaki.hu>
	<47834593.1000506@gmail.com>
MIME-Version: 1.0
In-Reply-To: <47834593.1000506@gmail.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
	bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] Oops involving RFCOMM and sysfs
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tue, Jan 08, 2008 at 06:42:43PM +0900, Tejun Heo wrote:

> Thanks.  Please apply the attached patch and report the oops.

Jan  8 14:23:29 twister kernel: XXX: moving /devices/virtual/tty/rfcomm0 under /devices/pci0000:00/0000:00:02.0/usb1/1-3/1-3:1.0/hci0/acl001BAFE1624D/tty
Jan  8 14:23:29 twister kernel: XXX: looking up / (ffff8100bf400000) / devices
Jan  8 14:23:29 twister kernel: XXX: looking up devices (ffff8100bf658cc0) / virtual
Jan  8 14:23:29 twister kernel: XXX: looking up virtual (ffff8100bf417220) / tty
Jan  8 14:23:29 twister kernel: XXX: looking up tty (ffff8100bb31c440) / rfcomm0
Jan  8 14:23:29 twister kernel: XXX: looking up / (ffff8100bf400000) / devices
Jan  8 14:23:29 twister kernel: XXX: looking up devices (ffff8100bf658cc0) / pci0000:00
Jan  8 14:23:29 twister kernel: XXX: looking up pci0000:00 (ffff8100bf658880) / 0000:00:02.0
Jan  8 14:23:29 twister kernel: XXX: looking up 0000:00:02.0 (ffff8100bb2abcc0) / usb1
Jan  8 14:23:29 twister kernel: XXX: looking up usb1 (ffff8100bb306000) / 1-3
Jan  8 14:23:29 twister kernel: XXX: looking up 1-3 (ffff8100bb309220) / 1-3:1.0
Jan  8 14:23:29 twister kernel: XXX: looking up 1-3:1.0 (ffff8100bb309880) / hci0
Jan  8 14:23:29 twister kernel: XXX: looking up hci0 (ffff8100bb318aa0) / acl001BAFE1624D
Jan  8 14:23:29 twister kernel: XXX: looking up acl001BAFE1624D (ffff8100b555a000) / tty
Jan  8 14:23:52 twister kernel: XXX: moving /devices/pci0000:00/0000:00:02.0/usb1/1-3/1-3:1.0/hci0/acl001BAFE1624D/tty/rfcomm0 under /devices/virtual/tty
Jan  8 14:23:52 twister kernel: XXX: looking up / (ffff8100bf400000) / devices
Jan  8 14:23:52 twister kernel: XXX: looking up devices (ffff8100bf658cc0) / pci0000:00
Jan  8 14:23:52 twister kernel: XXX: looking up pci0000:00 (ffff8100bf658880) / 0000:00:02.0
Jan  8 14:23:52 twister kernel: XXX: looking up 0000:00:02.0 (ffff8100bb2abcc0) / usb1
Jan  8 14:23:52 twister kernel: XXX: looking up usb1 (ffff8100bb306000) / 1-3
Jan  8 14:23:52 twister kernel: XXX: looking up 1-3 (ffff8100bb309220) / 1-3:1.0
Jan  8 14:23:52 twister kernel: XXX: looking up 1-3:1.0 (ffff8100bb309880) / hci0
Jan  8 14:23:52 twister kernel: XXX: looking up hci0 (ffff8100bb318aa0) / acl001BAFE1624D
Jan  8 14:23:52 twister kernel: XXX: looking up acl001BAFE1624D (0000000000000000) / 
Jan  8 14:23:52 twister kernel: Unable to handle kernel NULL pointer dereference at 00000000000000b8 RIP: 
Jan  8 14:23:52 twister kernel:  [<ffffffff80473875>] mutex_lock+0x10/0x1d
Jan  8 14:23:52 twister kernel: PGD b19b6067 PUD b1969067 PMD 0 
Jan  8 14:23:52 twister kernel: Oops: 0002 [1] 
Jan  8 14:23:52 twister kernel: CPU 0 
Jan  8 14:23:52 twister kernel: Modules linked in: binfmt_misc rfcomm l2cap nfsd auth_rpcgss exportfs ipt_REJECT xt_tcpudp ipt_LOG xt_limit iptable_filter ip_tables x_tables nfs lockd nfs_acl sunrpc fuse dm_crypt saa7134_alsa radeon hwmon_vid eeprom hci_usb bluetooth usb_storage tuner tea5767 tda8290 tuner_simple mt20xx tea5761 snd_intel8x0 sg snd_ac97_codec ac97_bus saa7134 firewire_ohci firewire_core crc_itu_t videobuf_dma_sg videobuf_core ir_kbd_i2c snd_pcm ir_common sky2 forcedeth ehci_hcd snd_timer snd_page_alloc ohci_hcd sr_mod parport_pc parport cdrom floppy
Jan  8 14:23:52 twister kernel: Pid: 3228, comm: cat Not tainted 2.6.24-rc6debug-dirty #7
Jan  8 14:23:52 twister kernel: RIP: 0010:[<ffffffff80473875>]  [<ffffffff80473875>] mutex_lock+0x10/0x1d
Jan  8 14:23:52 twister kernel: RSP: 0018:ffff8100b19a5d08  EFLAGS: 00010246
Jan  8 14:23:52 twister kernel: RAX: 0000000000000000 RBX: 00000000000000b8 RCX: 0000000000010352
Jan  8 14:23:52 twister kernel: RDX: ffff8100b19a5fd8 RSI: 0000000000010352 RDI: 00000000000000b8
Jan  8 14:23:52 twister kernel: RBP: ffffffff80593db0 R08: 0000000000000000 R09: 0000000000000097
Jan  8 14:23:52 twister kernel: R10: 000000000000000e R11: ffffffff803103d4 R12: ffff8100ba312b90
Jan  8 14:23:52 twister kernel: R13: ffff8100bfa78d00 R14: ffff8100b1980b00 R15: ffff8100b6c6b840
Jan  8 14:23:52 twister kernel: FS:  00002b3bd213d6e0(0000) GS:ffffffff805ba000(0000) knlGS:0000000000000000
Jan  8 14:23:52 twister kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jan  8 14:23:52 twister kernel: CR2: 00000000000000b8 CR3: 00000000b19ae000 CR4: 00000000000006e0
Jan  8 14:23:52 twister kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jan  8 14:23:52 twister kernel: DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jan  8 14:23:52 twister kernel: Process cat (pid: 3228, threadinfo ffff8100b19a4000, task ffff8100b18d9060)
Jan  8 14:23:52 twister kernel: Stack:  ffff8100bfa78d00 ffffffff8028560d ffff8100b554ca28 ffffffff802ae9d5
Jan  8 14:23:52 twister kernel:  ffff8100bf9f4fa0 ffff8100ba312b90 ffff8100b5326c60 ffffffff802af2de
Jan  8 14:23:52 twister kernel:  ffff8100b6ca4cd0 ffff8100b6ca4cd0 ffff8100bfa78d00 ffff8100b5326ba0
Jan  8 14:23:52 twister kernel: Call Trace:
Jan  8 14:23:52 twister kernel:  [<ffffffff8028560d>] dput+0x26/0x103
Jan  8 14:23:52 twister kernel:  [<ffffffff802ae9d5>] __sysfs_get_dentry+0x5f/0xa9
Jan  8 14:23:52 twister kernel:  [<ffffffff802af2de>] sysfs_move_dir+0xae/0x247
Jan  8 14:23:52 twister kernel:  [<ffffffff80300805>] kobject_move+0xba/0x110
Jan  8 14:23:52 twister kernel:  [<ffffffff8036992c>] device_move+0x59/0x111
Jan  8 14:23:52 twister kernel:  [<ffffffff8827c433>] :rfcomm:rfcomm_tty_close+0x2f/0x74
Jan  8 14:23:52 twister kernel:  [<ffffffff803447ef>] release_dev+0x212/0x5e2
Jan  8 14:23:52 twister kernel:  [<ffffffff8021b609>] do_page_fault+0x2ff/0x65a
Jan  8 14:23:52 twister kernel:  [<ffffffff80344bcb>] tty_release+0xc/0x10
Jan  8 14:23:52 twister kernel:  [<ffffffff80277013>] __fput+0xb1/0x16f
Jan  8 14:23:52 twister kernel:  [<ffffffff80274961>] filp_close+0x5d/0x65
Jan  8 14:23:52 twister kernel:  [<ffffffff80275ab3>] sys_close+0x73/0xa6
Jan  8 14:23:52 twister kernel:  [<ffffffff8020b5fc>] tracesys+0xdc/0xe1
Jan  8 14:23:52 twister kernel: 
Jan  8 14:23:52 twister kernel: 
Jan  8 14:23:52 twister kernel: Code: ff 0f 79 05 e8 c9 00 00 00 58 5a 5b c3 41 54 48 8d 47 08 48 
Jan  8 14:23:52 twister kernel: RIP  [<ffffffff80473875>] mutex_lock+0x10/0x1d
Jan  8 14:23:52 twister kernel:  RSP <ffff8100b19a5d08>
Jan  8 14:23:52 twister kernel: CR2: 00000000000000b8
Jan  8 14:23:52 twister kernel: ---[ end trace d7aa1b498ca58476 ]---

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
