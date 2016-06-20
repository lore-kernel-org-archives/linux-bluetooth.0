Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 120691] New: UART HCI memory leak
Date: Mon, 20 Jun 2016 13:46:40 +0000
Message-ID: <bug-120691-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=120691

            Bug ID: 120691
           Summary: UART HCI memory leak
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.7-rc3
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: nico.edev@gmail.com
        Regression: No

Hello,

It looks like there is a memory leak on UART HCI driver. I am using kernel
4.7-rc3 and Bluez 5.40. I can reproduce the issue with kernel 4.2.
There is nothing special to do to encounter the problem; HCI traffic is enough.
I can speed up the occurrence of the issue when BT module is scanning because
it increases HCI traffic.
My BT module is dual mode but I can reproduce the issue when I force "brerd" or
"le" mode.
FYI, the leak is 1MByte/hour when BT scanning is on; which is a lot on embedded
systems.

Below is a piece of kmemleak dump:

unreferenced object 0xc6a59ac0 (size 2048):
  comm "kworker/u2:0", pid 6, jiffies 4294951225 (age 1195.920s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 0e 0e 01 04 10 00 01 01  kkkkkkkk........
    00 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
  backtrace:
    [<c03c93a0>] __alloc_skb+0x7c/0x164
    [<c03563ac>] ll_recv+0x1c8/0x41c
    [<c03554b4>] hci_uart_tty_receive+0x44/0x64
    [<c0255ec4>] tty_ldisc_receive_buf+0x50/0x58
    [<c0256338>] flush_to_ldisc+0xb8/0xd0
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc62f0020 (size 168):
  comm "kworker/u3:2", pid 439, jiffies 4294951225 (age 1195.920s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 54 a4 46 a9 95 53 54 14  ........T.F..ST.
    00 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00  ................
  backtrace:
    [<c0473bfc>] hci_event_packet+0x1d8/0x2ba0
    [<c04674c8>] hci_rx_work+0x170/0x248
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc6a5be40 (size 2048):
  comm "kworker/u2:0", pid 6, jiffies 4294951227 (age 1195.900s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 0e 04 01 10 20 00 6b 6b  kkkkkkkk.... .kk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<c03c93a0>] __alloc_skb+0x7c/0x164
    [<c03563ac>] ll_recv+0x1c8/0x41c
    [<c03554b4>] hci_uart_tty_receive+0x44/0x64
    [<c0255ec4>] tty_ldisc_receive_buf+0x50/0x58
    [<c0256338>] flush_to_ldisc+0xb8/0xd0
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc6315da0 (size 168):
  comm "kworker/u3:2", pid 439, jiffies 4294951227 (age 1195.900s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 5d c6 6d aa 95 53 54 14  ........].m..ST.
    00 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00  ................
  backtrace:
    [<c0473bfc>] hci_event_packet+0x1d8/0x2ba0
    [<c04674c8>] hci_rx_work+0x170/0x248
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc6a5a3a0 (size 2048):
  comm "kworker/u2:0", pid 6, jiffies 4294951228 (age 1195.890s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 0e 06 01 12 0c 00 00 00  kkkkkkkk........
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<c03c93a0>] __alloc_skb+0x7c/0x164
    [<c03563ac>] ll_recv+0x1c8/0x41c
    [<c03554b4>] hci_uart_tty_receive+0x44/0x64
    [<c0255ec4>] tty_ldisc_receive_buf+0x50/0x58
    [<c0256338>] flush_to_ldisc+0xb8/0xd0
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc6315620 (size 168):
  comm "kworker/u3:2", pid 439, jiffies 4294951228 (age 1195.890s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1a 97 8f aa 95 53 54 14  .............ST.
    00 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00  ................
  backtrace:
    [<c0473bfc>] hci_event_packet+0x1d8/0x2ba0
    [<c04674c8>] hci_rx_work+0x170/0x248
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc63151a0 (size 168):
  comm "kworker/u3:0", pid 435, jiffies 4294953313 (age 1175.050s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 86 3f ce 85 9a 53 54 14  .........?...ST.
    00 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00  ................
  backtrace:
    [<c0473bfc>] hci_event_packet+0x1d8/0x2ba0
    [<c04674c8>] hci_rx_work+0x170/0x248
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc6a5ac80 (size 2048):
  comm "kworker/u2:0", pid 6, jiffies 4294958830 (age 1119.880s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 0e 0a 01 09 10 00 f8 a7  kkkkkkkk........
    d7 e9 17 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  ....kkkkkkkkkkkk
  backtrace:
    [<c03c93a0>] __alloc_skb+0x7c/0x164
    [<c03563ac>] ll_recv+0x1c8/0x41c
    [<c03554b4>] hci_uart_tty_receive+0x44/0x64
    [<c0255ec4>] tty_ldisc_receive_buf+0x50/0x58
    [<c0256338>] flush_to_ldisc+0xb8/0xd0
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc6315aa0 (size 168):
  comm "kworker/u3:2", pid 439, jiffies 4294958830 (age 1119.890s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 c0 e0 d1 5d a7 53 54 14  ...........].ST.
    00 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00  ................
  backtrace:
    [<c0473bfc>] hci_event_packet+0x1d8/0x2ba0
    [<c04674c8>] hci_rx_work+0x170/0x248
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
unreferenced object 0xc6600020 (size 2048):
  comm "kworker/u2:0", pid 6, jiffies 4294958833 (age 1119.860s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 0e 0e 01 04 10 00 01 01  kkkkkkkk........
    01 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
  backtrace:
    [<c03c93a0>] __alloc_skb+0x7c/0x164
    [<c03563ac>] ll_recv+0x1c8/0x41c
    [<c03554b4>] hci_uart_tty_receive+0x44/0x64
    [<c0255ec4>] tty_ldisc_receive_buf+0x50/0x58
    [<c0256338>] flush_to_ldisc+0xb8/0xd0
    [<c00318c0>] process_one_work+0x128/0x478
    [<c0031c64>] worker_thread+0x54/0x574
    [<c00368f4>] kthread+0xc0/0xdc
    [<c000a2d0>] ret_from_fork+0x14/0x24
    [<ffffffff>] 0xffffffff
...

I had a look to kernel source code but did not find anything obvious.

Thanks!

-- 
You are receiving this mail because:
You are the assignee for the bug.
