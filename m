Return-Path: <john.stultz@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20171116214504.GB17506@wunner.de>
References: <CALAqxLVTff-XX7bbQ8a1Pihqe=QW1HDMKST3F3okCV8jY+wGqw@mail.gmail.com>
 <CALAqxLW9gzcBrwy3TWB5x_OpKtcLTe7P8PX4KeUgvibbAaMX_A@mail.gmail.com>
 <20171116213045.GA17506@wunner.de> <20171116214504.GB17506@wunner.de>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 16 Nov 2017 14:29:51 -0800
Message-ID: <CALAqxLX-qp=rc8P7ynGrUwWHgP2EBAwoEES-aOOuehtnJSDR+A@mail.gmail.com>
Subject: Re: Boot crash @hci_uart_tx_wakeup+0x38/0x148 w/ Linus' HEAD?
To: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>,
	Rob Herring <rob.herring@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 16, 2017 at 1:45 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Nov 16, 2017 at 10:30:45PM +0100, Lukas Wunner wrote:
>> On Thu, Nov 16, 2017 at 12:58:27PM -0800, John Stultz wrote:
>> > On Wed, Nov 15, 2017 at 6:00 PM, John Stultz <john.stultz@linaro.org> wrote:
>> > >    After updating to Linus' HEAD today, I'm seeing the following odd
>> > > boot time crash with the HiKey board (which uses the serdev driver).
>> > >
>> > > [    1.963009] Unable to handle kernel read from unreadable memory at
>> > > virtual address 406f127000
>> > > [    1.963012] Mem abort info:
>> > > [    1.963015]   ESR = 0x96000005
>> > > [    1.963018]   Exception class = DABT (current EL), IL = 32 bits
>> > > [    1.963021]   SET = 0, FnV = 0
>> > > [    1.963023]   EA = 0, S1PTW = 0
>> > > [    1.963025] Data abort info:
>> > > [    1.963027]   ISV = 0, ISS = 0x00000005
>> > > [    1.963030]   CM = 0, WnR = 0
>> > > [    1.963032] [000000406f127000] user address but active_mm is swapper
>> > > [    1.963038] Internal error: Oops: 96000005 [#1] PREEMPT SMP
>> > > [    1.963046] CPU: 1 PID: 1282 Comm: kworker/u17:1 Not tainted
>> > > 4.14.0-07281-g1b386f4 #666
>> > > [    1.963050] Hardware name: HiKey Development Board (DT)
>> > > [    1.963068] Workqueue: hci0 hci_cmd_work
>> > > [    1.963074] task: ffffffc0753c8000 task.stack: ffffff800b6c0000
>> > > [    1.963079] pstate: 80400005 (Nzcv daif +PAN -UAO)
>> > > [    1.963090] pc : hci_uart_tx_wakeup+0x38/0x148
>> > > [    1.963095] lr : hci_uart_tx_wakeup+0x30/0x148
>> > > [    1.963098] sp : ffffff800b6c3d10
>> > > [    1.963101] x29: ffffff800b6c3d10 x28: 0000000000000000
>> > > [    1.963107] x27: ffffffc074a79c78 x26: ffffffc07504d830
>> > > [    1.963112] x25: ffffff8008f76a30 x24: ffffffc07510a840
>> > > [    1.963117] x23: ffffffc07510aa10 x22: 0000000000000001
>> > > [    1.963122] x21: ffffff8008cd2000 x20: ffffffc0351cf288
>> > > [    1.963128] x19: ffffffc0351cf218 x18: 0000000000000000
>> > > [    1.963132] x17: 0000000000000000 x16: 0000000000000000
>> > > [    1.963137] x15: 0000000000000000 x14: ffffffc005fa1c00
>> > > [    1.963142] x13: 000000406f127000 x12: 0000000034d5d91d
>> > > [    1.963147] x11: 0000000000000400 x10: ffffffc077f8c480
>> > > [    1.963152] x9 : 0000000000000000 x8 : 0000000000000005
>> > > [    1.963157] x7 : 0000000000000000 x6 : ffffff8008f59e88
>> > > [    1.963162] x5 : 0000000000000003 x4 : 000000406f127000
>> > > [    1.963167] x3 : 0000000000000001 x2 : 000000406f127000
>> > > [    1.963172] x1 : ffffff8008cd2d28 x0 : 0000000000000000
>> > > [    1.963179] Process kworker/u17:1 (pid: 1282, stack limit =
>> > > 0xffffff800b6c0000)
>> > > [    1.963182] Call trace:
>> > > [    1.963188]  hci_uart_tx_wakeup+0x38/0x148
>> > > [    1.963193]  hci_uart_send_frame+0x28/0x38
>> > > [    1.963197]  hci_send_frame+0x64/0xc0
>> > > [    1.963201]  hci_cmd_work+0x98/0x110
>> > > [    1.963209]  process_one_work+0x134/0x330
>> > > [    1.963214]  worker_thread+0x130/0x468
>> > > [    1.963220]  kthread+0xf8/0x128
>> > > [    1.963227]  ret_from_fork+0x10/0x18
>> > > [    1.963234] Code: 9134a2a0 97f3be03 f9402280 d538d082 (b8626801)
>> > > [    1.963239] ---[ end trace 457a26b9096bec64 ]---
>> > >
>> >
>> > So I bisected this down and the issue looks like the boot regression is from:
>> >    67d2f8781b9f ("Bluetooth: hci_ldisc: Allow sleeping while proto
>> > locks are held")
>> >
>> > Reverting that change makes things work again.
>>
>> Hm, I notice percpu_init_rwsem() is only ever called in the hci_ldisc
>> case (from hci_uart_tty_open()) but apparently never in the hci_serdev
>> case.  Could that be the culprit?  Wondering why it's working in the
>> rwlock case then, perhaps by luck?
>
> As a shot in the dark, does the below patch help?
>
> -- >8 --
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
> index 71664b2..2582bef 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -304,6 +304,8 @@ int hci_uart_register_device(struct hci_uart *hu,
>
>         INIT_WORK(&hu->write_work, hci_uart_write_work);
>
> +       percpu_init_rwsem(&hu->proto_lock);
> +

Yes. This seems to avoid the issue!

thanks
-john
