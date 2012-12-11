Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Dec 2012 09:32:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Don't send new commands before CC for reset is
 received
Message-ID: <20121211073210.GA2447@x220>
References: <1355148525-29379-1-git-send-email-szymon.janc@tieto.com>
 <1355148525-29379-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355148525-29379-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 10, 2012, Szymon Janc wrote:
> After sending reset command wait for its command complete event before
> sending next command. Some chips sends CC event for command received
> before reset if reset was send before chip replied with CC.
> 
> < HCI Command: Reset (0x03|0x0003) plen 0                              [hci0] 18.404612
> > HCI Event: Command Complete (0x0e) plen 4                            [hci0] 18.405850
>       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0      [hci0] 18.406079
> > HCI Event: Command Complete (0x0e) plen 4                            [hci0] 18.407864
>       Reset (0x03|0x0003) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0      [hci0] 18.408062
> > HCI Event: Command Complete (0x0e) plen 12                           [hci0] 18.408835
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 705078a..81b4448 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2688,7 +2688,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  	if (ev->opcode != HCI_OP_NOP)
>  		del_timer(&hdev->cmd_timer);
>  
> -	if (ev->ncmd) {
> +	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
>  		atomic_set(&hdev->cmd_cnt, 1);
>  		if (!skb_queue_empty(&hdev->cmd_q))
>  			queue_work(hdev->workqueue, &hdev->cmd_work);

This looks fine to me though I'd consider adding a Cc: stable tag to it
and rename the summary to "Fix sending commands..." to make clear that
this is a fix.

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
