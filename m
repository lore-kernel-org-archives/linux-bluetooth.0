Return-Path: <mka@chromium.org>
Date: Fri, 11 May 2018 10:40:24 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] Bluetooth: btqca: Add wcn3990 firmware download
 support.
Message-ID: <20180511174024.GL19594@google.com>
References: <1526041263-18795-1-git-send-email-bgodavar@codeaurora.org>
 <1526041263-18795-3-git-send-email-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1526041263-18795-3-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

On Fri, May 11, 2018 at 05:51:02PM +0530, Balakrishna Godavarthi wrote:
> This patch enables the RAM and NV patch download for wcn3990.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h | 13 +++++++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 8219816..40c6b4f 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -27,7 +27,7 @@
>  
>  #define VERSION "0.1"
>  
> -static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
> +int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)

If this and other functions aren't really Rome specific they should
probably be renamed to qca_...

> +int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
> +			    u32 *soc_ver)
> +{
> +	struct rome_config config;
> +	int err;
> +
> +	/* we are using the existing funciton of ROME,
> +	 * instead of duplicating the function for wcn3990.
> +	 */

The comment isn't quite accurate, the qca_uart_setup_cherokee() calls
existing functions, but is essentially a copy of qca_uart_setup_rome().

The main difference is that the patch version is passed as a parameter
instead of determining it in the uart setup function. There seems to
be no need to pass the version number in, or if you prefer to do it
this way, you could change the Rome code to do this.

The other delta is the filename extension of the rampatch file, which
is .bin for Rome and .tlv for Cherokee. Is there a good reason to use
a different extension? If not just stick to the existing naming
scheme, otherwise you could pass the chip type as a parameter and
chose the extensions based on that.

Thanks

Matthias
