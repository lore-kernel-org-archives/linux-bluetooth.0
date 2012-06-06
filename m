Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jun 2012 10:53:58 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix potential NULL pointer dereference in
 L2CAP
Message-ID: <20120606075355.GB2754@aemeltch-MOBL1>
References: <1338877241-5346-1-git-send-email-johan.hedberg@gmail.com>
 <20120606035939.GA4125@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120606035939.GA4125@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jun 06, 2012 at 11:59:39AM +0800, Johan Hedberg wrote:
> Hi,
> 
> On Tue, Jun 05, 2012, Johan Hedberg wrote:
> > BUG: unable to handle kernel NULL pointer dereference at 00000004
> > IP: [<c123f9e5>] hci_chan_del+0x41/0x6e
> > *pde = 00000000
> > Oops: 0002 [#1] SMP
> > Modules linked in:
> > 
> > Pid: 32, comm: kworker/u:3 Not tainted 3.5.0-rc1+ #322 Bochs Bochs
> > EIP: 0060:[<c123f9e5>] EFLAGS: 00010246 CPU: 1
> > EIP is at hci_chan_del+0x41/0x6e
> > EAX: 00200909 EBX: f5dd2280 ECX: 00000000 EDX: 00000000
> > ESI: f5d5edc4 EDI: f6201e60 EBP: f6201e50 ESP: f6201e48
> >  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> > CR0: 8005003b CR2: 00000004 CR3: 35f12000 CR4: 00000690
> > DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > DR6: ffff0ff0 DR7: 00000400
> > Process kworker/u:3 (pid: 32, ti=f6200000 task=f686e730 task.ti=f6200000)
> > Stack:
> >  f5d5ef00 f6201e60 f6201e88 c12507b3 f62e6000 c12507b3 c1245fad 0000000c
> >  f5d5ef94 00000026 f5d5ef9c f5d5edc4 f6917800 f62e6000 00000022 f6201e98
> >  f6201ea8 c125440b f6201eb8 c125440b c124963d f6254622 f62e6000 f6201eb8
> > Call Trace:
> >  [<c12507b3>] l2cap_conn_del+0xef/0x135
> >  [<c12507b3>] ? l2cap_conn_del+0xef/0x135
> >  [<c1245fad>] ? mgmt_event+0x95/0xa6
> >  [<c125440b>] l2cap_disconn_cfm+0x49/0x57
> >  [<c125440b>] ? l2cap_disconn_cfm+0x49/0x57
> >  [<c124963d>] ? user_confirm_reply+0x7d/0x7d
> >  [<c124446c>] hci_event_packet+0x33e/0x1cce
> >  [<c124446c>] ? hci_event_packet+0x33e/0x1cce
> >  [<c11e1aaa>] ? __kfree_skb+0x6a/0x6d
> >  [<c11e1af9>] ? kfree_skb+0x25/0x27
> >  [<c124be14>] ? hci_send_to_sock+0x168/0x174
> >  [<c123b66c>] hci_rx_work+0xf3/0x347
> >  [<c123b66c>] ? hci_rx_work+0xf3/0x347
> >  [<c123b9a7>] ? hci_cmd_work+0xb4/0xd8
> > 
> > This patch fixes this issue by adding a NULL check for conn->hchan.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Please ignore this patch for now. After further investigation the issue
> might not be passing NULL to hci_chan_del but that the hchan is not
> properly initialized. It looks like the the crash is happening in
> list_del (inlined into hci_chan_del) and that it's happening because of
> a missing call to INIT_LIST_HEAD(&chan->list); in hci_chan_create().

This is not needed since you add it to conn->chan_list there.

And if this only happens with LE chan creation then there shall be
something special in LE sequence.

Best regards 
Andrei Emeltchenko 

