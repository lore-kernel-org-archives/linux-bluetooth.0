Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 19:00:35 -0700
From: "Life is hard, and then you die" <ronald@innovation.ch>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Allow sleeping while proto locks
 are held.
Message-ID: <20171018020035.GB12182@innovation.ch>
References: <20171015104045.GA25513@innovation.ch>
 <b7b223ca-4d7b-adfe-d1e9-fc1b45da653c@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <b7b223ca-4d7b-adfe-d1e9-fc1b45da653c@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


  Hi Dean,

apologies for the slow reply, and thank you for the detailed response.

On Mon, Oct 16, 2017 at 06:08:37PM +0100, Dean Jenkins wrote:
> 
> On 15/10/17 11:40, =?UTF-8?q?Ronald=20Tschal=C3=A4r?= wrote:
> >Lastly, the read-lock in the hci_uart_tx_wakeup() callback now needed
> >to be removed because that function is called from an IRQ context. But
> >since it doesn't actually call any proto functions, instead just
> >queueing the work, and the other operations are atomic bit operations,
> >this is ok.
[snip]
> There is at least 1 race condition to consider. The atomic variables do not
> help because the codeblock as a whole is not atomic. Hence locking is needed
> as follows.
> 
> The issue is that hci_uart_tty_close() runs asynchronously to
> hci_uart_tx_wakeup() which is shown below (assuming a SMP system).
> 
> int hci_uart_tx_wakeup(struct hci_uart *hu)
> {
>         read_lock(&hu->proto_lock);
> 
> In parallel, hci_uart_tty_close() can be running here:
> 
>         if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
>                 goto no_schedule;
> 
> In parallel, hci_uart_tty_close() can be running here:
> 
>         if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
> 
> In parallel, hci_uart_tty_close() can be running here:
> 
>                 set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
>                 goto no_schedule;
>         }
> 
>         BT_DBG("");
> 
> In parallel, hci_uart_tty_close() can be running here:
> 
>         schedule_work(&hu->write_work);
> 
> In parallel, hci_uart_tty_close() can be running here:
> 
> no_schedule:
>         read_unlock(&hu->proto_lock);
> 
>         return 0;
> }
> 
> hci_uart_tty_close() progressively removes the resources needed by the
> scheduled work queue hu->write_work which runs hci_uart_write_work(). Also
> there is a delay between the scheduling and hci_uart_write_work actually
> running. This means hci_uart_write_work() can race with
> hci_uart_tty_close(), sometimes causing hci_uart_tty_close() to crash, for
> example due to the write buffer no longer being there.
> 
> static void hci_uart_write_work(struct work_struct *work)
> {
> <snipped>
>         set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
>         len = tty->ops->write(tty, skb->data, skb->len);    <== can crash
> inside the write function pointer as the write buffer is no longer valid
>         hdev->stat.byte_tx += len;    <== can crash here as hdev now invalid
> <snipped>
> }
> 
> Therefore, a robust solution is to lock out hci_uart_tty_close() when
> hci_uart_tx_wakeup() runs, that is the reason why read_lock(&hu->proto_lock)
> is used in hci_uart_write_work(). The atomic flag HCI_UART_PROTO_READY is
> prevented from being cleared whilst hci_uart_tx_wakeup() runs.

Got it, thanks. So to summarize, the core issue is that in
hci_uart_tx_wakeup() these two need to be atomic

        if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
                goto no_schedule;

        schedule_work(&hu->write_work);

so that new work won't be scheduled after close.

I think then that this can fixed by using the trylock variants here:

 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
-       read_lock(&hu->proto_lock);
+       /* This may be called in an IRQ context, so we can't sleep. Therefore
+        * we only try to acquire the lock, and if that fails we assume the
+        * tty is being closed because that is the only time the write lock is
+        * acquired. If, however, at some point in the future the write lock
+        * is also acquired in other situations, then this must be revisited.
+        */
+       if (!percpu_down_read_trylock(&hu->proto_lock))
+               return 0;

        if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
                goto no_schedule;
@@ -145,8 +143,6 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
        schedule_work(&hu->write_work);

 no_schedule:
-       read_unlock(&hu->proto_lock);
+       percpu_up_read(&hu->proto_lock);

        return 0;
 }


> In fact, hci_uart_tty_close() is really a bit of a mess because it
> progressively removes resources. It is is based on old code which has been
> patched over the many years. Therefore it has kept code which is probably
> obsolete or duplicated. Ideally, hci_uart_tty_close() should be rewritten.
> 
> For example, there is a call
> cancel_work_sync(&hu->write_work);
> in  hci_uart_tty_close() which at first glance seems to be helpful but it is
> flawed because hci_uart_tx_wakeup() can schedule a new work item AFTER
> cancel_work_sync(&hu->write_work) runs. Therefore, locking is needed to
> prevent hci_uart_tx_wakeup() from being scheduled whilst
> HCI_UART_PROTO_READY is being cleared in hci_uart_tty_close().

Actually, I think there's still problem: in hci_uart_tty_close()
cancel_work_sync() is called before the HCI_UART_PROTO_READY flag is
cleared, opening the following race:

           P1                                P2
    cancel_work_sync()
                                       hci_uart_tx_wakeup()
    clear_bit(HCI_UART_PROTO_READY)
    clean up
                                       hci_uart_write_work()

So AFAICT cancel_work_sync() needs to be done after clearing the flag:

        if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
                write_lock_irqsave(&hu->proto_lock, flags);
                clear_bit(HCI_UART_PROTO_READY, &hu->flags);
                write_unlock_irqrestore(&hu->proto_lock, flags);

                cancel_work_sync(&hu->write_work);      // <---

                if (hdev) {

(if HCI_UART_PROTO_READY is already clear, then no work can be pending,
so no need to cancel work in that case).



  Cheers,

  Ronald
