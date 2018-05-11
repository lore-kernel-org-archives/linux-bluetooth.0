Return-Path: <mka@chromium.org>
Date: Fri, 11 May 2018 14:25:20 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990.
Message-ID: <20180511212520.GM19594@google.com>
References: <1526041263-18795-1-git-send-email-bgodavar@codeaurora.org>
 <1526041263-18795-4-git-send-email-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1526041263-18795-4-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

On Fri, May 11, 2018 at 05:51:03PM +0530, Balakrishna Godavarthi wrote:
> Add support to set voltage/current of various regulators
> to power up/down Bluetooth chip wcn3990.
> Add support to read baudrate from dts.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---

Please include a change log also in the individual patches, not just
in the cover letter. In a revision after many comments it may be
sufficient to say "addressed <reviewers> comments", if the number if
changes is limited it is preferable to briefly list the individual
changes.

>  drivers/bluetooth/btqca.h   |   6 +
>  drivers/bluetooth/hci_qca.c | 547 ++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 480 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 2a7366b..8e2142a 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -37,6 +37,9 @@
>  #define EDL_TAG_ID_HCI			(17)
>  #define EDL_TAG_ID_DEEP_SLEEP		(27)
>  
> +#define CHEROKEE_POWERON_PULSE          (0xFC)
> +#define CHEROKEE_POWEROFF_PULSE         (0xC0)

The parentheses are not needed around a literal. That they are used
for the other values is IMO no good reason to introduce more of them.
You might want to squeeze in a clean up patch that removes them for
the other defines.

> +int btqca_power_setup(bool on);
> +int qca_btsoc_cleanup(struct hci_dev *hdev);

nit: inconsistent naming.

If maintainers and authors have no objections you might want to
squeeze in a patch that renames everything to btqca. Just a suggestion
though.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f05382b..71f9591 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -5,7 +5,7 @@
>   *  protocol extension to H4.
>   *
>   *  Copyright (C) 2007 Texas Instruments, Inc.
> - *  Copyright (c) 2010, 2012 The Linux Foundation. All rights reserved.
> + *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
>   *
>   *  Acknowledgements:
>   *  This file is based on hci_ll.c, which was...
> @@ -35,6 +35,11 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/serdev.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/device.h>

As I mentioned on v4, the includes should be in alphabetical order.

