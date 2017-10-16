Return-Path: <Dean_Jenkins@mentor.com>
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Allow sleeping while proto locks
 are held.
To: =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: Lukas Wunner <lukas@wunner.de>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20171015104045.GA25513@innovation.ch>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
Message-ID: <b7b223ca-4d7b-adfe-d1e9-fc1b45da653c@mentor.com>
Date: Mon, 16 Oct 2017 18:08:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171015104045.GA25513@innovation.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ronald,

On 15/10/17 11:40, =?UTF-8?q?Ronald=20Tschal=C3=A4r?= wrote:
> Lastly, the read-lock in the hci_uart_tx_wakeup() callback now needed
> to be removed because that function is called from an IRQ context. But
> since it doesn't actually call any proto functions, instead just
> queueing the work, and the other operations are atomic bit operations,
> this is ok.
You are discussing my commits so I'll try to answer your queries. I am a 
bit busy but I'll attempt to answer you in a timely manner.

Sorry, I know nothing about bcm, I will explain using BCSP scenarios.

I use SMP ARM based embedded systems in a commercial environment. These 
systems can suffer heavy CPU loading which can expose race conditions. 
The crashes are very rare in a PC environment.

I will try to explain why the locking is needed in hci_uart_tx_wakeup().

For reference, I am using the HEAD of Linux 4.14-rc4

There is at least 1 race condition to consider. The atomic variables do 
not help because the codeblock as a whole is not atomic. Hence locking 
is needed as follows.

The issue is that hci_uart_tty_close() runs asynchronously to 
hci_uart_tx_wakeup() which is shown below (assuming a SMP system).

int hci_uart_tx_wakeup(struct hci_uart *hu)
{
         read_lock(&hu->proto_lock);

In parallel, hci_uart_tty_close() can be running here:

         if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
                 goto no_schedule;

In parallel, hci_uart_tty_close() can be running here:

         if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {

In parallel, hci_uart_tty_close() can be running here:

                 set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
                 goto no_schedule;
         }

         BT_DBG("");

In parallel, hci_uart_tty_close() can be running here:

         schedule_work(&hu->write_work);

In parallel, hci_uart_tty_close() can be running here:

no_schedule:
         read_unlock(&hu->proto_lock);

         return 0;
}

hci_uart_tty_close() progressively removes the resources needed by the 
scheduled work queue hu->write_work which runs hci_uart_write_work(). 
Also there is a delay between the scheduling and hci_uart_write_work 
actually running. This means hci_uart_write_work() can race with 
hci_uart_tty_close(), sometimes causing hci_uart_tty_close() to crash, 
for example due to the write buffer no longer being there.

static void hci_uart_write_work(struct work_struct *work)
{
<snipped>
         set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
         len = tty->ops->write(tty, skb->data, skb->len);    <== can 
crash inside the write function pointer as the write buffer is no longer 
valid
         hdev->stat.byte_tx += len;    <== can crash here as hdev now 
invalid
<snipped>
}

Therefore, a robust solution is to lock out hci_uart_tty_close() when 
hci_uart_tx_wakeup() runs, that is the reason why 
read_lock(&hu->proto_lock) is used in hci_uart_write_work(). The atomic 
flag HCI_UART_PROTO_READY is prevented from being cleared whilst 
hci_uart_tx_wakeup() runs.

In fact, hci_uart_tty_close() is really a bit of a mess because it 
progressively removes resources. It is is based on old code which has 
been patched over the many years. Therefore it has kept code which is 
probably obsolete or duplicated. Ideally, hci_uart_tty_close() should be 
rewritten.

For example, there is a call
cancel_work_sync(&hu->write_work);
in  hci_uart_tty_close() which at first glance seems to be helpful but 
it is flawed because hci_uart_tx_wakeup() can schedule a new work item 
AFTER cancel_work_sync(&hu->write_work) runs. Therefore, locking is 
needed to prevent hci_uart_tx_wakeup() from being scheduled whilst 
HCI_UART_PROTO_READY is being cleared in hci_uart_tty_close().

In the case of BCSP, hci_bscp.c calls hci_uart_tx_wakeup() to schedule 
the transmission of BCSP frames. This includes BCSP retransmissions. 
Therefore, the scenario where a BCSP retransmission is being scheduled 
whilst hci_uart_tty_close() runs needs to be protected to avoid crashes. 
BCSP has a re-transmission timer which can expire whilst 
hci_uart_tty_close() runs.

In older kernels without my commits, when BCSP attempts to transmit 
during the execution of hci_uart_tty_close(), it can result in crashes 
as outlined above. The flag HCI_UART_PROTO_READY now prevents 
transmission and error messages can sometimes be seen from 
hci_uart_send_frame() because transmission is prevented.

It is possible that my commits might have been too robust so perhaps 
some simplification is possible.

Feel free to send me further questions about my commits. I will try to 
answer your queries within a couple of days each time.

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.
