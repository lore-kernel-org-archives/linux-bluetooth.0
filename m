Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jul 2015 14:12:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, Joshua_Frkuska@mentor.com
Subject: Re: [PATCH v2 5/8] Bluetooth: l2cap_sock_shutdown() reduce scope of
 chan locking
Message-ID: <20150713111255.GA22233@t440s.lan>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
 <1435078779-4436-6-git-send-email-Dean_Jenkins@mentor.com>
 <20150713102624.GA14528@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150713102624.GA14528@t440s.lan>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jul 13, 2015, Johan Hedberg wrote:
> On Tue, Jun 23, 2015, Dean Jenkins wrote:
> > @@ -1115,24 +1115,22 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
> >  
> >  	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
> >  
> > -	l2cap_chan_lock(chan);
> > -
> >  	if (chan->mode == L2CAP_MODE_ERTM &&
> >  	    chan->unacked_frames > 0 &&
> >  	    chan->state == BT_CONNECTED)
> >  		err = __l2cap_wait_ack(sk, chan);
> >  
> > +	l2cap_chan_lock(chan);
> >  	release_sock(sk);
> >  	l2cap_chan_close(chan, 0);
> 
> This l2cap_chan_close() could call l2cap_chan_del() which in turn could
> could call list_del(&chan->list). This list is protected using
> conn->chan_lock which you removed in your previous (4/8) patch from
> l2cap_sock_shutdown().

Here's a full trace of another crash related to the same code path, this
time the teardown_cb() that happens through the l2cap_chan_close() call.
The l2cap-tester case that triggered it was "L2CAP LE Server - Success".
I had debug logs enabled for l2cap_sock.c and l2cap_core.c:

