Return-Path: <cyrus@holtmann.org>
Subject: Memory leak on failed connection attempt
From: Tomas Targownik <ttargownik@geicp.com>
Reply-To: ttargownik@geicp.com
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Jun 2011 16:48:13 +1000
Message-ID: <1306997293.1926.83.camel@rnd3>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to track down a memory leak that is occurring in bluez4
v4.87 running on Linux 2.6.32.21, on an ARMv5 device. Unfortunately with
my somewhat limited bluetooth stack expertise, there is only so much I
can understand in the debugging process, so I do hope that someone can
offer their advice on this issue, or even just point me in the right
direction. 

I have an ARMv5 based device (pxa270) with an infineon PBA31308
bluetooth module, configured to create a PAN connection with a remote
device.
The PAND command line arguments being used are the following-
PAND_OPTIONS="--role GN --service PANU --connect 00:0A:94:02:A5:7A
--persist"

I have found that if the ARM device cannot connect to the remote device
(i.e. The remote bluetooth device is not present), then I am seeing a
512 byte leak on every subsequent connection attempt (roughly every 10
seconds). This leak only occurs once if I remove the '--persist' option
to PAND, however this is not a viable solution as I do require the
'persist' option for my application. Again, this leak only occurs if the
connection attempt fails. When a connection is established and being
utilised, there is no leak.

I am detecting the leak using kmemleak, and the leak in question gives
the following output (cat /sys/kernel/debug/kmemleak)-
-----------------------------------------------------------------------------------------------------------
unreferenced object 0xc2cfb600 (size 512):
  comm "softirq", pid 0, jiffies 159696
  hex dump (first 32 bytes):
    00 01 10 00 00 02 20 00 00 00 00 00 17 49 0f dc  ...... ......I..
    1b 00 00 00 09 00 00 01 01 01 00 00 00 00 00 00  ................
  backtrace:
    [<c0086d84>] create_object+0x120/0x210
    [<c01ad9e8>] kmemleak_alloc+0x40/0x84
    [<c0084700>] kmem_cache_alloc+0x98/0xcc
    [<bf124e78>] hci_conn_add+0x28/0x238 [bluetooth]
    [<bf1252b8>] hci_connect+0x8c/0x270 [bluetooth]
    [<bf148c7c>] l2cap_sock_connect+0x1bc/0x37c [l2cap]
    [<c0145678>] sys_connect+0x74/0x98
    [<c0025f20>] ret_fast_syscall+0x0/0x28
    [<ffffffff>] 0xffffffff
unreferenced object 0xc2cfbc00 (size 512):
  comm "softirq", pid 0, jiffies 161221
  hex dump (first 32 bytes):
    00 01 10 00 00 02 20 00 00 00 00 00 17 49 0f dc  ...... ......I..
    1b 00 00 00 09 00 00 01 01 01 00 00 00 00 00 00  ................
  backtrace:
    [<c0086d84>] create_object+0x120/0x210
    [<c01ad9e8>] kmemleak_alloc+0x40/0x84
    [<c0084700>] kmem_cache_alloc+0x98/0xcc
    [<bf124e78>] hci_conn_add+0x28/0x238 [bluetooth]
    [<bf1252b8>] hci_connect+0x8c/0x270 [bluetooth]
    [<bf148c7c>] l2cap_sock_connect+0x1bc/0x37c [l2cap]
    [<c0145678>] sys_connect+0x74/0x98
    [<c0025f20>] ret_fast_syscall+0x0/0x28
    [<ffffffff>] 0xffffffff
-----------------------------------------------------------------------------------------------------------

The leak shown above continues to be generated about once every 10
seconds if the "persist" option is enabled and the connection attempt
fails, and after a month of continuous running my poor ARM device is
exhausted of memory, and 'cat /proc/meminfo' shows the 'SUnreclaim'
value has grown quite large. The 'free' command quite clearly shows me
that there is no memory left on the device, as well.

If it is any help, the debug line from within
hci_core.c-->hci_send_cmd() 
    -->BT_DBG("%s opcode 0x%x plen %d", hdev->name, opcode, plen);

shows the following output every time there is a new leak:
    -->hci0 opcode 0x405 plen 13

Every time the above command is sent (once every 10 seconds) I am seeing
a new 512b memory leak.

I have had a look through the list to see if this issue has been patched
or mentioned, and the closest bug I could find that vaguely resembled my
problem is here-
http://marc.info/?l=linux-bluetooth&m=125890998917495&w=2

I have tried applying the changes in the patch provided but the memory
leak is still present, so I assume this patch was for a different
problem.

If anybody knows what could be happening here, or has any advice to
offer at all regarding this issue, it would be more than appreciated. 
Please let me know if more debugging information is required.

Thank you, 
Tomas Targownik







