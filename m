Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM service level security testing
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099499933.3261.75.camel@baroque.rococosoft.com>
References: <1099151759.16247.18.camel@pegasus>
	 <1099433039.7125.13.camel@pegasus>
	 <1099495689.3265.44.camel@baroque.rococosoft.com>
	 <1099496238.6330.2.camel@notepaq>
	 <1099497364.3261.64.camel@baroque.rococosoft.com>
	 <1099498137.6330.29.camel@notepaq>
	 <1099499933.3261.75.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1099657717.6919.8.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 05 Nov 2004 13:28:37 +0100

Hi Steve,

> > does anyone tested this on a SMP system, a 64 bit box or big endian
> > machine?
> 
> I have an old dual-celeron at home. I'll try and make some time to
> re-run the Java tests on it over the next few days. It will probably be
> the weekend though.

the current version is not SMP safe. When using a SMP preempt kernel on
an UP machine with debugging I get this log:

Debug: sleeping function called from invalid context at net/core/sock.c:1207
in_atomic():1, irqs_disabled():0
 [<c0116a68>] __might_sleep+0xb2/0xd3
 [<c0241cca>] lock_sock+0x21/0x55
 [<e1421dc3>] l2cap_sock_sendmsg+0x5e/0x3bb [l2cap]
 [<c0113359>] try_to_wake_up+0x1e1/0x26f
 [<c023e1c2>] sock_sendmsg+0x11a/0x11c
 [<c0113405>] wake_up_process+0x1e/0x22
 [<e1422f93>] l2cap_recv_frame+0xc2/0xd10 [l2cap]
 [<c012d1d6>] autoremove_wake_function+0x0/0x57
 [<c020e872>] dma_pool_alloc+0x11f/0x16a
 [<c023e20a>] kernel_sendmsg+0x46/0x55
 [<e1434b36>] rfcomm_send_frame+0x55/0x65 [rfcomm]
 [<e1434c1e>] rfcomm_send_ua+0x6b/0x73 [rfcomm]
 [<e1435647>] rfcomm_dlc_accept+0x25/0x77 [rfcomm]
 [<e1436875>] rfcomm_auth_cfm+0x7a/0x91 [rfcomm]
 [<e0a8ab40>] hci_event_packet+0xa9e/0x1003 [bluetooth]
 [<c0114cf8>] __wake_up_common+0x3f/0x5e
 [<c0114d57>] __wake_up+0x40/0x56
 [<c024197f>] sock_def_readable+0x88/0x8a
 [<c0243be5>] skb_queue_tail+0x20/0x4b
 [<e0a8b38f>] hci_send_to_sock+0x16b/0x29a [bluetooth]
 [<e0a8897f>] hci_rx_task+0x1a1/0x293 [bluetooth]
 [<c011e1f4>] tasklet_action+0x65/0xae
 [<c011df43>] __do_softirq+0xb7/0xc6
 [<c011df7f>] do_softirq+0x2d/0x2f
 [<c0134b31>] irq_exit+0x3a/0x3c
 [<c010652e>] do_IRQ+0x1e/0x24
 [<c0104a9a>] common_interrupt+0x1a/0x20
 [<c010203e>] default_idle+0x0/0x2c
 [<c0102067>] default_idle+0x29/0x2c
 [<c01020dc>] cpu_idle+0x3f/0x58
 [<c031c89d>] start_kernel+0x151/0x16a
 [<c031c336>] unknown_bootoption+0x0/0x1ab

And this means that I have to queue the UA or DM response and I can't
switch into BT_CONNECTED state at that point.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
