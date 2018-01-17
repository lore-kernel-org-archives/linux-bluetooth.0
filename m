Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1516160848-471-1-git-send-email-yi2010.guo@samsung.com>
References: <CGME20180117034755epcas5p1437f6831b91eb594a1106f0960204b81@epcas5p1.samsung.com>
 <1516160848-471-1-git-send-email-yi2010.guo@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Jan 2018 10:15:10 -0200
Message-ID: <CABBYNZJjOEandxFeqbnei3bWpsNetWTbnna+7zGi5FofzcS59g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix disconnect bug in 6lowpan
To: Guo Yi <yi2010.guo@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 17, 2018 at 1:47 AM, Guo Yi <yi2010.guo@samsung.com> wrote:
> This patch fix the bluetooth 6lowpan disconnect fail bug.
>
> The type of the same address type have different define value in HCI layer
> and L2CAP layer.That makes disconnect fail due to wrong network type.User
> will not be able to disconnect from console with the network type that used
> in connect.
>
> This patch add a var lookup_type, and covert the channel address type to
> HCI address type. By these means, user can disconnect successfuly.
>
> Signed-off-by: Guo Yi <yi2010.guo@samsung.com>

While this fix seems alright the debugfs interface was never meant for
production, in fact we are working on a replacement:

https://www.spinics.net/lists/linux-bluetooth/msg72499.html

> ---
>  net/bluetooth/6lowpan.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 795ddd8..332dddb 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -1104,11 +1104,18 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
>         struct hci_dev *hdev;
>         bdaddr_t *src = BDADDR_ANY;
>         int n;
> +       u8 lookup_type;
>
>         n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
>                    &addr->b[5], &addr->b[4], &addr->b[3],
>                    &addr->b[2], &addr->b[1], &addr->b[0],
>                    addr_type);
> +       /* Convert from L2CAP channel address type to HCI address type
> +        */
> +       if (*addr_type == BDADDR_LE_PUBLIC)
> +               lookup_type = ADDR_LE_DEV_PUBLIC;
> +       else
> +               lookup_type = ADDR_LE_DEV_RANDOM;
>
>         if (n < 7)
>                 return -EINVAL;
> @@ -1118,7 +1125,7 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
>                 return -ENOENT;
>
>         hci_dev_lock(hdev);
> -       hcon = hci_conn_hash_lookup_le(hdev, addr, *addr_type);
> +       hcon = hci_conn_hash_lookup_le(hdev, addr, lookup_type);
>         hci_dev_unlock(hdev);
>
>         if (!hcon)
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
