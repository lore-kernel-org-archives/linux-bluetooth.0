Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 04 Jun 2018 20:44:19 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
 hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 5/5] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990.
In-Reply-To: <20180529174130.GD168650@google.com>
References: <20180524160051.29966-1-bgodavar@codeaurora.org>
 <20180524160051.29966-6-bgodavar@codeaurora.org>
 <20180529174130.GD168650@google.com>
Message-ID: <71b5a4c480ac0e415670ec7ff01387f6@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

HI Matthias,

Pls find my comments inline.

On 2018-05-29 23:11, Matthias Kaehlcke wrote:
> On Thu, May 24, 2018 at 09:30:51PM +0530, Balakrishna Godavarthi wrote:
>> Add support to set voltage/current of various regulators
>> to power up/down Bluetooth chip wcn3990.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> 
>> Changes in v6:
>> 	* Hooked up qca_power to qca_serdev.
>> 	* renamed all the naming inconsistency functions with qca_*
>> 	* leveraged common code of ROME for wcn3990.
>> 	* created wrapper functions for re-usable blocks.
>> 	* updated function of _*regulator_enable and _*regualtor_disable.
>> 	* removed redundant comments and functions.
>> 	* addressed review comments.
>> 
>> Changes in v5:
>> 	* updated regulator vddpa min_uV to 1304000.
>>   	* addressed review comments.
>> 
>> Changes in v4:
>> 	* Segregated the changes of btqca from hci_qca
>> 	* rebased all changes on top of bluetooth-next.
>> 	* addressed review comments.
>> ---
>> 
>> ...
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index cb1034998040..e235be0e5202 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> ...
>> +static void qca_set_init_speed(struct hci_uart *hu)
>> +{
>> +	unsigned int speed = 0;
>> 
>> -	/* Setup initial baudrate */
>> -	speed = 0;
>>  	if (hu->init_speed)
>>  		speed = hu->init_speed;
>>  	else if (hu->proto->init_speed)
>> @@ -946,29 +1015,136 @@ static int qca_setup(struct hci_uart *hu)
>> 
>>  	if (speed)
>>  		host_set_baudrate(hu, speed);
>> +}
>> +
>> +static int qca_set_operating_speed(struct hci_uart *hu, u32 
>> *qca_baudrate)
>> +{
> 
> This is a bit convoluted, with the function setting the speed and
> returning it. I would suggest a qca_get_oper_speed() and
> qca_get_init_speed(), and just have them return the value instead of
> passing it through a pointer. You could then have a qca_set_speed()
> which converts the baudrate to the value the chip understands, calls
> qca_set_baudrate() and host_set_baudrate()
> 

[Bala]: will update.

>> +static int qca_setup(struct hci_uart *hu)
>> +{
>> +	struct hci_dev *hdev = hu->hdev;
>> +	struct qca_data *qca = hu->priv;
>> +	struct qca_serdev *qcadev;
>> +	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>> +	int ret;
>> +	int soc_ver;
>> +
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +
>> +	switch (qcadev->btsoc_type) {
>> +	case BTQCA_CHEROKEE:
>> +		bt_dev_dbg(hdev, "setting up wcn3990");
>> +		/* Patch downloading has to be done without IBS mode */
>> +		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +		qca_set_init_speed(hu);
>> +		hci_uart_set_flow_control(hu, true);
>> +		ret = qca_send_vendor_cmd(hdev, CHEROKEE_POWERON_PULSE);
>> +		if (ret) {
>> +			bt_dev_err(hdev, "failed to send power on command");
>> +			return ret;
>> +		}
>> +
>> +		/* Close and re-open the port */
> 
> As mentioned earlier, this comment doesn't provide any useful
> information, it's evident from the code. Rather explain *why* the
> close/open is needed.
> 
>> +		serdev_device_close(hu->serdev);
>> +		ret = serdev_device_open(hu->serdev);
>> +		if (ret) {
>> +			bt_dev_err(hdev, "failed to open port");
>> +			return ret;
>> +		}
>> +
>> +		qca_set_init_speed(hu);
>> +		hci_uart_set_flow_control(hu, false);
>> +		msleep(100);
> 
> Which step makes the delay necessary? I guess it's not enabling flow
> control but probably sending the power on command. If that is correct
> the delay should be done after the corresponding command.
> 
>> +		ret = qca_patch_ver_req(hdev, &soc_ver);
>> +		if (ret < 0 || soc_ver == 0) {
>> +			bt_dev_err(hdev, "Failed to get version 0x%x", ret);
> 
> Probably better: "Failed to get version: %d" since ret contains an
> errno and the problem wasn't that we couldn't get "version 0x<errno>".
> 
>> +			return ret;
>> +		}
>> +
>> +		bt_dev_info(hdev, "wcn3990 controller version 0x%08x", soc_ver);
>> +		hci_uart_set_flow_control(hu, true);
> 
> Repeatedly switching on and off of flow control is a bit noisy, I
> wonder if it could be hidden in a wrapper. From the code it seems that
> flow control is disabled (true) for init speed and and enabled (false)
> for operating speed. If this is correct the hci_uart_set_flow_control()
> calls could be moved inside qca_set_oper/init_speed(). struct 
> qca_serdev
> could have a flag indicating if flow control is supported at all to
> skip the hci_uart_set_flow_control() calls for Rome.
> 
> Just an idea, no objections if you prefer to leave it as is and Marcel
> is ok with it.
> 

[Bala]: will update.

>> +		ret = qca_set_operating_speed(hu, &qca_baudrate);
>> +		if (ret)
>> +			return ret;
>> +		hci_uart_set_flow_control(hu, false);
>> +		/* Setup patch and NVM configurations */
>> +		ret = qca_uart_setup_cherokee(hdev, qca_baudrate, &soc_ver);
>> +
>> +		break;
>> +
>> +	default:
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
> 
> If you introduce helpers to determine the init/oper speed these should
> also be used here. Probably best to do this in a separate patch.
> 

[Bala]: will update ROME related stuff in other patch.

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
> 
> ditto
> 

[Bala]: will update.

>> +static void qca_disable_regulator(struct qca_vreg vregs,
>> +				  struct regulator *regulator)
>> +{
>> +	/* Disable the regulator if requested by user
>> +	 * or when fault to enable any regulator.
>> +	 */
> 
> This comment is not useful. The following code simply disables the
> regulator, why this is done is a question of the caller.
> 

[Bala]: will update.

>> +	regulator_disable(regulator);
>> +	regulator_set_voltage(regulator, 0, vregs.max_uV);
>> +	if (vregs.load_uA)
>> +		regulator_set_load(regulator, 0);
>> +
>> +}
>> +
>> +int qca_btsoc_power_setup(struct hci_uart *hu, bool on)
>> +{
>> +	struct qca_vreg *vregs;
>> +	struct regulator_bulk_data *vreg_bulk;
>> +	struct qca_serdev *qcadev;
>> +	int i, num_vregs, ret = 0;
>> +
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +	if (!qcadev || !qcadev->bt_power || !qcadev->bt_power->vreg_data ||
>> +	    !qcadev->bt_power->vreg_bulk)
>> +		return -EINVAL;
>> +
>> +	vregs = qcadev->bt_power->vreg_data->vregs;
>> +	vreg_bulk = qcadev->bt_power->vreg_bulk;
>> +	num_vregs = qcadev->bt_power->vreg_data->num_vregs;
>> +	BT_DBG("on: %d", on);
>> +	if (on  && !qcadev->bt_power->vregs_on) {
>> +		for (i = 0; i < num_vregs; i++) {
>> +			ret = qca_enable_regulator(vregs[i],
>> +						   vreg_bulk[i].consumer);
>> +			if (ret)
>> +				break;
>> +		}
>> +		/* regulators failed */
> 
> Comment is not useful, BT_ERR below leaves things clear.
[Bala]: will update.

> 
>> +		if (ret) {
>> +			BT_ERR("failed to enable regulator:%s", vregs[i].name);
>> +			/* turn off regulators which are enabled */
>> +			for (i = i - 1; i >= 0; i--)
>> +				qca_disable_regulator(vregs[i],
>> +						      vreg_bulk[i].consumer);
>> +		} else {
>> +			qcadev->bt_power->vregs_on = true;
>> +		}
>> +	} else if (!on && qcadev->bt_power->vregs_on) {
>> +		/* turn off regulator in reverse order */
>> +		i = qcadev->bt_power->vreg_data->num_vregs - 1;
>> +		for ( ; i >= 0; i--)
>> +			qca_disable_regulator(vregs[i], vreg_bulk[i].consumer);
>> +		qcadev->bt_power->vregs_on = false;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int qca_init_regulators(struct qca_power *qca,
>> +			       const struct qca_vreg *vregs, size_t num_vregs)
>> +{
>> +	int i;
>> +
>> +	qca->vreg_bulk = devm_kzalloc(qca->dev, num_vregs *
>> +				      sizeof(struct regulator_bulk_data),
>> +				      GFP_KERNEL);
>> +	if (!qca->vreg_bulk)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num_vregs; i++)
>> +		qca->vreg_bulk[i].supply = vregs[i].name;
>> +
>> +	return devm_regulator_bulk_get(qca->dev, num_vregs, qca->vreg_bulk);
>> +}
>> +
>>  static int qca_serdev_probe(struct serdev_device *serdev)
>>  {
>>  	struct qca_serdev *qcadev;
>> +	const struct qca_vreg_data *data;
>>  	int err;
>> 
>>  	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
>> @@ -1014,34 +1301,72 @@ static int qca_serdev_probe(struct 
>> serdev_device *serdev)
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
>> +		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>> +						sizeof(struct qca_power),
>> +						GFP_KERNEL);
>> +		if (!qcadev->bt_power)
>> +			return -ENOMEM;
>> +
>> +		qcadev->bt_power->dev = &serdev->dev;
>> +		qcadev->bt_power->vreg_data = data;
>> +		err = qca_init_regulators(qcadev->bt_power, data->vregs,
>> +					  data->num_vregs);
>> +		if (err) {
>> +			BT_ERR("Failed to init regulators:%d", err);
>> +			devm_kfree(&serdev->dev, qcadev->bt_power->vreg_bulk);
>> +			devm_kfree(&serdev->dev, qcadev->bt_power);
> 
> Not necessary, the memory is allocated with devm_kzalloc(&serdev->dev,
> ...), therefore it is freed if probe() fails.

[Bala]: will update.

> 
>> +			goto out;
>> +		}
>> 
>> -	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
>> -				       GPIOD_OUT_LOW);
>> -	if (IS_ERR(qcadev->bt_en)) {
>> -		dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> -		return PTR_ERR(qcadev->bt_en);
>> -	}
>> +		qcadev->bt_power->vregs_on = false;
>> +		device_property_read_u32(&serdev->dev, "max-speed",
>> +					 &qcadev->oper_speed);
>> +		if (!qcadev->oper_speed)
>> +			BT_INFO("UART will pick default operating speed");
>> +		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>> +		if (err) {
>> +			BT_ERR("wcn3990 serdev registration failed");
>> +			devm_kfree(&serdev->dev, qcadev->bt_power->vreg_bulk);
>> +			devm_kfree(&serdev->dev, qcadev->bt_power);
> 
> no need to free memory.

[Bala]: will update.

> 
>> +			goto out;
>> +		}
>> +	} else {
>> +		qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
>> +					       GPIOD_OUT_LOW);
>> +		if (IS_ERR(qcadev->bt_en)) {
>> +			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> +			return PTR_ERR(qcadev->bt_en);
>> +		}
>> 
>> -	qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
>> -	if (IS_ERR(qcadev->susclk)) {
>> -		dev_err(&serdev->dev, "failed to acquire clk\n");
>> -		return PTR_ERR(qcadev->susclk);
>> -	}
>> +		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
>> +		if (IS_ERR(qcadev->susclk)) {
>> +			dev_err(&serdev->dev, "failed to acquire clk\n");
>> +			return PTR_ERR(qcadev->susclk);
>> +		}
>> 
>> -	err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
>> -	if (err)
>> -		return err;
>> +		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
>> +		if (err)
>> +			return err;
>> 
>> -	err = clk_prepare_enable(qcadev->susclk);
>> -	if (err)
>> -		return err;
>> +		err = clk_prepare_enable(qcadev->susclk);
>> +		if (err)
>> +			return err;
>> 
>> -	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>> -	if (err)
>> -		clk_disable_unprepare(qcadev->susclk);
>> +		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>> +		if (err)
>> +			clk_disable_unprepare(qcadev->susclk);
>> +	}
>> +
>> +out:	return err;
>> 
>> -	return err;
>>  }
>> 
>>  static void qca_serdev_remove(struct serdev_device *serdev)
>> @@ -1050,11 +1375,17 @@ static void qca_serdev_remove(struct 
>> serdev_device *serdev)
>> 
>>  	hci_uart_unregister_device(&qcadev->serdev_hu);
>> 
>> -	clk_disable_unprepare(qcadev->susclk);
>> +	if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
>> +		devm_kfree(&serdev->dev, qcadev->bt_power->vreg_bulk);
>> +		devm_kfree(&serdev->dev, qcadev->bt_power);
> 
> no need to free memory

[Bala]: will update.

Thanks for reviewing will update the about comments in next patch set.


-- 
Regards
Balakrishna.
