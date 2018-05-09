Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 09 May 2018 15:37:34 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
 hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990.
In-Reply-To: <20180505011713.GE19594@google.com>
References: <1525448106-18616-1-git-send-email-bgodavar@codeaurora.org>
 <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
 <20180505011713.GE19594@google.com>
Message-ID: <595e02f711f40a104ed86b7eb06b28d7@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Please find my comments inline.

On 2018-05-05 06:47, Matthias Kaehlcke wrote:
> Hi,
> 
> On Fri, May 04, 2018 at 09:05:05PM +0530, Balakrishna Godavarthi wrote:
>> Add support to set voltage/current of various regulators
>> to power up/down Bluetooth chip wcn3990.
>> Add support to read baudrate from dts.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 555 
>> ++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 483 insertions(+), 72 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f05382b..075fab7 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -5,7 +5,7 @@
>>   *  protocol extension to H4.
>>   *
>>   *  Copyright (C) 2007 Texas Instruments, Inc.
>> - *  Copyright (c) 2010, 2012 The Linux Foundation. All rights 
>> reserved.
>> + *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights 
>> reserved.
>>   *
>>   *  Acknowledgements:
>>   *  This file is based on hci_ll.c, which was...
>> @@ -35,6 +35,10 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/module.h>
>>  #include <linux/serdev.h>
>> +#include <asm-generic/delay.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/of_device.h>
> 
> AFAIK the convention is to order includes alphabetically.
   [Bala]: will update.
> 
>> +static struct btqca_power *qca;
> 
> This limits the driver to a single instance. This is probably the most
> common use case, but in general it's preferable not to have this kind
> of limitations.

   [Bala]: yes, we need for one instance when the driver got probed.

