Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OC4dcjY-yY4=LsNebeuAFnst4QxCO6oLCLATm9zTHVLA@mail.gmail.com>
References: <CACUGKYPK6qhJNdpk6-bXaxj2DsUvkvquXQzLZTNDOBmrx3+r7Q@mail.gmail.com>
	<CAJdJm_OC4dcjY-yY4=LsNebeuAFnst4QxCO6oLCLATm9zTHVLA@mail.gmail.com>
Date: Thu, 23 Aug 2012 14:04:41 -0700
Message-ID: <CACUGKYM7L2GZHiqvtNQw5OXUEWJjChD168Ggc6CmM2c7tDCguA@mail.gmail.com>
Subject: Re: gatt-example plugin
From: John Tobias <john.tobias.ph@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

Thanks for the info. I got it working.. :)
I have a follow question, I've tried different Linux kernel release
for Pandaboard ES and I'm getting same kernel error( please see
below). I am just wondering if (you) or someone have a patch to fix
it?.

[  265.400543]
[  265.402130] =============================================
[  265.407836] [ INFO: possible recursive locking detected ]
[  265.413543] 3.6.0-rc3 #2 Not tainted
[  265.417297] ---------------------------------------------
[  265.422973] kworker/u:0H/7 is trying to acquire lock:
[  265.428283]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at:
[<bf3bc350>] l2cap_sock_ready_cb+0x14/0x50 [bluetooth]
[  265.439575]
[  265.439575] but task is already holding lock:
[  265.445709]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at:
[<bf3bb8fc>] l2cap_connect_cfm+0x1a4/0x2f4 [bluetooth]
[  265.456939]
[  265.456939] other info that might help us debug this:
[  265.463775]  Possible unsafe locking scenario:
[  265.463775]
[  265.470001]        CPU0
[  265.472564]        ----
[  265.475128]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[  265.480651]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[  265.486145]
[  265.486145]  *** DEADLOCK ***
[  265.486145]
[  265.492340]  May be due to missing lock nesting notation
[  265.492340]
[  265.499481] 4 locks held by kworker/u:0H/7:
[  265.503875]  #0:  (hdev->name){.+.+.+}, at: [<c005c56c>]
process_one_work+0x138/0x584
[  265.512176]  #1:  ((&hdev->rx_work)){+.+.+.}, at: [<c005c56c>]
process_one_work+0x138/0x584
[  265.520996]  #2:  (&hdev->lock){+.+.+.}, at: [<bf3a8074>]
hci_le_meta_evt+0x58/0x6fc [bluetooth]
[  265.530303]  #3:  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at:
[<bf3bb8fc>] l2cap_connect_cfm+0x1a4/0x2f4 [bluetooth]
[  265.542022]
[  265.542022] stack backtrace:
[  265.546630] [<c001b784>] (unwind_backtrace+0x0/0xf0) from
[<c0093024>] (__lock_acquire+0x1d00/0x1e24)
[  265.556335] [<c0093024>] (__lock_acquire+0x1d00/0x1e24) from
[<c0093790>] (lock_acquire+0x98/0x100)
[  265.565826] [<c0093790>] (lock_acquire+0x98/0x100) from
[<c0433f70>] (lock_sock_nested+0x6c/0x78)
[  265.575225] [<c0433f70>] (lock_sock_nested+0x6c/0x78) from
[<bf3bc350>] (l2cap_sock_ready_cb+0x14/0x50 [bluetooth])
[  265.586303] [<bf3bc350>] (l2cap_sock_ready_cb+0x14/0x50
[bluetooth]) from [<bf3b4950>] (l2cap_chan_ready+0x38/0x80
[bluetooth])
[  265.598480] [<bf3b4950>] (l2cap_chan_ready+0x38/0x80 [bluetooth])
from [<bf3bb9ac>] (l2cap_connect_cfm+0x254/0x2f4 [bluetooth])
[  265.610656] [<bf3bb9ac>] (l2cap_connect_cfm+0x254/0x2f4
[bluetooth]) from [<bf3a8604>] (hci_le_meta_evt+0x5e8/0x6fc
[bluetooth])
[  265.622894] [<bf3a8604>] (hci_le_meta_evt+0x5e8/0x6fc [bluetooth])
from [<bf3a8cb0>] (hci_event_packet+0x598/0x27c4 [bluetooth])
[  265.635101] [<bf3a8cb0>] (hci_event_packet+0x598/0x27c4
[bluetooth]) from [<bf39ec54>] (hci_rx_work+0x1c0/0x358 [bluetooth])
[  265.646942] [<bf39ec54>] (hci_rx_work+0x1c0/0x358 [bluetooth]) from
[<c005c5ec>] (process_one_work+0x1b8/0x584)
[  265.657562] [<c005c5ec>] (process_one_work+0x1b8/0x584) from
[<c005f2a8>] (worker_thread+0x170/0x4a4)
[  265.667266] [<c005f2a8>] (worker_thread+0x170/0x4a4) from
[<c0064250>] (kthread+0x90/0x9c)
[  265.675964] [<c0064250>] (kthread+0x90/0x9c) from [<c0014e94>]
(kernel_thread_exit+0x0/0x8)


Regards,

John


On Tue, Aug 21, 2012 at 3:41 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi John,
>
> On Mon, Aug 20, 2012 at 9:19 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Hello Guys,
>>
>> I was playing with bluez-4.99 for LE. After setting the "EnableGatt to
>> true" and re-start the bluetoothd, I was able to connect to the
>> advertised services of the bluez. But, I could not figured out how to
>> access/load the gatt_example plugin and access the services. Any
>> information how to do it?
>
> First, make sure that gatt_example plugin was compiled into
> bluetoothd. You can check this by looking at the first lines of the
> debug log for this string:
>
> src/plugin.c:add_plugin() Loading gatt_example plugin
>
> As long as you don't pass any "-P" option to bluetoothd, all compiled
> plugins will load by default.
>
> Next, you can test GATT operations from a remote device, e.g. some
> GATT client you already have or the "gatttool" in BlueZ (running on
> another adapter).
>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