> +enum btqca_soc_t {

nit: Again, inconsistent naming, some functions/structs are called
qca_... other btqca_... Personally I prefer btqca_ to avoid clashes.

> +/*
> + * voltage regulator information required for configuring the
> + * QCA bluetooth chipset

nit: Voltage, Bluetooth

> + */
> +struct btqca_vreg {
> +	const char *name;
> +	unsigned int min_v;
> +	unsigned int max_v;
> +	unsigned int load_ua;
> +};

nit: consider min_uV, max_uV, load_uA (as in the regulator framework).

> +
> +struct btqca_vreg_data {
> +	enum btqca_soc_t soc_type;
> +	struct btqca_vreg *vregs;
> +	size_t num_vregs;
> +};
> +
> +/*
> + * Platform data for the QCA bluetooth power driver.

nit: Bluetooth

> +static int qca_send_vendor_cmd(struct hci_dev *hdev, u8 cmd)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
> +	struct sk_buff *skb;
> +
> +	BT_DBG("%s:sending command %02x to SoC", hdev->name, cmd);

bt_dev_dbg()

> +
> +	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> +	if (!skb) {
> +		BT_ERR("Failed to allocate memory for skb  packet");

bt_dev_err()

> +	/* Wait for 100 us for soc to settle down */

nit: uS, SoC

> +static int qca_serdev_open(struct hci_uart *hu)
> +{
> +	int ret = 0;
> +
> +	if (hu->serdev) {
> +		serdev_device_open(hu->serdev);
> +	} else {
> +		bt_dev_err(hu->hdev, "open operation not supported");
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}

>From v4:

> > Check return value.
> [Bala]: as we are not checking in qca_open, the return in this
> function is to know the serdev function availability.

Sorry, your comment didn't really clarify things for me. The function
is called from qca_setup() apparently with the intention to open the
serial port, not to check if the function is available. If the serial
port can't be opened for whatever reason the function should return an
error (typically a negative value).

Also the error message is misleading, the underlying problem is not
that the open operations is not supported, but that no serdev device
is associated with the hci_uart. Actually it seems this could never
happen:

In qca_serdev_probe():

  qcadev->serdev_hu.serdev = serdev;

And qca_serdev_open() is only called from qca_setup(). Basically the
first thing qca_setup() does is:

  qcadev = serdev_device_get_drvdata(hu->serdev);

Thus if hu->serdev is NULL qca_setup() will crash shortly after:

  switch (qcadev->btsoc_type) {

I think we can get rid of qca_serdev_open/close() and just call
directly serdev_device_open().

> +int qca_btsoc_cleanup(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +
> +	/* change host baud rate before sending power off command */
> +	host_set_baudrate(hu, 2400);
> +	/* send 0xC0 command to btsoc before turning off regulators */
> +	qca_send_vendor_cmd(hdev, CHEROKEE_POWEROFF_PULSE);

The comment doesn't provide any useful information. From the code it's
evident that a CHEROKEE_POWEROFF_PULSE is sent, if anybody is
interested in the hex code they can look up the definition of
CHEROKEE_POWEROFF_PULSE.

> +	/* turn off btsoc */
> +	return btqca_power_setup(false);

This comment laso doesn't provide any value.

> +static int qca_serdev_close(struct hci_uart *hu)
> +{
> +	int ret = 0;
> +
> +	if (hu->serdev) {
> +		serdev_device_close(hu->serdev);
> +	} else {
> +		bt_dev_err(hu->hdev, "close operation not supported");
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}

Same commants as for open().

Preferably keep open() and close() together, without squeezing the
cleanup function in between.

>  static int qca_setup(struct hci_uart *hu)
>  {
>  	struct hci_dev *hdev = hu->hdev;
>  	struct qca_data *qca = hu->priv;
> +	struct qca_serdev *qcadev;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>  	int ret;
> +	int soc_ver;
> +
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
> +
> +	switch (qcadev->btsoc_type) {
> +	case BTQCA_CHEROKEE:

I still thinks this is has a lot of common code with the default/Rome
case, but let's first clarify and possibly improve a few things.

> +		bt_dev_info(hdev, "setting up wcn3990");
> +		/* Patch downloading has to be done without IBS mode */
> +		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +		/* Setup initial baudrate */
> +		speed = 0;
> +		if (hu->init_speed)
> +			speed = hu->init_speed;
> +		else if (hu->proto->init_speed)
> +			speed = hu->proto->init_speed;

This pattern is repeated a several times for initial and operating
speeds. Helper functions like btqca_get_init_speed() and
btqca_get_oper_speed() would make the code more readable and compact.

> +
> +		if (speed) {
> +			host_set_baudrate(hu, speed);
> +		} else {
> +			bt_dev_err(hdev, "initial speed %u", speed);
> +			return -1;
> +		}

Note: Up to here Rome and Cherokee do exactly the same.

> +		/* disable flow control, as chip is still not turned on */
> +		hci_uart_set_flow_control(hu, true);
> +		/* send 0xFC  command to btsoc */
> +		ret = qca_send_vendor_cmd(hdev, CHEROKEE_POWERON_PULSE);

Delete useless comment.

> +		if (ret) {
> +			bt_dev_err(hdev, "Failed to send power on command");
> +			return ret;
> +		}
> +
> +		/* close serial port */
> +		ret = qca_serdev_close(hu);
> +		if (ret)
> +			return ret;
> +		/* open serial port */
> +		ret = qca_serdev_open(hu);
> +		if (ret)
> +			return ret;

The comments are pointless, it is evident from the code that the
serial port is opened/closed. Much more interesting would be to
explain why it is necessary to close and re-open the port.

> -	bt_dev_info(hdev, "ROME setup");
> +		/* Setup initial baudrate */
> +		speed = 0;
> +		if (hu->init_speed)
> +			speed = hu->init_speed;
> +		else if (hu->proto->init_speed)
> +			speed = hu->proto->init_speed;
> +		if (speed) {
> +			host_set_baudrate(hu, speed);
> +		} else {
> +			BT_ERR("%s:initial speed %u", hdev->name, speed);

bt_dev_err()

> +			return -1;
> +		}

The initial baudrate has already been set above, is it necessary to
configure it again because the port was closed?

This baudrate code is extremely noisy. Besides introducing the helper
functions mentioned above you could log the error message in
host_set_baudrate() or even have an addtional wrapper that determines
and sets the baudrate. The latter would reduce the above to:

if (xyz_set_baudrate(hu, INIT_RATE))
	return -1;

And that multiple times.

> +		/* clear flow control */
> +		hci_uart_set_flow_control(hu, true);
> +		/* set operating speed */

Note: Starting from here the code for Cherokee and Rome is essentially
the same, except for enabling flow control.

If you prefer keep the somewhat redundant code paths in the next
revision, but please consider the improvements I suggested. With less
noisy code it will be easier to determine if it is reasonable to join
the two code paths.

> +static int btqca_enable_regulators(int i, struct btqca_vreg *vregs)

The common convention is to pass first the structure a function acts
on, then other parameters.  Use a more expressive name for the
number of regulators, like 'num_regs' or 'nregs'.


> +{
> +	int ret = 0;

Initialization is not necessary, ret is assigned in the next line.

> +static void btqca_disable_regulators(int reg_nu, struct btqca_vreg *vregs)
> +{

Same as for the enable function. Please use the same name for the
argument with the number of regulators on both functions, personally I
don't think 'reg_nu' is a great choice, but that's just my opinion ;-)

> +int btqca_power_setup(bool on)
> +{
> +	int ret = 0;
> +	int i;
> +	struct btqca_vreg *vregs;
> +
> +	if (!qca || !qca->vreg_data || !qca->vreg_bulk)
> +		return -EINVAL;
> +	vregs = qca->vreg_data->vregs;
> +
> +	BT_DBG("on: %d", on);
> +	/* turn on if regualtors are off */

regulators

Consider dropping the comment, IMO the code speaks for itself.

> +	if (on == true && qca->vregs_on == false) {

if (on && !qca->vreg_on) {

> +		qca->vregs_on = true;

Typically you'd change the variable after having performed the
operation with success.

> +		for (i = 0; i < qca->vreg_data->num_vregs; i++) {
> +			ret = btqca_enable_regulators(i, vregs);
> +			if (ret)
> +				break;
> +		}
> +	} else if (on == false && qca->vregs_on == true) {

if (!on && qca->vreg_on) {

> +		qca->vregs_on = false;

Better done after having disabled the regulators.

> +		/* turn off regulator in reverse order */
> +		btqca_disable_regulators(qca->vreg_data->num_vregs, vregs);
> +	}
> +
> +	/* regulators failed */
> +	if (ret) {
> +		qca->vregs_on = false;
> +		BT_ERR("failed to enable regulator:%s", vregs[i].name);
> +		/* turn off regulators which are enabled */
> +		btqca_disable_regulators(i, vregs);
> +	}

Why not do this directly when the problem is detected? The code also
relies on 'ret' only being set in the 'on' path. Which isn't intuitive
for the reader and *might* change in the future.

> +
> +	return ret;
> +}
> +
> +static int init_regulators(struct btqca_power *qca,

Preferably keep use the same prefix (btqca_) consistently, unless
names become awfully long or otherwise unreadable.

>  static int qca_serdev_probe(struct serdev_device *serdev)
>  {
>	struct qca_serdev *qcadev;
>	const struct btqca_vreg_data *data;
> 	int err = 0;

unnecessary initialization

>		/* set voltage regulator status as false */
>		qca->vregs_on = false;

delete pointless comment

>		/* get operating speed */
>		device_property_read_u32(&serdev->dev, "oper-speed",

comment doesn't add much value

> +		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
> +		if (err) {
> +			BT_ERR("wcn3990 serdev registration failed");
> +			kfree(qca);
> +			goto out;

disable regulators

Thanks

Matthias
