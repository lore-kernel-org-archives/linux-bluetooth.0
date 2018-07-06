Return-Path: <mka@chromium.org>
Date: Fri, 6 Jul 2018 15:35:24 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
	rtatiya@codeaurora.org, hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
Message-ID: <20180706223524.GL129942@google.com>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180705165515.13340-4-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 05, 2018 at 10:25:11PM +0530, Balakrishna Godavarthi wrote:
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
> Changes in v9:
>    * moved qca_read_soc_ver() to qca_setup().
> 
> Changes in v8:
>     * updated soc_type with enum.
> 
> Changes in v7:
>     * initial patch
>     * redefined qca_uart_setup function to generic.
> ---
>  drivers/bluetooth/btqca.c   | 17 ++++-------------
>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>  drivers/bluetooth/hci_qca.c | 11 ++++++++++-
>  3 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c5cf9cab438a..03bcbaaf1ae9 100644
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
> @@ -337,19 +337,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
>  
>  	config.user_baud_rate = baudrate;
>  
> -	/* Get QCA version information */
> -	err = qca_read_soc_version(hdev, &rome_ver);
> -	if (err < 0 || rome_ver == 0) {
> -		bt_dev_err(hdev, "QCA Failed to get version %d", err);
> -		return err;
> -	}
> -
> -	bt_dev_info(hdev, "QCA controller version 0x%08x", rome_ver);
> -
>  	/* Download rampatch file */
>  	config.type = TLV_TYPE_PATCH;
>  	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
> -		 rome_ver);
> +		 soc_ver);
>  	err = qca_download_firmware(hdev, &config);
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
> @@ -359,7 +350,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
>  	/* Download NVM configuration */
>  	config.type = TLV_TYPE_NVM;
>  	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
> -		 rome_ver);
> +		 soc_ver);
>  	err = qca_download_firmware(hdev, &config);
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 5c9851b11838..a9c2779f3e07 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -124,10 +124,18 @@ struct tlv_type_hdr {
>  	__u8   data[0];
>  } __packed;
>  
> +enum qca_btsoc_type {
> +	QCA_INVALID = -1,
> +	QCA_AR3002,
> +	QCA_ROME,
> +	QCA_WCN3990
> +};
> +
>  #if IS_ENABLED(CONFIG_BT_QCA)
>  
>  int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> -int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate);
> +int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> +		   enum qca_btsoc_type soc_type, u32 soc_ver);
>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
>  
>  #else
> @@ -137,7 +145,8 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
> +static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> +				 enum qca_btsoc_type soc_type, u32 soc_ver)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index d7b60669b656..c02e1d465cca 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -929,6 +929,7 @@ static int qca_setup(struct hci_uart *hu)
>  	struct qca_data *qca = hu->priv;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>  	int ret;
> +	int soc_ver = 0;
>  
>  	bt_dev_info(hdev, "ROME setup");
>  
> @@ -965,8 +966,16 @@ static int qca_setup(struct hci_uart *hu)
>  		host_set_baudrate(hu, speed);
>  	}
>  
> +	/* Get QCA version information */
> +	ret = qca_read_soc_version(hdev, &soc_ver);
> +	if (ret < 0 || soc_ver == 0) {
> +		bt_dev_err(hdev, "QCA Failed to get version (%d)", ret);
> +		return ret;
> +	}
> +	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);

As commented on [1] I'd suggest to move some of the logging and error
handling to qca_read_soc_version(), especially since this sequence is
duplicated later in this series.

Not really the scope of this patch though, so:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

[1] https://patchwork.kernel.org/patch/10510029/
