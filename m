Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jun 2011 18:26:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Tomas Targownik <ttargownik@geicp.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Memory leak on failed connection attempt
Message-ID: <20110616212645.GF2594@joana>
References: <1306997293.1926.83.camel@rnd3>
 <20110602135720.GB2790@joana>
 <1308035004.1926.611.camel@rnd3>
 <1308180155.1926.640.camel@rnd3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308180155.1926.640.camel@rnd3>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

* Tomas Targownik <ttargownik@geicp.com> [2011-06-16 09:22:35 +1000]:

> To clarify this problem, I am observing the memory leak when I issue the
> command shown below. The debug function sequence is also listed. The
> remote bluetooth dongle must be physically unplugged to reproduce this
> leak. If the remote dongle is plugged in, regardless of whether pairing
> succeeds/fails, no leak occurs. Furthermore, this leak will continually
> repeat itself if the '--persist' option is passed to pand, and the
> remote bluetooth dongle is physically unplugged.
> 
> root@mydevice:~# pand --role GN --service PANU --connect
> 00:0A:94:02:A5:7A
> 
> [  341.880327] bnep_sock_create: sock c3478cf8
> [  341.892856] bnep_sock_ioctl: cmd 800442d2 arg be9dcae0
> [  341.959624] l2cap_sock_create: sock c3478e60
> [  341.964300] l2cap_sock_init: sk c3115400
> [  341.976147] l2cap_sock_getsockopt: sk c3115400
> [  341.980617] l2cap_sock_getsockopt_old: sk c3115400
> [  341.993539] l2cap_sock_setsockopt: sk c3115400
> [  341.998011] l2cap_sock_setsockopt_old: sk c3115400
> [  342.012246] l2cap_sock_bind: sk c3115400
> [  342.016357] l2cap_sock_connect: sk c3115400
> [  342.020572] l2cap_do_connect: 00:00:00:00:00:00 -> 00:0A:94:02:A5:7A
> psm 0x0f
> [  342.027973] hci_get_route: 00:00:00:00:00:00 -> 00:0A:94:02:A5:7A
> [  342.034095] hci_connect: hci0 dst 00:0A:94:02:A5:7A
> [  342.038972] hci_conn_add: hci0 dst 00:0A:94:02:A5:7A
> [  342.044084] hci_conn_init_sysfs: conn c3b92a00
> [  342.048540] hci_acl_connect: c3b92a00
> [  342.052252] hci_inquiry_cache_lookup: cache c30bb2b0,
> 00:0A:94:02:A5:7A
> [  342.058854] hci_send_cmd: hci0 opcode 0x405 plen 13
> [  342.063830] hci_send_cmd: skb len 16
> [  342.067440] l2cap_conn_add: hcon c3b92a00 conn c31616c0
> [  342.072699] __l2cap_chan_add: conn c31616c0, psm 0x0f, dcid 0x0000
> [  342.078869] l2cap_sock_set_timer: sk c3115400 state 5 timeout 4000
> [  342.085083] hci_cmd_task: hci0 cmd 1
> [  342.088787] hci_send_frame: hci0 type 1 len 16
> [  342.093355] hci_send_to_sock: hdev c30bb000 len 16
> [  342.098147] hci_uart_send_frame: hci0: type 1 len 16
> [  342.103133] h4_enqueue: hu c39eda20 skb c38ac2b8
> [  342.107739] hci_uart_tx_wakeup: 
> [  342.111041] hci_uart_tty_wakeup: 
> [  342.114474] hci_uart_tx_wakeup: 
> [  342.117743] bt_sock_wait_state: sk c3115400
> [  342.124366] hci_rx_task: hci0
> [  342.127397] hci_send_to_sock: hdev c30bb000 len 6
> [  342.132373] hci_cs_create_conn: hci0 status 0x0
> [  342.136895] hci_sent_cmd_data: hci0 opcode 0x405
> [  342.141559] hci_cs_create_conn: hci0 bdaddr 00:0A:94:02:A5:7A conn
> c3b92a00
> [  342.148881] bt_sock_poll: sock c346c1d8, sk c3167000
> [  342.154111] bt_sock_poll: sock c346c8e0, sk c3115c00
> [  342.177492] hci_sock_recvmsg: sock c346c778, sk c304b000
> [  342.196513] hci_sock_create: sock c3478a28
> [  342.200848] hci_sock_ioctl: cmd 800448d3 arg be9f8a8c
> [  342.206119] hci_dev_get: 0
> [  342.208825] hci_del_off_timer: hci0
> [  342.228800] hci_sock_release: sock c3478a28 sk c3b71a00
> [  342.244488] bt_sock_poll: sock c346c1d8, sk c3167000
> [  342.249500] bt_sock_poll: sock c346c8e0, sk c3115c00
> [  352.353690] hci_rx_task: hci0
> [  352.356725] hci_send_to_sock: hdev c30bb000 len 13
> [  352.361773] hci_conn_complete_evt: hci0
> [  352.365697] hci_send_to_sock: hdev   (null) len 13
> [  352.370553] hci_sco_setup: c3b92a00
> [  352.374152] l2cap_connect_cfm: hcon c3b92a00 bdaddr 00:0A:94:02:A5:7A
> status 4
> [  352.381389] l2cap_conn_del: hcon c3b92a00 conn c31616c0, err 112
> [  352.387378] l2cap_sock_clear_timer: sock c3115400 state 5
> [  352.392794] l2cap_chan_del: sk c3115400, conn c31616c0, err 112
> [  352.398771] hci_conn_del: hci0 conn c3b92a00 handle 0
> [  352.403860] hci_conn_check_pending: hdev hci0
> [  352.411925] bt_sock_poll: sock c346c1d8, sk c3167000
> [  352.416931] bt_sock_poll: sock c346c8e0, sk c3115c00
> [  352.423535] l2cap_sock_release: sock c3478e60, sk c3115400
> [  352.429161] l2cap_sock_shutdown: sock c3478e60, sk c3115400
> [  352.434837] l2cap_sock_clear_timer: sock c3115400 state 9
> [  352.440223] __l2cap_sock_close: sk c3115400 state 9 socket c3478e60
> [  352.446498] l2cap_sock_kill: sk c3115400 state 9
> [  352.451103] l2cap_sock_destruct: sk c3115400
> [  352.482403] hci_sock_recvmsg: sock c346c778, sk c304b000
> [  352.488056] hci_sock_create: sock c3478e60
> [  352.495035] bnep_sock_release: sock c3478cf8 sk c3b92400
> [  352.516755] hci_sock_ioctl: cmd 800448d3 arg be9f8a8c
> [  352.522076] hci_dev_get: 0
> [  352.524782] hci_del_off_timer: hci0
> [  352.537497] hci_sock_release: sock c3478e60 sk c3b92200
> [  352.547924] bt_sock_poll: sock c346c1d8, sk c3167000
> [  352.553185] bt_sock_poll: sock c346c8e0, sk c3115c00
> 
> root@mydevice:~# echo scan > /sys/kernel/debug/kmemleak
> [  377.130389] kmemleak: 1 new suspected memory leaks
> (see /sys/kernel/debug/kmemleak)
> 
> root@mydevice:~# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xc3b92a00 (size 512):
>   comm "softirq", pid 0, jiffies 4203 (age 932.360s)
>   hex dump (first 32 bytes):
>     00 01 10 00 00 02 20 00 00 00 00 00 7a a5 02 94  ...... .....z...
>     0a 00 00 00 09 00 00 01 01 01 00 00 00 00 00 00  ................
>   backtrace:
>     [<c00dee34>] create_object+0x120/0x210
>     [<c0224d98>] kmemleak_alloc+0x7c/0xc0
>     [<c00dc024>] kmem_cache_alloc+0x104/0x138
>     [<bf05f250>] hci_conn_add+0x5c/0x2a4 [bluetooth]
>     [<bf05f89c>] hci_connect+0x1f8/0x418 [bluetooth]
>     [<bf06f1d0>] l2cap_do_connect+0x134/0x344 [bluetooth]
>     [<bf072fd4>] l2cap_sock_connect+0x1a4/0x20c [bluetooth]
>     [<c01b0cdc>] sys_connect+0x74/0x98
>     [<c0071fc0>] ret_fast_syscall+0x0/0x2c
>     [<ffffffff>] 0xffffffff


I also need the hcidump output of this.

	Gustavo
