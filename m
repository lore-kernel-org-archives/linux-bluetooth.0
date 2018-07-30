Return-Path: <mka@chromium.org>
Date: Mon, 30 Jul 2018 11:37:08 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
	rtatiya@codeaurora.org, hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH v11 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
Message-ID: <20180730183708.GA68975@google.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
 <20180727141320.25218-4-bgodavar@bgodavar-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180727141320.25218-4-bgodavar@bgodavar-linux.qualcomm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 27, 2018 at 07:43:16PM +0530, Balakrishna Godavarthi wrote:
> From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> 
> Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
> SoC, to use the same function instead of duplicating the function.
> Added new arguments soc_type and soc_ver to the functions.
> 
> These arguments will help to decide type of firmware files
> to be loaded into Bluetooth chip.
> soc_type holds the Bluetooth chip connected to APPS processor.
> soc_ver holds the Bluetooth chip version.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v11:
>       * added error log in qca_read_soc_version() instead of qca_setup() 
> ---
>  drivers/bluetooth/btqca.c   | 23 ++++++++++-------------
>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>  drivers/bluetooth/hci_qca.c | 10 +++++++++-
>  3 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c5cf9cab438a..b2163bf75b95 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -85,6 +85,12 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
>  out:
>  	kfree_skb(skb);
>  
> +	if (!err && *soc_version == 0)
> +		err = -EILSEQ;

nit: better do this right after assigning SoC version. No need to
respin the series just for this though.
