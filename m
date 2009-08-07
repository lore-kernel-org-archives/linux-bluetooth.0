Return-Path: <cyrus@holtmann.org>
Subject: Re: sco connection issue for BlueZ 4.x on kernel 2.6.29
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <113d36d80908071126j521df37aked5fec76df09006c@mail.gmail.com>
References: <113d36d80908071126j521df37aked5fec76df09006c@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 07 Aug 2009 11:35:35 -0700
Message-Id: <1249670135.30166.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Can not accept incoming SCO connection. Kernel version 2.6.29. Kernel
> log is as below. Is this a kernel bug? Is there any fix already for
> this?
> 
> <6>[  158.339691] sco_connect_ind: hdev hci0, bdaddr CA:D3:10:55:0C:00
>     -------// receive incoming sco
> <6>[  158.518554] sco_connect_cfm: hcon cf18ee00 bdaddr CA:D3:10:55:0C:00 status
> <6>[  158.721160] sco_connect_cfm: hcon cf149c00 bdaddr CA:D3:10:55:0C:00 status
> <6>[  158.728851] sco_conn_add: hcon cf149c00 conn cc772640
> <6>[  158.734313] sco_conn_ready: conn cc772640
> -----------// handle sco connection complete
> <6>[  158.738800] sco_sock_init: sk cf18c400
> -----------// start handle sco socket
> <6>[  158.742858] __sco_chan_add: conn cc772640
> <6>[  159.693023] sco_sock_accept: sk ccfdf400 timeo 0
> <6>[  159.708038] sco_sock_accept: new socket cf18c400
> <6>[  159.713073] sco_sock_getsockopt: sk cf18c400
> <6>[  159.717834] sco_sock_getsockopt_old: sk cf18c400
> <6>[  159.722839] sco_sock_getsockopt_old: mtu 180
> <6>[  159.727661] sco_sock_getname: sock ce9d80a0, sk cf18c400
> <6>[  159.733398] sco_sock_getname: sock ce9d80a0, sk cf18c400
> <6>[  159.739166] sco_sock_release: sock ce9d80a0, sk cf18c400
> -----------// don't know why it call sco_sock_release
> <6>[  159.745025] sco_sock_clear_timer: sock cf18c400 state 1
> <6>[  159.750671] sco_sock_close: sk cf18c400 state 1 conn cc772640 socket ce9d8
> <6>[  159.758453] sco_chan_del: sk cf18c400, conn cc772640, err 104
> <6>[  159.764770] sco_sock_kill: sk cf18c400 state 9
> <6>[  159.769592] sco_sock_destruct: sk cf18c400
> ------------// destruct sco socket, and disconnect SCO connection
> <6>[  159.782745] l2cap_disconn_ind: hcon cf149c00
> <6>[  159.787384] hci_acl_disconn: cf149c00
> <6>[  159.950805] hci_disconn_complete_evt: hci0 status 0
> <6>[  159.956207] l2cap_disconn_cfm: hcon cf149c00 reason 22
> <6>[  159.961730] sco_disconn_cfm: hcon cf149c00 reason 22
> -------------// sco disconnected
> <6>[  159.967102] sco_conn_del: hcon cf149c00 conn cc772640, err 103
> <6>[  162.130523] hci_disconn_complete_evt: hci0 status 0
> <6>[  162.136291] l2cap_disconn_cfm: hcon cf18ee00 reason 19
> <6>[  162.149871] sco_disconn_cfm: hcon cf18ee00 reason 19
> <4>[  165.382141] done EDISCO CTRL ENABLE
> <7>[  165.386077] sholes-panel:  edisco_ctrl_enable_te

what kind of program are you using?

Regards

Marcel


