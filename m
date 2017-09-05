Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1504637923-21652-3-git-send-email-loic.poulain@linaro.org>
References: <1504637923-21652-1-git-send-email-loic.poulain@linaro.org> <1504637923-21652-3-git-send-email-loic.poulain@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 5 Sep 2017 16:47:26 -0500
Message-ID: <CAL_JsqJhEaZkcBA6qnC3rVduQJ9Yesrz_h9i_WXo1bRaq1NT4Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Bluetooth: btqcomsmd: retieve BD address from DT
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 5, 2017 at 1:58 PM, Loic Poulain <loic.poulain@linaro.org> wrote:
> Retrieve BD address from the DT local-bd-address property.
> This address must be unique and is usually added in the DT
> by the bootloader which has access to the provisioned data.
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: Set device as unconfigured if default address detected
>      Add warning if BD addr retrieved from DT
>  v3: if no addr retrieved from DT, unconditionally set
>      the invalid BD addr flag.
>      swap and set bdaddr in the platform probe
>  v4: Add dt-bindings documentation
>      split patch in two parts (setup, dt prop)
>      use local-bd-address name instead of local-mac-address
>  v5: remove 2/3 merged in bluetooth-next tree
>      Add bluetooth.txt for common BT bindings
>      expect local-bd-address in little-endian format
>
>  drivers/bluetooth/btqcomsmd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index bd810d0..c6d3fd9 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -15,6 +15,8 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/rpmsg.h>
> +#include <linux/of.h>
> +
>  #include <linux/soc/qcom/wcnss_ctrl.h>
>  #include <linux/platform_device.h>
>
> @@ -135,6 +137,7 @@ static int btqcomsmd_setup(struct hci_dev *hdev)
>
>  static int btqcomsmd_probe(struct platform_device *pdev)
>  {
> +       const bdaddr_t *bdaddr;
>         struct btqcomsmd *btq;
>         struct hci_dev *hdev;
>         void *wcnss;
> @@ -156,6 +159,15 @@ static int btqcomsmd_probe(struct platform_device *pdev)
>         if (IS_ERR(btq->cmd_channel))
>                 return PTR_ERR(btq->cmd_channel);
>
> +       /* The local-bd-address DT property is usually injected by the
> +        * bootloader which has access to the allocated BD address.
> +        */
> +       bdaddr = of_get_property(pdev->dev.of_node, "local-bd-address", &ret);
> +       if (bdaddr && ret == sizeof(bdaddr_t)) {
> +               BT_INFO("BD address %pMR retrieved from device-tree", bdaddr);
> +               bacpy(&btq->bdaddr, bdaddr);
> +       }

Can we put all this into a helper function before we get more
instances. And use the u8 array property function. We're trying to
make of_get_property an internal function.

Rob
