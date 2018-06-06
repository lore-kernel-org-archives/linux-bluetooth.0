Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1528266168-10351-1-git-send-email-amit.k.bag@intel.com>
References: <1528266168-10351-1-git-send-email-amit.k.bag@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Jun 2018 12:57:48 +0300
Message-ID: <CABBYNZJ0oHv2g9=jNE6tmy5tTgAx2FEuMoNgwEstohg2XdgTdw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Avoid race condition during controller recovery
To: Amit K Bag <amit.k.bag@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        sukumar.ghorai@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amit,

On Wed, Jun 6, 2018 at 9:22 AM, Amit K Bag <amit.k.bag@intel.com> wrote:
> From: Chethan T N <chethan.tumkur.narayan@intel.com>
>
> Observed race condition during controller recovery mechanism
> resulting the controller not responding to the reset command.
>
> To avoid such race condition need a delay of 2ms soon after the
> USB re-enumeration and before sending the Reset command which shall
> allow controller to completely recover and process the Reset command.
>
> BUG=b:64035404
> TEST=Magic tethering, P0 and P1 santiy test cases, kernel-boot log
>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
>  drivers/bluetooth/btusb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f73a27ea28cc..2303ac037240 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1743,6 +1743,15 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>
>         BT_DBG("%s", hdev->name);
>
> +       /* Observed race condition during controller recovery mechanism
> +        * resulting the controller not responding to the reset command.
> +        *
> +        * To avoid such race condition need a delay of 2ms soon after the
> +        * USB re-enumeration and before sending the Reset command which shall
> +        * allow controller to completely recover and process the Reset command.
> +        */
> +       mdelay(5);

Looks like the commit message and comment are not longer in sync with
the actual value here. Also perhaps this could be a parameter so any
hardware that has this problem just set how much delay it needs before
setup can be called.

>         /* The controller has a bug with the first HCI command sent to it
>          * returning number of completed commands as zero. This would stall the
>          * command processing in the Bluetooth core.
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
