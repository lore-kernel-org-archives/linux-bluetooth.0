Return-Path: <cyrus@holtmann.org>
Subject: Re: Memory leak on failed connection attempt
From: Tomas Targownik <ttargownik@geicp.com>
Reply-To: ttargownik@geicp.com
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20110602135720.GB2790@joana>
References: <1306997293.1926.83.camel@rnd3>  <20110602135720.GB2790@joana>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Jun 2011 17:03:24 +1000
Message-ID: <1308035004.1926.611.camel@rnd3>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-06-02 at 10:57 -0300, Gustavo F. Padovan wrote:
> Hi Tomas,
> ...
> Can you try an upstream kernel and check if this still happens? 2.6.32 is
> quite old.

Hi Gustavo, and thank you for the advice. I've managed to port my device
to linux-2.6.39.1, and have also upgraded to the latest Bluez4 v4.94,
and I am still seeing the leak on failed connection attempts. The output
shown by 'cat /sys/kernel/debug/kmemleak' has changed slightly, however-

unreferenced object 0xc2ce0600 (size 512):
  comm "softirq", pid 0, jiffies 4294956138 (age 56.420s)
  hex dump (first 32 bytes):
    00 01 10 00 00 02 20 00 00 00 00 00 7a a5 02 94  ...... .....z...
    0a 00 00 00 09 00 00 01 01 01 00 00 00 00 00 00  ................
  backtrace:
    [<c00da3ac>] create_object+0x120/0x210
    [<c021d058>] kmemleak_alloc+0x40/0x74
    [<c00d7cd4>] kmem_cache_alloc+0x9c/0xd0
    [<bf055f54>] hci_conn_add+0x30/0x268 [bluetooth]
    [<bf056504>] hci_connect+0x1d4/0x3e8 [bluetooth]
    [<bf0637f8>] l2cap_do_connect+0xfc/0x304 [bluetooth]
    [<bf066c84>] l2cap_sock_connect+0x180/0x1dc [bluetooth]
    [<c01a9458>] sys_connect+0x74/0x98
    [<c0070fc0>] ret_fast_syscall+0x0/0x2c
    [<ffffffff>] 0xffffffff
unreferenced object 0xc2c4ee00 (size 512):
  comm "softirq", pid 0, jiffies 4294957663 (age 41.170s)
  hex dump (first 32 bytes):
    00 01 10 00 00 02 20 00 00 00 00 00 7a a5 02 94  ...... .....z...
    0a 00 00 00 09 00 00 01 01 01 00 00 00 00 00 00  ................
  backtrace:
    [<c00da3ac>] create_object+0x120/0x210
    [<c021d058>] kmemleak_alloc+0x40/0x74
    [<c00d7cd4>] kmem_cache_alloc+0x9c/0xd0
    [<bf055f54>] hci_conn_add+0x30/0x268 [bluetooth]
    [<bf056504>] hci_connect+0x1d4/0x3e8 [bluetooth]
    [<bf0637f8>] l2cap_do_connect+0xfc/0x304 [bluetooth]
    [<bf066c84>] l2cap_sock_connect+0x180/0x1dc [bluetooth]
    [<c01a9458>] sys_connect+0x74/0x98
    [<c0070fc0>] ret_fast_syscall+0x0/0x2c
    [<ffffffff>] 0xffffffff

Can anybody else confirm this?

Thank you, 
Tomas Targownik



