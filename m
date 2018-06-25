Return-Path: <mka@chromium.org>
Date: Mon, 25 Jun 2018 16:20:57 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
Message-ID: <20180625232057.GH129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180625134013.19684-4-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 25, 2018 at 07:10:09PM +0530, Balakrishna Godavarthi wrote:
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
> ---
> Changes in v8:
>     * updated soc_type with enum.
> 
> Changes in v7:
>     * initial patch
>     * redefined qca_uart_setup function to generic.
> ---
>  drivers/bluetooth/btqca.c   | 23 ++++++++++++-----------
>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>  drivers/bluetooth/hci_qca.c |  3 ++-
>  3 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c5cf9cab438a..3b25be1be19c 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -327,9 +327,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>  
> -int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
> +int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> +		   enum qca_btsoc_type soc_type, u32 soc_ver)
>  {
> -	u32 rome_ver = 0;
>  	struct rome_config config;
>  	int err;
>  
> @@ -337,19 +337,20 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
>  
>  	config.user_baud_rate = baudrate;
>  
> -	/* Get QCA version information */
> -	err = qca_read_soc_version(hdev, &rome_ver);
> -	if (err < 0 || rome_ver == 0) {
> -		bt_dev_err(hdev, "QCA Failed to get version %d", err);
> -		return err;
> +	if (!soc_ver) {
> +		/* Get QCA version information */
> +		err = qca_read_soc_version(hdev, &soc_ver);
> +		if (err < 0 || soc_ver == 0) {
> +			bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
> +			return err;
> +		}
> +		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>  	}

I thought we agreed in the discussion on "[v7,4/8] Bluetooth: btqca:
Redefine qca_uart_setup() to generic function" to call
qca_read_soc_version() in common code. Did I misinterpret that?

> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 5c9851b11838..24d6667eecf1 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> ...
> -static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
> +static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> +				 enum qca_btsoc_type soc_type, u32 soc_ver);

Remove trailing semicolon.
