Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1285075981-8941-2-git-send-email-suraj@atheros.com>
References: <1285075981-8941-1-git-send-email-suraj@atheros.com>
	<1285075981-8941-2-git-send-email-suraj@atheros.com>
Date: Tue, 21 Sep 2010 14:52:07 -0500
Message-ID: <AANLkTinS9YnKBUnv-RhV8ZZ185FtN_VDOWTQa3gTr6FC@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: support to send power management enable
 during hci open
From: Pavan Savoy <pavan_savoy@sify.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@atheros.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 21, 2010 at 8:33 AM, Suraj Sumangala <suraj@atheros.com> wrote:
> This patch enables HCI_UART_ATH3K transport driver to support
> sending Vendor specific hci commands during hci open
> to enable or disable power management feature.

Why? shouldn't this be done from the hciattach? like for the other
manufacturers?
If you want it to be sent before hci0 interface is exposed, send it
over ttyXX, you have your _init function and if you require it to be
sent after the hci0 is exposed - do it in the _post function.

> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  drivers/bluetooth/hci_ath.c |   59 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> index 6a160c1..d4b0653 100644
> --- a/drivers/bluetooth/hci_ath.c
> +++ b/drivers/bluetooth/hci_ath.c
> @@ -49,6 +49,37 @@ struct ath_struct {
>        struct work_struct ctxtsw;
>  };
>
> +/* Form HCI command */
> +static struct sk_buff *form_hci_cmd(struct hci_dev *hdev, __u16 opcode,
> +                                                __u32 plen, void *param)
> +{
> +       int len = HCI_COMMAND_HDR_SIZE + plen;
> +       struct hci_command_hdr *hdr;
> +       struct sk_buff *skb;
> +
> +       BT_DBG("%s opcode 0x%x plen %d", hdev->name, opcode, plen);
> +
> +       skb = bt_skb_alloc(len, GFP_ATOMIC);
> +       if (!skb) {
> +               BT_ERR("%s no memory for command", hdev->name);
> +               return NULL;
> +       }
> +
> +       hdr = (struct hci_command_hdr *) skb_put(skb, HCI_COMMAND_HDR_SIZE);
> +       hdr->opcode = cpu_to_le16(opcode);
> +       hdr->plen   = plen;
> +
> +       if (plen)
> +               memcpy(skb_put(skb, plen), param, plen);
> +
> +       BT_DBG("skb len %d", skb->len);
> +
> +       bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
> +       skb->dev = (void *) hdev;
> +
> +       return skb;
> +}
> +
>  static int ath_wakeup_ar3k(struct tty_struct *tty)
>  {
>        struct termios settings;
> @@ -81,6 +112,26 @@ static int ath_wakeup_ar3k(struct tty_struct *tty)
>        return status;
>  }
>
> +#define HCI_OP_SLEEP_SET                       0xFC04
> +static void ath_hci_init_driver(struct hci_uart *hu)
> +{
> +       struct ath_struct *ath = hu->priv;
> +       struct hci_dev *hdev = hu->hdev;
> +       struct sk_buff *skb;
> +
> +       if (!hdev)
> +               return;
> +
> +       if (!ath)
> +               return;
> +
> +       skb = form_hci_cmd(hdev, HCI_OP_SLEEP_SET, 1, &ath->cur_sleep);
> +       if (!skb)
> +               return;
> +
> +       skb_queue_head(&hdev->driver_init, skb);
> +}
> +
>  static void ath_hci_uart_work(struct work_struct *work)
>  {
>        int status;
> @@ -126,6 +177,13 @@ static int ath_open(struct hci_uart *hu)
>        return 0;
>  }
>
> +static int ath_hci_open(struct hci_uart *hu)
> +{
> +       ath_hci_init_driver(hu);
> +
> +       return 0;
> +}
> +
>  /* Flush protocol data */
>  static int ath_flush(struct hci_uart *hu)
>  {
> @@ -210,6 +268,7 @@ static int ath_recv(struct hci_uart *hu, void *data, int count)
>  static struct hci_uart_proto athp = {
>        .id = HCI_UART_ATH3K,
>        .open = ath_open,
> +       .hci_open = ath_hci_open,
>        .close = ath_close,
>        .recv = ath_recv,
>        .enqueue = ath_enqueue,
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
