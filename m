Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <1428092592-8588-1-git-send-email-marcel@holtmann.org>
References: <1428092592-8588-1-git-send-email-marcel@holtmann.org>
Date: Fri, 3 Apr 2015 13:56:37 -0700
Message-ID: <CAHrH25Qu5m-Y5XyKNHw-Ykn2AxVLniowA+EO_EGnBes8p_x20A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix location of TX power field in LE
 advertising data
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Fri, Apr 3, 2015 at 1:23 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> The TX power field in the LE advertising data should be placed last
> since it needs to be possible to enable kernel controlled TX power,
> but still allow for userspace provided flags field.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 20a7765680df..845dfcc43a20 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1043,6 +1043,14 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
>                 }
>         }
>
> +       if (instance) {
> +               memcpy(ptr, hdev->adv_instance.adv_data,
> +                      hdev->adv_instance.adv_data_len);
> +
> +               ad_len += hdev->adv_instance.adv_data_len;
> +               ptr += hdev->adv_instance.adv_data_len;
> +       }
> +
>         /* Provide Tx Power only if we can provide a valid value for it */
>         if (hdev->adv_tx_power != HCI_TX_POWER_INVALID &&
>             (instance_flags & MGMT_ADV_FLAG_TX_POWER)) {
> @@ -1054,12 +1062,6 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
>                 ptr += 3;
>         }
>
> -       if (instance) {
> -               memcpy(ptr, hdev->adv_instance.adv_data,
> -                      hdev->adv_instance.adv_data_len);
> -               ad_len += hdev->adv_instance.adv_data_len;
> -       }
> -
>         return ad_len;
>  }
>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This looks good. Johan, I reviewed this patch and it should be good to
go. Please apply when you get a chance.

Thanks,
Arman
