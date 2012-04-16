Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334567093-15058-1-git-send-email-hemant.gupta@stericsson.com>
References: <1334567093-15058-1-git-send-email-hemant.gupta@stericsson.com>
Date: Mon, 16 Apr 2012 14:43:25 +0530
Message-ID: <CACj007mHeaB+xMhx9Q+ufQLt+bBwUDaqVz7DCZeAs24ALnGiGw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] Bluetooth: mgmt: Add helper function for Address Type
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 16, 2012 at 2:34 PM, Hemant Gupta
<hemant.gupta@stericsson.com> wrote:
> This patch adds helper function for converting address type received
> from user space to corresponding Address types as per BT spec.
>
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/mgmt.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 880b7c9..cb83644 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1644,6 +1644,25 @@ static u8 link_to_mgmt(u8 link_type, u8 addr_type)
>        }
>  }
>
> +static u8 mgmt_to_link(u8 link_type, u8 addr_type)
> +{
> +       switch (link_type) {
> +       case LE_LINK:
> +               switch (addr_type) {
> +               case MGMT_ADDR_LE_PUBLIC:
> +                       return ADDR_LE_DEV_PUBLIC;
> +
> +               default:
> +                       /* Fallback to LE Random address type */
> +                       return ADDR_LE_DEV_RANDOM;
> +               }
> +
> +       default:
> +               /* Fallback to BR/EDR type */
> +               return ACL_LINK;
> +       }
> +}
> +
>  static int get_connections(struct sock *sk, struct hci_dev *hdev, void *data,
>                           u16 data_len)
>  {
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Please ignore this patch, as compiler warning is generated because of
non usage of static function, will send a new single patch shortly

-- 
Best Regards
Hemant Gupta
ST-Ericsson India
