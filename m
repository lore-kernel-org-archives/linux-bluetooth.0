Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 May 2014 20:32:19 +0200
From: Sander Eikelenboom <linux@eikelenboom.it>
Reply-To: Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <1169298713.20140501203219@eikelenboom.it>
To: Marcel Holtmann <marcel@holtmann.org>, gianluca@sottospazio.it
CC: linux-bluetooth@vger.kernel.org
Subject: BUG: spinlock wrong CPU on CPU#3, krfcommd/1500 (resend)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi  Gianluca / Marcel,

Sorry for the resend, but i had a typo in the mailinglist address.

Here a splat i just encountered on boot:

[   78.248869] BUG: spinlock wrong CPU on CPU#3, krfcommd/1500
[   78.255126]  lock: 0xffff880056d8ded8, .magic: dead4ead, .owner: krfcommd/1500, .owner_cpu: 0
[   78.261375] CPU: 3 PID: 1500 Comm: krfcommd Not tainted 3.15.0-rc3-20140501-nbdebug5+ #1
[   78.267767] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
[   78.274173]  ffff880056d8ded8 ffff880057217d18 ffffffff81b8d666 ffff88005f6cfd88
[   78.280707]  ffff880056c3a3c0 ffff880057217d38 ffffffff81b8974c ffff880056d8ded8
[   78.287091]  ffffffff81f56fab ffff880057217d58 ffffffff81b89777 ffff880056d8ded8
[   78.293371] Call Trace:
[   78.299496]  [<ffffffff81b8d666>] dump_stack+0x46/0x58
[   78.305601]  [<ffffffff81b8974c>] spin_dump+0x91/0x96
[   78.311662]  [<ffffffff81b89777>] spin_bug+0x26/0x2b
[   78.317599]  [<ffffffff8111a5ce>] do_raw_spin_unlock+0xae/0x100
[   78.323557]  [<ffffffff81b974cb>] _raw_spin_unlock+0x2b/0x40
[   78.329571]  [<ffffffff81b636d3>] rfcomm_run+0x1063/0x1310
[   78.335608]  [<ffffffff81b9754d>] ? _raw_spin_unlock_irqrestore+0x6d/0x90
[   78.341715]  [<ffffffff81b62670>] ? rfcomm_check_accept+0xc0/0xc0
[   78.347830]  [<ffffffff810ee1a4>] kthread+0xe4/0x100
[   78.353916]  [<ffffffff810ee0c0>] ? __init_kthread_worker+0x70/0x70
[   78.360121]  [<ffffffff81b9893c>] ret_from_fork+0x7c/0xb0
[   78.366191]  [<ffffffff810ee0c0>] ? __init_kthread_worker+0x70/0x70


--
Sander

