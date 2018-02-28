Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Fix channel open check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180228001738.11131-1-bjorn.andersson@linaro.org>
Date: Wed, 28 Feb 2018 07:25:18 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        stable@vger.kernel.org
Message-Id: <1498F44F-02AE-4384-9227-0BABE3F4764E@holtmann.org>
References: <20180228001738.11131-1-bjorn.andersson@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bjorn,

> rpmsg_create_ept() returns NULL on error and as such
> qcom_wcnss_open_channel() does the same. Clarify this in the
> kernel-doc and correct the error checks in btqcomsmd.
> 
> Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> drivers/bluetooth/btqcomsmd.c | 8 ++++----
> drivers/soc/qcom/wcnss_ctrl.c | 2 ++
> 2 files changed, 6 insertions(+), 4 deletions(-)

I think you better split this into two separate patches so they can go via its subsystems independently.

> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index 2c9a5fc9137d..24f702927875 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -151,13 +151,13 @@ static int btqcomsmd_probe(struct platform_device *pdev)
> 
> 	btq->acl_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_ACL",
> 						   btqcomsmd_acl_callback, btq);
> -	if (IS_ERR(btq->acl_channel))
> -		return PTR_ERR(btq->acl_channel);
> +	if (!btq->acl_channel)
> +		return -ENOENT;
> 
> 	btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
> 						   btqcomsmd_cmd_callback, btq);
> -	if (IS_ERR(btq->cmd_channel))
> -		return PTR_ERR(btq->cmd_channel);
> +	if (!btq->cmd_channel)
> +		return -ENOENT;

Any reason not to fix qcom_wcnss_open_channel to use PTR_ERR?

Regards

Marcel
