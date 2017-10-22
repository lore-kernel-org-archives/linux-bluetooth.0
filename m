Return-Path: <Dean_Jenkins@mentor.com>
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Allow sleeping while proto locks
 are held.
To: "Life is hard, and then you die" <ronald@innovation.ch>
CC: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Lukas Wunner
	<lukas@wunner.de>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20171015104045.GA25513@innovation.ch>
 <b7b223ca-4d7b-adfe-d1e9-fc1b45da653c@mentor.com>
 <20171018020035.GB12182@innovation.ch>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
Message-ID: <66738b01-c25d-cda7-07f0-dbf6500eed95@mentor.com>
Date: Sun, 22 Oct 2017 15:57:50 +0100
MIME-Version: 1.0
In-Reply-To: <20171018020035.GB12182@innovation.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ronald,

Sorry for my delay in replying to you.

On 18/10/17 03:00, Life is hard, and then you die wrote:
>
>> In fact, hci_uart_tty_close() is really a bit of a mess because it
>> progressively removes resources. It is is based on old code which has been
>> patched over the many years. Therefore it has kept code which is probably
>> obsolete or duplicated. Ideally, hci_uart_tty_close() should be rewritten.
>>
>> For example, there is a call
>> cancel_work_sync(&hu->write_work);
>> in  hci_uart_tty_close() which at first glance seems to be helpful but it is
>> flawed because hci_uart_tx_wakeup() can schedule a new work item AFTER
>> cancel_work_sync(&hu->write_work) runs. Therefore, locking is needed to
>> prevent hci_uart_tx_wakeup() from being scheduled whilst
>> HCI_UART_PROTO_READY is being cleared in hci_uart_tty_close().
> Actually, I think there's still problem: in hci_uart_tty_close()
> cancel_work_sync() is called before the HCI_UART_PROTO_READY flag is
> cleared, opening the following race:
>
>             P1                                P2
>      cancel_work_sync()
>                                         hci_uart_tx_wakeup()
>      clear_bit(HCI_UART_PROTO_READY)
>      clean up
>                                         hci_uart_write_work()
Yes, this looks bad. There is some protection in hci_uart_write_work() 
because hci_uart_dequeue(hu) checks HCI_UART_PROTO_READY but it will not 
be foolproof due to resources being removed by hci_uart_tty_close().
>
> So AFAICT cancel_work_sync() needs to be done after clearing the flag:
>
>          if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>                  write_lock_irqsave(&hu->proto_lock, flags);
>                  clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>                  write_unlock_irqrestore(&hu->proto_lock, flags);
>
>                  cancel_work_sync(&hu->write_work);      // <---
I agree with this solution. I was going to suggest this but you beat me 
to it ;-)
>
>                  if (hdev) {
>
> (if HCI_UART_PROTO_READY is already clear, then no work can be pending,
> so no need to cancel work in that case).
>
I agree with your statement.

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.
