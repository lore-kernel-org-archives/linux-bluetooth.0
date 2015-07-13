Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jul 2015 13:26:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Joshua_Frkuska@mentor.com
Subject: Re: [PATCH v2 5/8] Bluetooth: l2cap_sock_shutdown() reduce scope of
 chan locking
Message-ID: <20150713102624.GA14528@t440s.lan>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
 <1435078779-4436-6-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435078779-4436-6-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Tue, Jun 23, 2015, Dean Jenkins wrote:
> @@ -1115,24 +1115,22 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
>  
>  	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
>  
> -	l2cap_chan_lock(chan);
> -
>  	if (chan->mode == L2CAP_MODE_ERTM &&
>  	    chan->unacked_frames > 0 &&
>  	    chan->state == BT_CONNECTED)
>  		err = __l2cap_wait_ack(sk, chan);
>  
> +	l2cap_chan_lock(chan);
>  	release_sock(sk);
>  	l2cap_chan_close(chan, 0);

This l2cap_chan_close() could call l2cap_chan_del() which in turn could
could call list_del(&chan->list). This list is protected using
conn->chan_lock which you removed in your previous (4/8) patch from
l2cap_sock_shutdown().

Because of the missing mutex_lock(&conn->chan_lock) I now occasionally
get a race condition triggered which crashes the kernel. The following
was triggered with "l2cap-tester -p "L2CAP LE ATT Client - Success":

[ +22.878792] BUG: unable to handle kernel paging request at 6b6b68cf
[  +0.000423] IP: [<f83b6bee>] l2cap_chan_lock+0x6/0x15 [bluetooth]
[  +0.000300] *pde = 00000000 
[  +0.000104] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC 
[  +0.000272] Modules linked in: btusb btintel btbcm btrtl hci_vhci rfcomm bluetooth_6lowpan bluetooth
[  +0.000517] CPU: 0 PID: 1012 Comm: kworker/u5:2 Not tainted 4.1.0+ #1359
[  +0.000308] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.1-20150318_183358- 04/01/2014
[  +0.000342] Workqueue: hci0 hci_rx_work [bluetooth]
[  +0.000000] task: f5655140 ti: f22b8000 task.ti: f22b8000
[  +0.000000] EIP: 0060:[<f83b6bee>] EFLAGS: 00010212 CPU: 0
[  +0.000000] EIP is at l2cap_chan_lock+0x6/0x15 [bluetooth]
[  +0.000000] EAX: 6b6b6b83 EBX: 6b6b68bf ECX: c1053dad EDX: 00000001
[  +0.000000] ESI: f53c4580 EDI: f22ccd70 EBP: f22b9dc8 ESP: f22b9d78
[  +0.000000]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[  +0.000000] CR0: 8005003b CR2: 6b6b68cf CR3: 3216f000 CR4: 00000690
[  +0.000000] Stack:
[  +0.000000]  f22b9dc8 f83bcb01 00000000 00000000 f83da1f4 f53c4593 f22ccea4 f5655140
[  +0.000000]  f83da1c0 00000246 f52ef654 f22cce9c f22b9ddc c13fa8ff 00000000 f83a2b95
[  +0.000000]  f83da1f4 f83da4e0 f53c4580 f22b9de4 f22b9df4 f83a2bb4 f53c4580 f53c4580
[  +0.000000] Call Trace:
[  +0.000000]  [<f83bcb01>] ? l2cap_connect_cfm+0x1d2/0x2f2 [bluetooth]
[  +0.000000]  [<c13fa8ff>] ? mutex_lock_nested+0x32f/0x346
[  +0.000000]  [<f83a2b95>] ? hci_connect_cfm+0x18/0x5d [bluetooth]
[  +0.000000]  [<f83a2bb4>] hci_connect_cfm+0x37/0x5d [bluetooth]
[  +0.000000]  [<f83a2bb4>] ? hci_connect_cfm+0x37/0x5d [bluetooth]
[  +0.000000]  [<f83a7228>] hci_le_meta_evt+0x445/0x801 [bluetooth]
[  +0.000000]  [<c10e57f9>] ? kmem_cache_free+0x135/0x189
[  +0.000000]  [<c1327f4b>] ? __kfree_skb+0x61/0x64
[  +0.000000]  [<c1327f4b>] ? __kfree_skb+0x61/0x64
[  +0.000000]  [<f83a9136>] hci_event_packet+0x1b52/0x2090 [bluetooth]
[  +0.000000]  [<c1327799>] ? skb_dequeue+0x17/0x32
[  +0.000000]  [<c10653cf>] ? trace_hardirqs_on+0xb/0xd
[  +0.000000]  [<c13fcf20>] ? _raw_spin_unlock_irqrestore+0x44/0x57
[  +0.000000]  [<f839ba46>] hci_rx_work+0xf1/0x28b [bluetooth]
[  +0.000000]  [<f839ba46>] ? hci_rx_work+0xf1/0x28b [bluetooth]
[  +0.000000]  [<c1048352>] ? process_one_work+0x152/0x432
[  +0.000000]  [<c1048432>] process_one_work+0x232/0x432
[  +0.000000]  [<c1048432>] ? process_one_work+0x232/0x432
[  +0.000000]  [<c1048a4c>] worker_thread+0x1b8/0x255
[  +0.000000]  [<c1048894>] ? rescuer_thread+0x23c/0x23c
[  +0.000000]  [<c1048894>] ? rescuer_thread+0x23c/0x23c
[  +0.000000]  [<c104c878>] kthread+0x91/0x96
[  +0.000000]  [<c13fd581>] ret_from_kernel_thread+0x21/0x30
[  +0.000000]  [<c104c7e7>] ? __kthread_parkme+0x72/0x72
[  +0.000000] Code: f8 04 b3 02 74 11 68 04 5f 3d f8 68 68 d3 3d f8 e8 bd a2 e3 c8 58 5a 8d 65 f4 88 d8 5b 5e 5f 5d 8d 67 f8 5f c3 55 05 c4 02 00 00 <8b> 90 4c fd ff ff 89 e5 e8 d5 39 04 c9 5d c3 55 89 e5 56 53 3e
[  +0.000000] EIP: [<f83b6bee>] l2cap_chan_lock+0x6/0x15 [bluetooth] SS:ESP 0068:f22b9d78
[  +0.000000] CR2: 000000006b6b68cf

To me this looks like the connected transition racing with user space
closing the socket in question (hence triggering l2cap_sock_shutdown).
It doesn't happen everytime, but it's not the only l2cap-tester case
that I've seen triggering this crash. If you just keep running
"l2cap-tester -q" over and over again you should quite quickly see the
issue.

Johan
