Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
CC: Gustavo Padovan <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL in read_index_list
Date: Mon, 3 Sep 2012 14:49:59 +0200
Message-ID: <4083892.2VCRePhfBH@uw000953>
In-Reply-To: <20120903123404.GA2789@aemeltch-MOBL1>
References: <1346396746-3479-1-git-send-email-szymon.janc@tieto.com> <20120831175458.GA5599@joana> <20120903123404.GA2789@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 03 of September 2012 15:34:11 Andrei Emeltchenko wrote:
> Hi all,

Hi Andrei,

> 
> On Fri, Aug 31, 2012 at 10:54:58AM -0700, Gustavo Padovan wrote:
> > Hi Szymon,
> > 
> > * Szymon Janc <szymon.janc@tieto.com> [2012-08-31 09:05:46 +0200]:
> > 
> > > read_index_list is executed by user thread running in kernel-mode
> > > thus is allowed to sleep.
> > > 
> > > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > > ---
> > >  net/bluetooth/mgmt.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Patch has been applied to bluetooth-next. Thanks.
> 
> Was this tested? Gustavo please remove this patch from the tree untill
> this issue is fixed.

read_index_list() is only called from mgmt_control() (via mgmt_handlers[]).
mgmt_control (as well as other mgmt_handlers) allocate memory with
GFP_KERNEL flag.

I'm not sure why do you get this warning...

> 
> [  141.009142] BUG: sleeping function called from invalid context at
> mm/slub.c:943
> [  141.009156] in_atomic(): 1, irqs_disabled(): 0, pid: 2476, name:
> bluetoothd
> [  141.009159] 2 locks held by bluetoothd/2476:
> [  141.009161]  #0:  (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.+.}, at:
> [<f8a9c9da>] hci_sock_sendmsg+0x5a/0x310 [bluetooth]
> [  141.009182]  #1:  (hci_dev_list_lock){++++.+}, at: [<f8a9623e>]
> read_index_list+0x2e/0x150 [bluetooth]
> [  141.009200] Pid: 2476, comm: bluetoothd Tainted: G           O 3.5.0+
> #56
> [  141.009202] Call Trace:
> [  141.009208]  [<c10776c9>] __might_sleep+0xe9/0x120
> [  141.009213]  [<c114e249>] __kmalloc+0x1a9/0x240
> [  141.009224]  [<f8a96274>] ? read_index_list+0x64/0x150 [bluetooth]
> [  141.009234]  [<f8a96274>] read_index_list+0x64/0x150 [bluetooth]
> [  141.009244]  [<f8a9a2bc>] mgmt_control+0x22c/0x350 [bluetooth]
> [  141.009248]  [<c10a44fb>] ? trace_hardirqs_on+0xb/0x10
> [  141.009252]  [<c1051298>] ? local_bh_enable+0x68/0xd0
> [  141.009264]  [<f8a9c9da>] ? hci_sock_sendmsg+0x5a/0x310 [bluetooth]
> [  141.009297]  [<f8a9ca43>] hci_sock_sendmsg+0xc3/0x310 [bluetooth]
> [  141.009302]  [<c14f134d>] ? sock_update_classid+0x7d/0x120
> [  141.009306]  [<c14f1378>] ? sock_update_classid+0xa8/0x120
> [  141.009311]  [<c14ecc6b>] sock_aio_write+0xfb/0x120
> [  141.009315]  [<c14ee31e>] ? sys_sendto+0x10e/0x150
> [  141.009320]  [<c115fbf4>] do_sync_write+0xb4/0xf0
> [  141.009326]  [<c112f680>] ? might_fault+0x50/0xa0
> [  141.009330]  [<c11602cc>] ? rw_verify_area+0x6c/0x120
> [  141.009334]  [<c11606f1>] vfs_write+0x151/0x160
> [  141.009337]  [<c14eed02>] ? sys_socketcall+0x182/0x2e0
> [  141.009341]  [<c116090d>] sys_write+0x3d/0x70
> [  141.009345]  [<c15f739f>] sysenter_do_call+0x12/0x38
> 
> Best regards 
> Andrei Emeltchenko 

-- 
BR
Szymon Janc
