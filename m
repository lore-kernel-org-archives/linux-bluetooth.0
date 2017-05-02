Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170502065419.7959-1-marcel@holtmann.org>
References: <20170502065419.7959-1-marcel@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 May 2017 10:37:55 +0300
Message-ID: <CABBYNZLX2FNXL7pW9AXodwypo-QzDvf0eBJ5yGjg-GZYBkDdkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Enable LE Channel Selection Algorithm event
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, May 2, 2017 at 9:54 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> If the Channel Selection Algorithm #2 feature is supported, then enable
> the new LE Channel Selection Algorithm event.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 1 +
>  net/bluetooth/hci_core.c    | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 99aa5e5e3100..dd43cfdd443a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -399,6 +399,7 @@ enum {
>  #define HCI_LE_PING                    0x10
>  #define HCI_LE_DATA_LEN_EXT            0x20
>  #define HCI_LE_EXT_SCAN_POLICY         0x80
> +#define HCI_LE_CHAN_SEL_ALG2           0x40
>
>  /* Connection modes */
>  #define HCI_CM_ACTIVE  0x0000
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4a0cac774107..e58b9034afff 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -635,6 +635,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>                                                  * Report
>                                                  */
>
> +               /* If the controller supports Channel Selection Algorithm #2
> +                * feature, enable the corresponding event.
> +                */
> +               if (hdev->le_features[1] & HCI_LE_CHAN_SEL_ALG2)
> +                       events[2] |= 0x08;      /* LE Channel Selection
> +                                                * Algorithm
> +                                                */

It might look better if you move the comments before the assignment
and it may actually fit in a single line. Btw, shoudn't we have a
define for 0x08?

>                 /* If the controller supports the LE Set Scan Enable command,
>                  * enable the corresponding advertising report event.
>                  */
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
