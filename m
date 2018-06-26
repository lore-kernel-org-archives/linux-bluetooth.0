Return-Path: <mka@chromium.org>
Date: Mon, 25 Jun 2018 18:05:59 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180626010559.GK129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-8-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180625134013.19684-8-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 25, 2018 at 07:10:13PM +0530, Balakrishna Godavarthi wrote:
> Add support to set voltage/current of various regulators
> to power up/down Bluetooth chip wcn3990.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> changes in v8:
>     * closing qca buffer, if qca_power_setup fails
>     * chnaged ibs start timer function call location.
>     * updated review comments.
>   	
> changes in v7:
>     * addressed review comments.
> 
> changes in v6:
>     * Hooked up qca_power to qca_serdev.
>     * renamed all the naming inconsistency functions with qca_*
>     * leveraged common code of ROME for wcn3990.
>     * created wrapper functions for re-usable blocks.
>     * updated function of _*regulator_enable and _*regualtor_disable.  
>     * removed redundant comments and functions.
>     * addressed review comments.
> 
> Changes in v5:
>     * updated regulator vddpa min_uV to 1304000.
>       * addressed review comments.
>  
> Changes in v4:
>     * Segregated the changes of btqca from hci_qca
>     * rebased all changes on top of bluetooth-next.
>     * addressed review comments.
> 
> ---
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 28187a89b850..bd4c9a78716f 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> ...
> +static int qca_send_vendor_cmd(struct hci_dev *hdev, u8 cmd)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
> +	struct sk_buff *skb;
> +
> +	bt_dev_dbg(hdev, "sending command %02x to SoC", cmd);
> +
> +	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> +	if (!skb) {
> +		bt_dev_err(hdev, "Failed to allocate memory for vendor packet");

As mentioned on v7, custom OOM messages should be avoided.

>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  {
> +	struct qca_serdev *qcadev;
>  	unsigned int speed, qca_baudrate;
>  	int ret;
>  
> @@ -971,6 +1054,13 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		return 0;
>  	}
>  
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
> +	/* Disabling hardware flow control is preferred while
> +	 * sending change baud rate command to SoC.
> +	 */

Is it only preferred or must be?

> +	if (qcadev->btsoc_type == QCA_WCN3990)
> +		hci_uart_set_flow_control(hu, true);
> +

nit: consider doing this just before qca_set_baudrate(). It doesn't
make a difference but leaves it clearer what exactly needs to be
'protected' (analogy to locking).

>  	qca_baudrate = qca_get_baudrate_value(speed);
>  	bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
>  	ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> @@ -980,8 +1070,10 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  	}
>  
>  	host_set_baudrate(hu, speed);
> +	if (qcadev->btsoc_type == QCA_WCN3990)
> +		hci_uart_set_flow_control(hu, false);

>  static int qca_setup(struct hci_uart *hu)
> @@ -989,10 +1081,11 @@ static int qca_setup(struct hci_uart *hu)
>  	struct hci_dev *hdev = hu->hdev;
>  	struct qca_data *qca = hu->priv;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
> +	struct qca_serdev *qcadev;
>  	int ret;
>  	int soc_ver = 0;
>  
> -	bt_dev_info(hdev, "ROME setup");
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>  
>  	/* Patch downloading has to be done without IBS mode */
>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> @@ -1000,6 +1093,35 @@ static int qca_setup(struct hci_uart *hu)
>  	/* Setup initial baudrate */
>  	qca_set_speed(hu, QCA_INIT_SPEED);
>  
> +	if (qcadev->btsoc_type == QCA_WCN3990) {
> +		bt_dev_dbg(hdev, "setting up wcn3990");
> +		hci_uart_set_flow_control(hu, true);
> +		ret = qca_send_vendor_cmd(hdev, QCA_WCN3990_POWERON_PULSE);
> +		if (ret)
> +			return ret;
> +
> +		hci_uart_set_flow_control(hu, false);
> +		serdev_device_close(hu->serdev);
> +		ret = serdev_device_open(hu->serdev);
> +		if (ret) {
> +			bt_dev_err(hdev, "failed to open port");
> +			return ret;
> +		}
> +
> +		msleep(100);

Is the sleep really related with _open() or is it rather that the
device needs to settle after the power on pulse? In the latter case
I'd suggest to do the sleep before _open(), if it doesn't make a
functional difference (makes the code a bit more self documenting).

> +		/* Setup initial baudrate */
> +		qca_set_speed(hu, QCA_INIT_SPEED);
> +		hci_uart_set_flow_control(hu, false);

This is still a bit noisy with all the open/close and flow control
stuff. If I understand correctly this essentially switches the
controller on (or resets it?) and brings it (and the driver) into a
sane state. Would it make sense to move the above block into a
wcn3990_init/reset() or so?