> 
>>  static void __serial_clock_on(struct tty_struct *tty)
>>  {
>>  	/* TODO: Some chipset requires to enable UART clock on client
>> @@ -463,7 +506,12 @@ static int qca_open(struct hci_uart *hu)
>>  		serdev_device_open(hu->serdev);
>> 
>>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> -		gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> +		if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
>> +			hu->init_speed = qcadev->init_speed;
>> +			hu->oper_speed = qcadev->oper_speed;
>> +			btqca_power_setup(true);
>> +		} else
>> +			gpiod_set_value_cansleep(qcadev->bt_en, 1);
> 
> Use curly braces for the else branch too.
[Bala]: will update.
> 
>> +static int qca_send_poweron_cmd(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +	struct qca_data *qca = hu->priv;
>> +	struct sk_buff *skb;
>> +	u8 cmd;
>> +
>> +	BT_DBG("%s sending power on command to btsoc", hdev->name);
> 
> Use bt_dev_dbg(), same for other BT_XXX().
> 
>> +	/* By sending 0xFC host is trying to power up the soc */
> 
> nit: SoC, same a few lines below.
> 
>> +	cmd = CHEROKEE_POWERON_PULSE;
>> +	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
> 
> Use GFP_KERNEL, the code sleeps a few lines below, hence it must
> definitely not be called in atomic context.

[Bala]: will update.

> 
>> +	if (!skb) {
>> +		BT_ERR("Failed to allocate memory for skb  packet");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	skb_put_data(skb, &cmd, sizeof(cmd));
>> +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> +
>> +	skb_queue_tail(&qca->txq, skb);
>> +	hci_uart_tx_wakeup(hu);
>> +
>> +	/* Wait for 100 us for soc to settle down */
>> +	set_current_state(TASK_UNINTERRUPTIBLE);
>> +	schedule_timeout(usecs_to_jiffies(100));
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qca_send_poweroff_cmd(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +	struct qca_data *qca = hu->priv;
>> +	struct sk_buff *skb;
>> +	u8 cmd;
>> +
>> +	BT_DBG("%s sending power off command to btsoc", hdev->name);
>> +	/* By sending 0xC0 host is trying to power off the soc */
>> +	cmd = CHEROKEE_POWEROFF_PULSE;
>> +	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
>> +	if (!skb) {
>> +		BT_ERR("Failed to allocate memory for skb  packet");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	skb_put_data(skb, &cmd, sizeof(cmd));
>> +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> +
>> +	skb_queue_tail(&qca->txq, skb);
>> +	hci_uart_tx_wakeup(hu);
>> +
>> +	/* Wait for 100 us for soc to settle down */
>> +	set_current_state(TASK_UNINTERRUPTIBLE);
>> +	schedule_timeout(usecs_to_jiffies(100));
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +	return 0;
>> +}
> 
> This function is almost a clone of qca_send_poweron_cmd(), move the
> common code to something like qca_send_cmd() and call it from
> qca_send_poweron/off_cmd().

[Bala]: will create on function for both ON and OFF.

> 
>> +static int qca_serdev_open(struct hci_uart *hu)
>> +{
>> +	int ret = 0;
>> +
>> +	if (hu->serdev)
>> +		serdev_device_open(hu->serdev);
> 
> Check return value.
[Bala]: as we are not checking in qca_open, the return in this function 
is to know the serdev function availability.

> 
> Add curly braces to the if branch too.
[Bala]: will update.
> 
>> +static int qca_serdev_close(struct hci_uart *hu)
>> +{
>> +	int ret = 0;
>> +
>> +	if (hu->serdev)
>> +		serdev_device_close(hu->serdev);
> 
> Add curly braces to the if branch too.
[Bala]: will update.
> 
>>  static int qca_setup(struct hci_uart *hu)
>>  {
>>  	struct hci_dev *hdev = hu->hdev;
>>  	struct qca_data *qca = hu->priv;
>> +	struct qca_serdev *qcadev;
>>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>>  	int ret;
>> +	int soc_ver;
>> +
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +
>> +	switch (qcadev->btsoc_type) {
>> +	case BTQCA_CHEROKEE:
>> +		bt_dev_info(hdev, "setting up wcn3990");
>> +		/* Patch downloading has to be done without IBS mode */
>> +		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +		/* Setup initial baudrate */
>> +		speed = 0;
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +
>> +		if (speed)
>> +			host_set_baudrate(hu, speed);
> 
> Add curly braces.
[Bala]: will update.
> 
>> +		else {
>> +			bt_dev_err(hdev, "initial speed %u", speed);
>> +			return -1;
>> +		}
>> 
>> -	bt_dev_info(hdev, "ROME setup");
>> +		/* disable flow control, as chip is still not turned on */
>> +		hci_uart_set_flow_control(hu, true);
> 
> The interface of this function is confusing. enable = true disables
> flow control ... Not the fault of this driver though :)
[Bala]: yes it is bit confusing. i taught to update.. but not sure of 
impact.
         so instead of updating, using the same function and written a 
comment above.

> 
>> +		/* send poweron command to btsoc */
>> +		ret = qca_send_poweron_cmd(hdev);
>> +		if (ret) {
>> +			bt_dev_err(hdev, "Failed to send power on command");
>> +			return ret;
>> +		}
>> 
>> -	/* Patch downloading has to be done without IBS mode */
>> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +		/* close serial port */
>> +		ret = qca_serdev_close(hu);
>> +		if (ret)
>> +			return ret;
>> +		/* open serial port */
>> +		ret = qca_serdev_open(hu);
>> +		if (ret)
>> +			return ret;
>> 
>> -	/* Setup initial baudrate */
>> -	speed = 0;
>> -	if (hu->init_speed)
>> -		speed = hu->init_speed;
>> -	else if (hu->proto->init_speed)
>> -		speed = hu->proto->init_speed;
>> +		/* Setup initial baudrate */
>> +		speed = 0;
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +		if (speed)
>> +			host_set_baudrate(hu, speed);
> 
> Add curly braces.

[Bala]: will update.

> 
>> +		else {
>> +			BT_ERR("%s:initial speed %u", hdev->name, speed);
>> +			return -1;
>> +		}
>> 
>> -	if (speed)
>> -		host_set_baudrate(hu, speed);
>> +		/* Enable flow control */
>> +		hci_uart_set_flow_control(hu, false);
>> +		/*  wait until flow control settled */
>> +		mdelay(100);
> 
> A busy wait of 100ms doesn't seem a good idea. Use msleep()
> instead. Is it really necessary to wait that long?
[Bala]: yes this delay is required for BT Soc to bootup and settle down.

> 
>> +		bt_dev_info(hdev, "wcn3990 Patch Version Request");
>> +		ret = rome_patch_ver_req(hdev, &soc_ver);
>> +		if (ret < 0 || soc_ver == 0) {
>> +			BT_ERR("%s: Failed to get version 0x%x", hdev->name,
>> +				ret);
>> +			return ret;
>> +		}
>> 
>> -	/* Setup user speed if needed */
>> -	speed = 0;
>> -	if (hu->oper_speed)
>> -		speed = hu->oper_speed;
>> -	else if (hu->proto->oper_speed)
>> -		speed = hu->proto->oper_speed;
>> +		bt_dev_info(hdev, "wcn3990 controller version 0x%08x", soc_ver);
>> +
>> +		/* clear flow control */
>> +		hci_uart_set_flow_control(hu, true);
>> +		/* set operating speed */
>> +		speed = 0;
>> +		if (hu->oper_speed)
>> +			speed = hu->oper_speed;
>> +		else if (hu->proto->oper_speed)
>> +			speed = hu->proto->oper_speed;
>> +		if (speed) {
>> +			qca_baudrate = qca_get_baudrate_value(speed);
>> +			bt_dev_info(hdev, "Set UART speed to %d", speed);
>> +			ret = qca_set_baudrate(hdev, qca_baudrate);
>> +			if (ret) {
>> +				BT_ERR("%s:Failed to change the baud rate(%d)",
>> +					hdev->name, ret);
>> +				return ret;
>> +			}
>> +			if (speed)
>> +				host_set_baudrate(hu, speed);
> 
> Add curly braces.
[Bala]: will update.
> 
>> +			else {
>> +				BT_ERR("%s:Error in setting operator speed:%u",
>> +					hdev->name, speed);
>> +				return -1;
>> +			}
>> +		}
>> 
>> -	if (speed) {
>> -		qca_baudrate = qca_get_baudrate_value(speed);
>> +		/* Set flow control */
>> +		hci_uart_set_flow_control(hu, false);
>> +		/*Setup patch and  NVM configurations */
> 
> Add blank before 'Setup' and remove one before 'NVM'.
[Bala]: will update.
> 
>> +		ret = qca_uart_setup_cherokee(hdev, qca_baudrate, &soc_ver);
>> +		if (!ret) {
>> +			set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +			qca_debugfs_init(hdev);
>> +		} else if (ret == -ENOENT) {
>> +			/* No patch/nvm-config found, run with original
>> +			 * fw/config.
>> +			 */
>> +			ret = 0;
>> +		} else if (ret == -EAGAIN) {
>> +			/*
>> +			 * Userspace firmware loader will return -EAGAIN in
>> +			 * case no patch/nvm-config is found, so run with
>> +			 * original fw/config.
>> +			 */
>> +			ret = 0;
>> +		}
>> 
>> -		bt_dev_info(hdev, "Set UART speed to %d", speed);
>> -		ret = qca_set_baudrate(hdev, qca_baudrate);
>> -		if (ret) {
>> -			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
>> -				   ret);
>> +		/* Setup wcn3990 bdaddr */
>> +		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
>> +
>> +		return ret;
>> +
>> +	default:
> 
> What follows looks similar to the Cherokee path. I didn't look at all
> the details, but it's probably possible to share some more code.
[Bala]: yes these are two different chip.
         we also have difference in setup. the follwing are major 
differences
         Cherokee uses flow control. where ROME flow control is disabled.
         ON sequence also varies.
> 
>> +		bt_dev_info(hdev, "ROME setup");
>> +
>> +		/* Patch downloading has to be done without IBS mode */
>> +		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +
>> +		/* Setup initial baudrate */
>> +		speed = 0;
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +
>> +		if (speed)
>> +			host_set_baudrate(hu, speed);
>> +
>> +		/* Setup user speed if needed */
>> +		speed = 0;
>> +		if (hu->oper_speed)
>> +			speed = hu->oper_speed;
>> +		else if (hu->proto->oper_speed)
>> +			speed = hu->proto->oper_speed;
>> +
>> +		if (speed) {
>> +			qca_baudrate = qca_get_baudrate_value(speed);
>> +
>> +			bt_dev_info(hdev, "Set UART speed to %d", speed);
>> +			ret = qca_set_baudrate(hdev, qca_baudrate);
>> +			if (ret) {
>> +				bt_dev_err(hdev, "Failed to change the baud rate (%d)",
>> +					   ret);
>>  			return ret;
> 
> Fix indentation.
[Bala]: will update.
> 
>> +static const struct btqca_vreg_data cherokee_data = {
>> +	.soc_type = BTQCA_CHEROKEE,
>> +	.vregs = (struct btqca_vreg []) {
>> +		{ "vddio",   1352000, 1352000,  0 },
>> +		{ "vddxtal", 1904000, 2040000,  0 },
>> +		{ "vddcore", 1800000, 1800000,  1 },
>> +		{ "vddpa",   130400,  1304000,  1 },
> 
> 0 missing for min_v?

[Bala]: min_v is  the minimum voltage required for BT chip.

> 
>> +		{ "vddldo",  3000000, 3312000,  1 },
>> +	},
>> +	.num_vregs = 5,
>> +};
>> +
>> +void btqca_disable_regulators(int reg_nu, struct btqca_vreg *vregs)
>> +{
>> +	/* disable the regulator if requested by user
>> +	 * or when fault in any regulator.
>> +	 */
>> +	for (reg_nu = reg_nu - 1; reg_nu >= 0 ; reg_nu--) {
> 
> Better use a local variable for iteration instead of the function 
> parameter

[Bala]: will update.

> 
>> +int btqca_power_setup(bool on)
>> +{
>> +	int ret = 0;
>> +	int i;
>> +	struct btqca_vreg *vregs;
>> +
>> +	if (!qca || !qca->vreg_data || !qca->vreg_bulk)
>> +		return -EINVAL;
>> +	vregs = qca->vreg_data->vregs;
>> +
>> +	BT_DBG("on: %d", on);
>> +	/* turn on if regualtors are off */
>> +	if (on == true && qca->vreg_status == false) {
> 
> if (on && !qca->vreg_status)
> 
> You might also consider a more expressive name instead of vreg_status,
> something like vregs_on.
[Bala]: will update.
> 
>> +		qca->vreg_status = true;
>> +		for (i = 0; ret == 0 && i < qca->vreg_data->num_vregs; i++) {
> 
> Better check ret inline and break when an error is encountered
[Bala]: will update.
> 
>> +			regulator_set_voltage(qca->vreg_bulk[i].consumer,
>> +					      vregs[i].min_v,
>> +					      vregs[i].max_v);
> 
> Check return value.
[Bala]: i am checking the status for regulator enable
         do we really require to check the status. as this same 
regulators are used by different sub systems.
         we will get an error during regulator enable when voltages are 
not settled down.
> 
>> +
>> +			if (vregs[i].load_ua)
>> +				regulator_set_load(qca->vreg_bulk[i].consumer,
>> +						   vregs[i].load_ua);
> 
> Check return value.

> 
>> +			ret = regulator_enable(qca->vreg_bulk[i].consumer);
>> +	}
> 
> Fix indentation.
[Bala]: will update.
> 
>> +	} else if (on == false && qca->vreg_status == true) {
> 
> (!on && qca->vreg_status)
> 
>> +		qca->vreg_status = false;
>> +		/* turn of regualtor in reverse order */
> 
> 'off, regulator'
[Bala]: will update.
> 
>> +		btqca_disable_regulators(qca->vreg_data->num_vregs, vregs);
>> +	}
>> +
>> +	/* regulatos fails to enable */
> 
> 'regulators failed'
[Bala]: will update.

> 
>> +	if (ret) {
>> +		qca->vreg_status = false;
>> +		BT_ERR("failed to enable regualtor:%s", vregs[i].name);
> 
> 'regulator'
> 
>> +		/* set regulator voltage and load to zero */
>> +		regulator_set_voltage(qca->vreg_bulk[i].consumer,
>> +				      0, vregs[i].max_v);
> 
> check return value.
> 
>>  static int qca_serdev_probe(struct serdev_device *serdev)
>>  {
>>  	struct qca_serdev *qcadev;
>> -	int err;
>> +	const struct btqca_vreg_data *data;
>> +	int err = 0;
>> 
>>  	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
>>  	if (!qcadev)
>>  		return -ENOMEM;
>> 
>>  	qcadev->serdev_hu.serdev = serdev;
>> +	data = of_device_get_match_data(&serdev->dev);
>> +	if (data && data->soc_type == BTQCA_CHEROKEE)
>> +		qcadev->btsoc_type = BTQCA_CHEROKEE;
>> +	else
>> +		qcadev->btsoc_type = BTQCA_ROME;
>> +
>>  	serdev_device_set_drvdata(serdev, qcadev);
>> +	if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
>> +		qca = kzalloc(sizeof(struct btqca_power), GFP_KERNEL);
> 
> Use devm_kzalloc()
[Bala]: will update.
> 
>> +		if (!qca)
>> +			return -ENOMEM;
>> +
>> +		qca->dev = &serdev->dev;
>> +		qca->vreg_data = data;
>> +		err = init_regulators(qca, data->vregs, data->num_vregs);
>> +		if (err) {
>> +			BT_ERR("Failed to init regualtors:%d", err);
> 
> 'regulators'
[Bala]: will update.
> 
>> +			kfree(qca);
>> +			goto out;
>> +		}
>> 
>> -	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
>> -				       GPIOD_OUT_LOW);
>> -	if (IS_ERR(qcadev->bt_en)) {
>> -		dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> -		return PTR_ERR(qcadev->bt_en);
>> -	}
>> +		/* set voltage regulator status as false */
>> +		qca->vreg_status = false;
>> +		/* get operating speed */
>> +		device_property_read_u32(&serdev->dev, "oper-speed",
>> +					 &qcadev->oper_speed);
>> +		device_property_read_u32(&serdev->dev, "init-speed",
>> +					 &qcadev->init_speed);
>> +		if (!qcadev->oper_speed)
>> +			BT_INFO("DTS entry for operating speed is
>> -				       disabled");
> 
> The message isn't very clear. The entry isn't disabled, it doesn't 
> exist.
[Bala]: will update.
> 
>>  static void qca_serdev_remove(struct serdev_device *serdev)
>> @@ -1047,12 +1454,16 @@ static void qca_serdev_remove(struct 
>> serdev_device *serdev)
>>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>> 
>>  	hci_uart_unregister_device(&qcadev->serdev_hu);
>> -
>> -	clk_disable_unprepare(qcadev->susclk);
>> +	if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
>> +		btqca_power_setup(false);
>> +		kfree(qca);
>> +	} else
>> +		clk_disable_unprepare(qcadev->susclk);
> 
> Add curly braces.
[Bala]: will update.


Thanks for code review. will send a updated patch with the changes.

-- 
Regards
Balakrishna.
