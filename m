Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1403089780-21734-1-git-send-email-johan.hedberg@gmail.com>
References: <1403089780-21734-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 18 Jun 2014 14:46:36 +0200
Message-ID: <CAN_7+YbhUSyWDLuJMWykts+UzWrGNLfeLZakrBAY32HFXgcEDw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix checking for master LTKs
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On Wed, Jun 18, 2014 at 1:09 PM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> When the rename of STK_SLAVE to simply STK happened we missed this place
> in the ltk_type_master function. Now, checking for master is as simple
> as checking whether the type is SMP_LTK. The helper function is kept
> around for better readability in the (right now three) callers and for
> simpler extension with new key types in the future.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 6001b9293905..c3d184fd24de 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2974,10 +2974,7 @@ static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
>
>  static bool ltk_type_master(u8 type)
>  {
> -       if (type == SMP_STK || type == SMP_LTK)
> -               return true;
> -
> -       return false;
> +       return (type == SMP_LTK);
>  }
>
>  struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
> --
> 1.9.3
>

Now bonding as responder works just fine.

Tested-by Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR
Lukasz