[  +0.000239] l2cap_sock_init: sk f2322a30
[  +0.000193] l2cap_sock_bind: sk f2322a30
[  +0.000161] l2cap_sock_connect: sk f2322a30
[  +0.000171] l2cap_chan_connect: 00:aa:01:00:00:00 -> 00:aa:01:01:00:00 (type 1) psm 0x80
[  +0.000647] l2cap_sock_release: sock f1a84c00, sk f2322a30
[  +0.000638] l2cap_sock_shutdown: sock f1a84c00, sk f2322a30
[  +0.000601] l2cap_chan_hold: chan f22a5c20 orig refcnt 2
[  +0.000404] l2cap_sock_shutdown: chan f22a5c20 state BT_BOUND
[  +0.000267] l2cap_chan_close: chan f22a5c20 state BT_BOUND
[  +0.000241] l2cap_sock_teardown_cb: chan f22a5c20 state BT_BOUND
[  +0.000272] l2cap_chan_put: chan f22a5c20 orig refcnt 3
[  +0.000226] l2cap_sock_shutdown: err: 0
[  +0.000153] l2cap_sock_kill: sk f2322a30 state BT_BOUND
[  +0.000317] l2cap_chan_put: chan f22a5c20 orig refcnt 2
[  +0.000331] l2cap_sock_destruct: sk f2322a30
[  +0.000355] l2cap_chan_put: chan f22a5c20 orig refcnt 1
[  +0.000345] l2cap_chan_destroy: chan f22a5c20
[  +0.016398] l2cap_chan_create: chan f2322a30
[  +0.000642] l2cap_sock_create: sock f1a86d00
[  +0.000467] l2cap_chan_create: chan f23212c0
[  +0.000247] l2cap_chan_hold: chan f23212c0 orig refcnt 1
[  +0.000264] l2cap_sock_init: sk f2323390
[  +0.000188] l2cap_sock_bind: sk f2323390
[  +0.000170] l2cap_sock_connect: sk f2323390
[  +0.000182] l2cap_chan_connect: 00:aa:01:00:00:00 -> 00:aa:01:01:00:00 (type 1) psm 0x80
[  +0.001553] l2cap_conn_add: hcon f22edf90 conn f4ee65a0 hchan f2341dd0
[  +0.000619] __l2cap_chan_add: conn f4ee65a0, psm 0x80, dcid 0x0000
[  +0.000322] l2cap_chan_hold: chan f23212c0 orig refcnt 2
[  +0.000264] l2cap_state_change: chan f23212c0 BT_BOUND -> BT_CONNECT
[  +0.000331] l2cap_chan_hold: chan f23212c0 orig refcnt 3
[  +0.003096] l2cap_connect_cfm: hcon f22edf90 bdaddr 00:aa:01:01:00:00 status 0
[  +0.000335] l2cap_chan_hold: chan f2322a30 orig refcnt 1
[  +0.000219] l2cap_chan_create: chan f2320e10
[  +0.000158] __l2cap_chan_add: conn f4ee65a0, psm 0x00, dcid 0x0006
[  +0.000257] l2cap_chan_hold: chan f2320e10 orig refcnt 1
[  +0.000210] l2cap_chan_put: chan f2322a30 orig refcnt 2
[  +0.000205] l2cap_conn_ready: conn f4ee65a0
[  +0.000154] l2cap_chan_hold: chan f2320e10 orig refcnt 2
[  +0.000210] l2cap_build_cmd: conn f4ee65a0, code 0x14, ident 0x01, len 10
[  +0.000303] l2cap_send_cmd: code 0x14
[  +0.000185] l2cap_le_conn_ready: hci0 conn f4ee65a0
[  +0.000236] process_pending_rx: 
[  +0.003520] l2cap_recv_acldata: conn f4ee65a0 len 18 flags 0x2
[  +0.000460] l2cap_recv_frame: len 14, cid 0x0005
[  +0.000202] l2cap_le_sig_channel: code 0x15 len 10 id 0x01
[  +0.000248] l2cap_le_connect_rsp: dcid 0x0000 mtu 23 mps 23 credits 1 result 0x02
[  +0.000353] l2cap_chan_put: chan f23212c0 orig refcnt 4
[  +0.000227] l2cap_chan_del: chan f23212c0, conn f4ee65a0, err 111, state BT_CONNECT
[  +0.000362] l2cap_sock_teardown_cb: chan f23212c0 state BT_CONNECT
[  +0.000283] l2cap_chan_put: chan f23212c0 orig refcnt 3
[  +0.001285] l2cap_sock_release: sock f1a86d00, sk f2323390
[  +0.000232] l2cap_sock_shutdown: sock f1a86d00, sk f2323390
[  +0.000232] l2cap_chan_hold: chan f23212c0 orig refcnt 2
[  +0.000211] l2cap_sock_shutdown: chan f23212c0 state BT_CLOSED
[  +0.000398] l2cap_chan_close: chan f23212c0 state BT_CLOSED
[  +0.000463] l2cap_sock_teardown_cb: chan f23212c0 state BT_CLOSED
[  +0.000445] l2cap_chan_put: chan f23212c0 orig refcnt 3
[  +0.000314] l2cap_sock_shutdown: err: 0
[  +0.000194] l2cap_sock_kill: sk f2323390 state BT_CLOSED
[  +0.000227] l2cap_chan_put: chan f23212c0 orig refcnt 2
[  +0.000204] l2cap_sock_destruct: sk f2323390
[  +0.000156] l2cap_chan_put: chan f23212c0 orig refcnt 1
[  +0.000204] l2cap_chan_destroy: chan f23212c0
[  +0.000606] l2cap_disconn_cfm: hcon f22edf90 reason 22
[  +0.000214] l2cap_conn_del: hcon f22edf90 conn f4ee65a0, err 103
[  +0.000246] l2cap_chan_hold: chan f2320e10 orig refcnt 3
[  +0.000217] l2cap_chan_del: chan f2320e10, conn f4ee65a0, err 103, state BT_CONNECTED
[  +0.000414] l2cap_chan_put: chan f2320e10 orig refcnt 4
[  +0.000466] l2cap_chan_put: chan f2320e10 orig refcnt 3
[  +0.000359] l2cap_chan_put: chan f2320e10 orig refcnt 2
[  +0.027471] l2cap_chan_put: chan f2322a30 orig refcnt 1
[  +0.000474] l2cap_chan_destroy: chan f2322a30
[  +0.025638] l2cap_chan_create: chan f52daa30
[  +0.000359] l2cap_sock_create: sock f1a87600
[  +0.000181] l2cap_chan_create: chan f52daee0
[  +0.000159] l2cap_chan_hold: chan f52daee0 orig refcnt 1
[  +0.000210] l2cap_sock_init: sk f52d84b0
[  +0.000159] l2cap_sock_bind: sk f52d84b0
[  +0.000145] l2cap_sock_listen: sk f52d84b0 backlog 5
[  +0.001394] l2cap_connect_cfm: hcon f22ece30 bdaddr 00:aa:01:01:00:00 status 0
[  +0.000537] l2cap_conn_add: hcon f22ece30 conn f4fef310 hchan f4faa330
[  +0.000446] l2cap_chan_hold: chan f52daa30 orig refcnt 1
[  +0.000375] l2cap_chan_create: chan f52d8e10
[  +0.000271] __l2cap_chan_add: conn f4fef310, psm 0x00, dcid 0x0006
[  +0.000403] l2cap_chan_hold: chan f52d8e10 orig refcnt 1
[  +0.000332] l2cap_chan_put: chan f52daa30 orig refcnt 2
[  +0.000356] l2cap_conn_ready: conn f4fef310
[  +0.000245] l2cap_chan_hold: chan f52d8e10 orig refcnt 2
[  +0.000334] l2cap_le_conn_ready: hci0 conn f4fef310
[  +0.000414] l2cap_build_cmd: conn f4fef310, code 0x12, ident 0x01, len 8
[  +0.000470] l2cap_send_cmd: code 0x12
[  +0.000246] process_pending_rx: 
[  +0.004040] l2cap_sock_release: sock f1a87600, sk f52d84b0
[  +0.000400] l2cap_sock_shutdown: sock f1a87600, sk f52d84b0
[  +0.000391] l2cap_chan_hold: chan f52daee0 orig refcnt 2
[  +0.000373] l2cap_sock_shutdown: chan f52daee0 state BT_LISTEN
[  +0.000416] l2cap_chan_close: chan f52daee0 state BT_LISTEN
[  +0.000390] l2cap_sock_teardown_cb: chan f52daee0 state BT_LISTEN
[  +0.000072] l2cap_recv_acldata: conn f4fef310 len 18 flags 0x2
[  +0.000002] l2cap_recv_frame: len 14, cid 0x0005
[  +0.000002] l2cap_le_sig_channel: code 0x14 len 10 id 0x01
[  +0.000002] l2cap_le_connect_req: psm 0x80 scid 0x0041 mtu 32 mps 32
[  +0.000003] l2cap_chan_hold: chan f52daee0 orig refcnt 3
[  +0.002304] l2cap_sock_cleanup_listen: parent f52d84b0 state BT_LISTEN
[  +0.000464] l2cap_chan_put: chan f52daee0 orig refcnt 4
[  +0.000363] l2cap_sock_shutdown: err: 0
[  +0.000035] l2cap_chan_create: chan f22a5770
[  +0.000001] l2cap_chan_hold: chan f22a5770 orig refcnt 1
[  +0.000002] l2cap_sock_init: sk f22a5c20
[  +0.000003] __l2cap_chan_add: conn f4fef310, psm 0x80, dcid 0x0041
[  +0.000001] l2cap_chan_hold: chan f22a5770 orig refcnt 2
[  +0.000001] l2cap_chan_hold: chan f22a5770 orig refcnt 3
[  +0.000010] l2cap_chan_put: chan f22a5770 orig refcnt 4
[  +0.000002] l2cap_sock_ready_cb: sk f22a5c20, parent f52d84b0
[  +0.000002] l2cap_chan_put: chan f52daee0 orig refcnt 3
[  +0.000001] l2cap_build_cmd: conn f4fef310, code 0x15, ident 0x01, len 10
[  +0.000026] l2cap_send_cmd: code 0x15
[  +0.000056] l2cap_recv_acldata: conn f4fef310 len 10 flags 0x2
[  +0.000002] l2cap_recv_frame: len 6, cid 0x0005
[  +0.000001] l2cap_le_sig_channel: code 0x13 len 2 id 0x01
[  +0.005157] l2cap_sock_kill: sk f52d84b0 state BT_CLOSED
[  +0.000379] l2cap_chan_put: chan f52daee0 orig refcnt 2
[  +0.000369] l2cap_sock_destruct: sk f52d84b0
[  +0.000275] l2cap_chan_put: chan f52daee0 orig refcnt 1
[  +0.000350] l2cap_chan_destroy: chan f52daee0
[  +0.000295] l2cap_disconn_cfm: hcon f22ece30 reason 22
[  +0.000207] l2cap_conn_del: hcon f22ece30 conn f4fef310, err 103
[  +0.000284] l2cap_chan_hold: chan f22a5770 orig refcnt 3
[  +0.000236] l2cap_chan_del: chan f22a5770, conn f4fef310, err 103, state BT_CONNECTED
[  +0.000381] l2cap_sock_teardown_cb: chan f22a5770 state BT_CONNECTED
[  +0.000287] ------------[ cut here ]------------
[  +0.000188] WARNING: CPU: 0 PID: 830 at lib/list_debug.c:59 __list_del_entry+0x3f/0x71()
[  +0.000378] list_del corruption. prev->next should be f22a5ee0, but was 6b6b6b6b
[  +0.000535] Modules linked in: btusb btintel btbcm btrtl hci_vhci rfcomm bluetooth_6lowpan bluetooth
[  +0.000818] CPU: 0 PID: 830 Comm: l2cap-tester Not tainted 4.1.0+ #1359
[  +0.000493] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.1-20150318_183358- 04/01/2014
[  +0.001082]  00000000 00000000 f52efdd8 c13f89bb f52efe00 f52efdf0 c1037089 c11efa16
[  +0.000792]  6b6b6b6b f22a5ee0 f52efe50 f52efe08 c10370cb 00000009 f52efe00 c1613939
[  +0.000828]  f52efe1c f52efe28 c11efa16 c1613843 0000003b c1613939 f22a5ee0 6b6b6b6b
[  +0.000916] Call Trace:
[  +0.000115]  [<c13f89bb>] dump_stack+0x49/0x73
[  +0.000285]  [<c1037089>] warn_slowpath_common+0x83/0x9a
[  +0.000364]  [<c11efa16>] ? __list_del_entry+0x3f/0x71
[  +0.000340]  [<c10370cb>] warn_slowpath_fmt+0x2b/0x2f
[  +0.000330]  [<c11efa16>] __list_del_entry+0x3f/0x71
[  +0.000340]  [<f9401202>] bt_accept_unlink+0x47/0x84 [bluetooth]
[  +0.000413]  [<f94298bb>] l2cap_sock_teardown_cb+0x178/0x19e [bluetooth]
[  +0.000435]  [<f94298bb>] ? l2cap_sock_teardown_cb+0x178/0x19e [bluetooth]
[  +0.000482]  [<f94209ad>] l2cap_chan_del+0x5d/0x14d [bluetooth]
[  +0.000410]  [<f94209ad>] ? l2cap_chan_del+0x5d/0x14d [bluetooth]
[  +0.000531]  [<f9423976>] l2cap_conn_del+0x109/0x17b [bluetooth]
[  +0.000418]  [<f9423976>] ? l2cap_conn_del+0x109/0x17b [bluetooth]
[  +0.000422]  [<f940aa20>] ? hci_conn_hash_flush+0x62/0xba [bluetooth]
[  +0.000371]  [<f9423a31>] l2cap_disconn_cfm+0x49/0x50 [bluetooth]
[  +0.000265]  [<f9423a31>] ? l2cap_disconn_cfm+0x49/0x50 [bluetooth]
[  +0.000268]  [<f940aa3e>] hci_conn_hash_flush+0x80/0xba [bluetooth]
[  +0.000265]  [<f9405abe>] hci_dev_do_close+0x25f/0x3ac [bluetooth]
[  +0.000261]  [<f9405abe>] ? hci_dev_do_close+0x25f/0x3ac [bluetooth]
[  +0.000294]  [<f9408006>] hci_unregister_dev+0x6c/0x1d6 [bluetooth]
[  +0.000332]  [<f9408006>] ? hci_unregister_dev+0x6c/0x1d6 [bluetooth]
[  +0.000680]  [<f800e075>] vhci_release+0x28/0x47 [hci_vhci]
[  +0.000361]  [<f800e075>] ? vhci_release+0x28/0x47 [hci_vhci]
[  +0.000376]  [<c10eaae6>] __fput+0xd6/0x162
[  +0.000252]  [<c10eaba2>] ____fput+0xd/0xf
[  +0.000240]  [<c104b293>] task_work_run+0x69/0x8b
[  +0.000288]  [<c1001ef7>] do_notify_resume+0x3c/0x3f
[  +0.000314]  [<c13fd7f0>] work_notifysig+0x29/0x31
[  +0.000296] ---[ end trace 3124333c67133c65 ]---
[  +0.000283] BUG: unable to handle kernel paging request at 6b6b6b6b
[  +0.000442] IP: [<6b6b6b6b>] 0x6b6b6b6b
[  +0.000234] *pde = 00000000 
[  +0.000149] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC 
[  +0.000058] Modules linked in: btusb btintel btbcm btrtl hci_vhci rfcomm bluetooth_6lowpan bluetooth
[  +0.000000] CPU: 0 PID: 830 Comm: l2cap-tester Tainted: G        W       4.1.0+ #1359
[  +0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.1-20150318_183358- 04/01/2014
[  +0.001736] =============================================================================
[  +0.000002] BUG kmalloc-1024 (Tainted: G        W      ): Poison overwritten
[  +0.000000] -----------------------------------------------------------------------------

[  +0.000002] INFO: 0xf52d86d0-0xf52d86d0. First byte 0x6a instead of 0x6b
[  +0.000004] INFO: Allocated in sk_prot_alloc+0x7f/0xda age=11 cpu=0 pid=830
[  +0.000002] 	__slab_alloc.constprop.67+0x205/0x3aa
[  +0.000001] 	__kmalloc+0x9a/0x123
[  +0.000001] 	sk_prot_alloc+0x7f/0xda
[  +0.000001] 	sk_alloc+0x1e/0x5c
[  +0.000020] 	l2cap_sock_alloc.constprop.5+0x26/0x9c [bluetooth]
[  +0.000019] 	l2cap_sock_create+0x7a/0xc2 [bluetooth]
[  +0.000012] 	bt_sock_create+0x80/0xbb [bluetooth]
[  +0.000002] 	__sock_create+0x145/0x1c7
[  +0.000001] 	sock_create+0x29/0x2e
[  +0.000002] 	SYSC_socket+0x22/0x7d
[  +0.000001] 	SYSC_socketcall+0x78/0x383
[  +0.000002] 	SyS_socketcall+0x13/0x15
[  +0.000002] 	sysenter_after_call+0x0/0x24
[  +0.000002] INFO: Freed in sk_destruct+0x119/0x133 age=5 cpu=0 pid=830
[  +0.000001] 	__slab_free+0x41/0x26a
[  +0.000001] 	kfree+0x145/0x191
[  +0.000001] 	sk_destruct+0x119/0x133
[  +0.000002] 	__sk_free+0x63/0x7c
[  +0.000001] 	sk_free+0x18/0x1a
[  +0.000017] 	sock_put+0xf/0x11 [bluetooth]
[  +0.000017] 	l2cap_sock_kill+0x6c/0x71 [bluetooth]
[  +0.000017] 	l2cap_sock_release+0x97/0xa5 [bluetooth]
[  +0.000002] 	sock_release+0x19/0x6b
[  +0.000001] 	sock_close+0x10/0x14
[  +0.000002] 	__fput+0xd6/0x162
[  +0.000001] 	____fput+0xd/0xf
[  +0.000002] 	task_work_run+0x69/0x8b
[  +0.000002] 	do_notify_resume+0x3c/0x3f
[  +0.000001] 	work_notifysig+0x29/0x31
[  +0.000001] INFO: Slab 0xf6fd2b00 objects=13 used=13 fp=0x  (null) flags=0x35004080
[  +0.000001] INFO: Object 0xf52d84b0 @offset=1200 fp=0xf52daee0
[  +0.000002] Bytes b4 f52d84a0: 00 00 00 00 55 00 ff ff 5a 5a 5a 5a 5a 5a 5a 5a  ....U...ZZZZZZZZ
[  +0.000002] Object f52d84b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d84c0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d84d0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d84e0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d84f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8500: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8510: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8520: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8530: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8540: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8550: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8560: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8570: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8580: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000000] Object f52d8590: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d85a0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000002] Object f52d85b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d85c0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000000] Object f52d85d0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000006] Object f52d85e0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d85f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8600: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8610: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8620: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8630: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8640: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8650: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8660: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8670: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8680: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8690: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d86a0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d86b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d86c0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d86d0: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  jkkkkkkkkkkkkkkk
[  +0.000001] Object f52d86e0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d86f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8700: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8710: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8720: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8730: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8740: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8750: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8760: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000000] Object f52d8770: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000002] Object f52d8780: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8790: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d87a0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d87b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d87c0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000000] Object f52d87d0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d87e0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d87f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8800: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8810: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8820: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8830: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8840: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8850: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8860: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000003] Object f52d8870: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8880: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d8890: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  +0.000001] Object f52d88a0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
[  +0.000001] Redzone f52d88b0: bb bb bb bb                                      ....
[  +0.000001] Padding f52d8958: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
[  +0.000002] CPU: 1 PID: 94 Comm: systemd-journal Tainted: G    B   W       4.1.0+ #1359
[  +0.000001] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.1-20150318_183358- 04/01/2014
[  +0.000004]  00000000 00000000 f4daf79c c13f89bb f6001780 f4daf7b4 c10e3d9c f52d8000
[  +0.000004]  0000006b f52d86d0 f52d86d1 f4daf7d8 c10e3e1c f52d84b0 f6fd2b00 f52d86d0
[  +0.000004]  f6001780 f6001780 f52d84b0 f52d88b0 f4daf804 c10e40e0 c15fe0cd f52d84b0
[  +0.000001] Call Trace:
[  +0.000002]  [<c13f89bb>] dump_stack+0x49/0x73
[  +0.000002]  [<c10e3d9c>] print_trailer+0xec/0xf4
[  +0.000002]  [<c10e3e1c>] check_bytes_and_report+0x78/0xae
[  +0.000001]  [<c10e40e0>] check_object+0xe9/0x172
[  +0.000002]  [<c10e47e6>] alloc_debug_processing+0x51/0xdd
[  +0.000002]  [<c10e4a77>] __slab_alloc.constprop.67+0x205/0x3aa
[  +0.000005]  [<c1241a22>] ? virtqueue_add+0x7a/0x29a
[  +0.000002]  [<c1241a22>] ? virtqueue_add+0x7a/0x29a
[  +0.000003]  [<c1065b77>] ? __lock_acquire+0x586/0xc02
[  +0.000002]  [<c1062f8a>] ? arch_local_irq_save+0x8/0xb
[  +0.000002]  [<c10e4cb6>] __kmalloc+0x9a/0x123
[  +0.000001]  [<c10e4cb6>] ? __kmalloc+0x9a/0x123
[  +0.000002]  [<c1241a22>] ? virtqueue_add+0x7a/0x29a
[  +0.000002]  [<c1241a22>] virtqueue_add+0x7a/0x29a
[  +0.000001]  [<c10e43b0>] ? deactivate_slab+0x116/0x1fa
[  +0.000002]  [<c1241c94>] virtqueue_add_sgs+0x52/0x5a
[  +0.000002]  [<c1241c94>] ? virtqueue_add_sgs+0x52/0x5a
[  +0.000002]  [<c12a4091>] __virtblk_add_req+0x12a/0x132
[  +0.000003]  [<c12a4216>] ? virtio_queue_rq+0x11d/0x1cd
[  +0.000003]  [<c13fcd0e>] ? _raw_spin_lock_irqsave+0x3e/0x47
[  +0.000001]  [<c12a423c>] virtio_queue_rq+0x143/0x1cd
[  +0.000004]  [<c11d16b3>] __blk_mq_run_hw_queue+0x178/0x25e
[  +0.000002]  [<c11d14c2>] blk_mq_run_hw_queue+0x53/0xcc
[  +0.000002]  [<c11d26d3>] blk_mq_insert_requests+0xfe/0x15e
[  +0.000003]  [<c11d2ccd>] blk_mq_flush_plug_list+0xb4/0xbe
[  +0.000003]  [<c11cb3da>] blk_flush_plug_list+0x79/0x17b
[  +0.000002]  [<c11c8777>] ? rcu_read_unlock+0x52/0x54
[  +0.000002]  [<c11caa8a>] ? blk_account_io_start+0x112/0x118
[  +0.000002]  [<c11d27f7>] blk_sq_make_request+0xc4/0x110
[  +0.000002]  [<c11c9c28>] generic_make_request+0x82/0xb5
[  +0.000002]  [<c11c9d1a>] submit_bio+0xbf/0xc7
[  +0.000003]  [<c11c3dc0>] ? bio_add_page+0x78/0x82
[  +0.000002]  [<c11cfdda>] blkdev_issue_zeroout+0x1d0/0x229
[  +0.000012]  [<c1156bab>] ext4_ext_zeroout.isra.32+0x6b/0x80
[  +0.000003]  [<c115ae85>] ext4_ext_handle_unwritten_extents+0x64f/0x99f
[  +0.000003]  [<c115b5bb>] ext4_ext_map_blocks+0x3bf/0xba2
[  +0.000003]  [<c113bd25>] ? ext4_map_blocks+0x214/0x37c
[  +0.000003]  [<c13fc082>] ? down_write+0x38/0x49
[  +0.000001]  [<c113bd45>] ext4_map_blocks+0x234/0x37c
[  +0.000002]  [<c113dec7>] mpage_map_and_submit_extent+0xfd/0x5aa
[  +0.000003]  [<c113aabf>] ? mpage_prepare_extent_to_map+0x1b4/0x1be
[  +0.000003]  [<c113e72c>] ext4_writepages+0x3b8/0x5eb
[  +0.000002]  [<c1062f8a>] ? arch_local_irq_save+0x8/0xb
[  +0.000006]  [<c10c156f>] do_writepages+0x1c/0x29
[  +0.000003]  [<c10b9d9c>] __filemap_fdatawrite_range+0x59/0x65
[  +0.000003]  [<c10b9e3c>] filemap_write_and_wait_range+0x28/0x5e
[  +0.000002]  [<c1137239>] ext4_sync_file+0x1c4/0x3ba
[  +0.000002]  [<c110c9c4>] vfs_fsync_range+0x74/0x86
[  +0.000002]  [<c110c9ef>] vfs_fsync+0x19/0x1b
[  +0.000002]  [<c110cb7a>] do_fsync+0x2c/0x42
[  +0.000003]  [<c110cd64>] SyS_fsync+0x12/0x14
[  +0.000002]  [<c13fd688>] sysenter_do_call+0x12/0x12
[  +0.000002] FIX kmalloc-1024: Restoring 0xf52d86d0-0xf52d86d0=0x6b
[  +0.000001] FIX kmalloc-1024: Marking all objects used
[  -0.002108] task: f2284100 ti: f52ee000 task.ti: f52ee000
[  +0.000000] EIP: 0060:[<6b6b6b6b>] EFLAGS: 00010202 CPU: 0
[  +0.000000] EIP is at 0x6b6b6b6b
[  +0.000000] EAX: f52d84b0 EBX: f22a5c20 ECX: f52efe00 EDX: f52d84b0
[  +0.000000] ESI: 00000067 EDI: f22a5770 EBP: f52efe68 ESP: f52efe4c
[  +0.000000]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  +0.000000] CR0: 8005003b CR2: 6b6b6b6b CR3: 322f3000 CR4: 00000690
[  +0.000000] Stack:
[  +0.000000]  f94298c6 00000286 f52d84b0 f52efe88 f22a5770 f4fef310 f52efe78 f52efe88
[  +0.000000]  f94209ad 00000067 f94209ad 00000000 f4fef310 f22a5770 f52efe98 f52efeb8
[  +0.000000]  f9423976 f22ece30 f9423976 f52d8e10 f4fef43c f4fef444 00000067 f940aa20
[  +0.000000] Call Trace:
[  +0.000000]  [<f94298c6>] ? l2cap_sock_teardown_cb+0x183/0x19e [bluetooth]
[  +0.000000]  [<f94209ad>] l2cap_chan_del+0x5d/0x14d [bluetooth]
[  +0.000000]  [<f94209ad>] ? l2cap_chan_del+0x5d/0x14d [bluetooth]
[  +0.000000]  [<f9423976>] l2cap_conn_del+0x109/0x17b [bluetooth]
[  +0.000000]  [<f9423976>] ? l2cap_conn_del+0x109/0x17b [bluetooth]
[  +0.000000]  [<f940aa20>] ? hci_conn_hash_flush+0x62/0xba [bluetooth]
[  +0.000000]  [<f9423a31>] l2cap_disconn_cfm+0x49/0x50 [bluetooth]
[  +0.000000]  [<f9423a31>] ? l2cap_disconn_cfm+0x49/0x50 [bluetooth]
[  +0.000000]  [<f940aa3e>] hci_conn_hash_flush+0x80/0xba [bluetooth]
[  +0.000000]  [<f9405abe>] hci_dev_do_close+0x25f/0x3ac [bluetooth]
[  +0.000000]  [<f9405abe>] ? hci_dev_do_close+0x25f/0x3ac [bluetooth]
[  +0.000000]  [<f9408006>] hci_unregister_dev+0x6c/0x1d6 [bluetooth]
[  +0.000000]  [<f9408006>] ? hci_unregister_dev+0x6c/0x1d6 [bluetooth]
[  +0.000000]  [<f800e075>] vhci_release+0x28/0x47 [hci_vhci]
[  +0.000000]  [<f800e075>] ? vhci_release+0x28/0x47 [hci_vhci]
[  +0.000000]  [<c10eaae6>] __fput+0xd6/0x162
[  +0.000000]  [<c10eaba2>] ____fput+0xd/0xf
[  +0.000000]  [<c104b293>] task_work_run+0x69/0x8b
[  +0.000000]  [<c1001ef7>] do_notify_resume+0x3c/0x3f
[  +0.000000]  [<c13fd7f0>] work_notifysig+0x29/0x31
[  +0.000000] Code:  Bad EIP value.
[  +0.000000] EIP: [<6b6b6b6b>] 0x6b6b6b6b SS:ESP 0068:f52efe4c
[  +0.000000] CR2: 000000006b6b6b6b

Johan
