Return-Path: <mka@chromium.org>
Date: Thu, 2 Aug 2018 10:15:18 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
	rtatiya@codeaurora.org, hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v12 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180802171518.GM68975@google.com>
References: <20180802132518.8680-1-bgodavar@codeaurora.org>
 <20180802132518.8680-8-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180802132518.8680-8-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balakrishna,

only two minor comments, though I hate to make you respin once more
for nits. I also noticed a possible error in the DT bindings, so maybe
you'd have to respin anyway ...

On Thu, Aug 02, 2018 at 06:55:18PM +0530, Balakrishna Godavarthi wrote:
> Add support to set voltage/current of various regulators
> to power up/down Bluetooth chip wcn3990.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v12:
>     * removed retrying iteration loop in qca_wcn3990_init.
>  
> Changes in v11:
>     * removed support to read regulator currents from dts.	
>     * updated review comments.
> 
> Changes in v10:
>     * added support to read regulator currents from dts.
>     * added support to try to connect with chip if it fails to respond to initial commands
>     * updated review comments.
> 
> changes in v9:
>     * moved flow control to vendor and set_baudarte functions.
>     * removed parent regs.
> 
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
>  drivers/bluetooth/btqca.h   |   3 +
>  drivers/bluetooth/hci_qca.c | 404 +++++++++++++++++++++++++++++++-----
>  2 files changed, 360 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index a9c2779f3e07..0c01f375fe83 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -37,6 +37,9 @@
>  #define EDL_TAG_ID_HCI			(17)
>  #define EDL_TAG_ID_DEEP_SLEEP		(27)
>  
> +#define QCA_WCN3990_POWERON_PULSE	0xFC
> +#define QCA_WCN3990_POWEROFF_PULSE	0xC0
> +
>  enum qca_bardrate {
>  	QCA_BAUDRATE_115200 	= 0,
>  	QCA_BAUDRATE_57600,
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a6e7d38ef931..24ce42babe6d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
>
> ...
>
> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	int ret;
> +
> +	/* Forcefully enable wcn3990 to enter in to boot mode. */
> +	host_set_baudrate(hu, 2400);
> +	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
> +	if (ret)
> +		return ret;
> +
> +	qca_set_speed(hu, QCA_INIT_SPEED);
> +	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for 100 ms for SoC to boot */
> +	msleep(100);
> +
> +	/* Now the device is in ready state to communicate with host.
> +	 * To sync host with device we need to reopen port.
> +	 * Without this, we will have RTS and CTS synchronization
> +	 * issues.
> +	 */
> +	serdev_device_close(hu->serdev);
> +	ret = serdev_device_open(hu->serdev);
> +	if (ret) {
> +		bt_dev_err(hu->hdev, "failed to open port");
> +		return ret;
> +	}
> +
> +	hci_uart_set_flow_control(hu, false);
> +	ret = qca_read_soc_version(hdev, soc_ver);
> +
> +	return ret;

return qca_read_soc_version(hdev, soc_ver);

> +static int qca_power_setup(struct hci_uart *hu, bool on)
> +{
> +	struct qca_vreg *vregs;
> +	struct regulator_bulk_data *vreg_bulk;
> +	struct qca_serdev *qcadev;
> +	int i, num_vregs, ret = 0;
> +
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
> +	if (!qcadev || !qcadev->bt_power || !qcadev->bt_power->vreg_data ||
> +	    !qcadev->bt_power->vreg_bulk)
> +		return -EINVAL;
> +
> +	vregs = qcadev->bt_power->vreg_data->vregs;
> +	vreg_bulk = qcadev->bt_power->vreg_bulk;
> +	num_vregs = qcadev->bt_power->vreg_data->num_vregs;
> +	BT_DBG("on: %d", on);
> +	if (on  && !qcadev->bt_power->vregs_on) {

Remove extra blank after 'on'

Other than that:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks for following through!
