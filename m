Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Jun 2010 18:52:04 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Nathan Holstein <ngh@isomerica.net>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: panic after shutting down an ERTM socket
Message-ID: <20100622215204.GB11241@vigoh>
References: <1277236515.14834.477.camel@strawberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277236515.14834.477.camel@strawberry>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

* Nathan Holstein <ngh@isomerica.net> [2010-06-22 15:55:15 -0400]:

> I'm seeing a crash from an ERTM socket after it's been shutdown.  I'm
> running a back-ported series of patches from 6 weeks ago (commit
> dfc909b) on a 2.6.32 kernel.
> 
> The crash I'm seeing seems to be due to a monitor timeout firing after
> the parent l2cap_conn has been deleted.  Here's the relevant bits from
> the crash dump:
>         [ 2825.234283] l2cap_disconn_cfm (4390): hcon c6895600 reason 8
>         [ 2825.234771] l2cap_conn_del (612): hcon c6895600 conn c681f540, err 110
>         [ 2825.235229] l2cap_sock_clear_timer (121): sock c688f800 state 5
>         [ 2825.235443] l2cap_chan_del (262): sk c688f800, conn c681f540, err 110
>         [ 2825.235931] l2cap_sock_clear_timer (121): sock c6f7b800 state 1
>         [ 2825.236175] l2cap_chan_del (262): sk c6f7b800, conn c681f540, err 110
>         [ 2825.237243] l2cap_sock_release (2189): sock c759a560, sk c688f800
>         [ 2825.237487] l2cap_sock_shutdown (2162): sock c759a560, sk c688f800
>         [ 2825.238433] l2cap_sock_release (2189): sock c75a0b60, sk c6f7b800
>         [ 2825.238677] l2cap_sock_shutdown (2162): sock c75a0b60, sk c6f7b800
>         [ 2825.239105] l2cap_sock_clear_timer (121): sock c6f7b800 state 9
>         [ 2825.239349] __l2cap_sock_close (730): sk c6f7b800 state 9 socket c75a0b60
>         [ 2825.239776] l2cap_sock_kill (720): sk c6f7b800 state 9
>         [ 2825.243804] l2cap_sock_clear_timer (121): sock c688f800 state 9
>         [ 2825.244232] __l2cap_sock_close (730): sk c688f800 state 9 socket c759a560
>         [ 2825.244659] l2cap_sock_kill (720): sk c688f800 state 9
>         [ 2825.244903] l2cap_sock_destruct (692): sk c688f800
>         [ 2829.417694] l2cap_send_sframe (366): pi c6f7b800, control 0x10
>         [ 2829.418365] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> 
>         [ 2829.627502] [<bf002e50>] (l2cap_monitor_timeout+0xc8/0x21c [l2cap]) from [<c005f918>] (run_timer_softirq+0x1a4/0x258)
>         [ 2829.628143] [<c005f918>] (run_timer_softirq+0x1a4/0x258) from [<c005b380>] (__do_softirq+0x70/0xf8)
>         [ 2829.628814] [<c005b380>] (__do_softirq+0x70/0xf8) from [<c005b44c>] (irq_exit+0x44/0xa8)
>         [ 2829.629180] [<c005b44c>] (irq_exit+0x44/0xa8) from [<c002606c>] (asm_do_IRQ+0x6c/0x84)
>         [ 2829.629821] [<c002606c>] (asm_do_IRQ+0x6c/0x84) from [<c0026a8c>] (__irq_svc+0x4c/0x8c)
> 
> The crash occurs when accessing conn->mtu within l2cap_send_sframe.
> 
> Looking through the logs, it appears that commit fd24051 might fix this
> issue.  If not, I'll look into this further.

Yes, it is already fixed.

-- 
Gustavo F. Padovan
http://padovan.org
