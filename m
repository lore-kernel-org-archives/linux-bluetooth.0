Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 21 Jun 2018 19:30:25 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 8/8] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180619215302.GF169030@google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-9-bgodavar@codeaurora.org>
 <20180619215302.GF169030@google.com>
Message-ID: <2055c231f8a955f48ef3159c35ab929e@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-06-20 03:23, Matthias Kaehlcke wrote:
> On Sat, Jun 16, 2018 at 11:57:18AM +0530, Balakrishna Godavarthi wrote:
>> Add support to set voltage/current of various regulators
>> to power up/down Bluetooth chip wcn3990.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 28ae6a17a595..1961e313aae7 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -402,6 +441,7 @@ static int qca_open(struct hci_uart *hu)
>>  {
>>  	struct qca_serdev *qcadev;
>>  	struct qca_data *qca;
>> +	int ret = 0;
>> 
>>  	BT_DBG("hu %p qca_open", hu);
>> 
>> @@ -463,13 +503,19 @@ static int qca_open(struct hci_uart *hu)
>>  		serdev_device_open(hu->serdev);
>> 
>>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> -		gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> +		if (qcadev->btsoc_type == QCA_WCN3990) {
>> +			hu->init_speed = qcadev->init_speed;
>> +			hu->oper_speed = qcadev->oper_speed;
>> +			ret = qca_btsoc_power_setup(hu, true);
> 
> Better do this before starting the timers, otherwise you need to take
> care of stopping them in case of failure.
> 
> If qca_btsoc_power_setup() fails you also have to free
> 'qca->workqueue' and 'qca'.
> 

[Bala]: i missed this.will update

>> +static int qca_send_vendor_cmd(struct hci_dev *hdev, u8 cmd)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +	struct qca_data *qca = hu->priv;
>> +	struct sk_buff *skb;
>> +
>> +	bt_dev_dbg(hdev, "sending command %02x to SoC", cmd);
>> +
>> +	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> +	if (!skb) {
>> +		bt_dev_err(hdev, "Failed to allocate memory for skb packet");
> 
> I was told that custom OOM messages should not be used, since the
> mm code will complain loudly in this case.
> 
>> +static int qca_btsoc_shutdown(struct hci_uart *hu)
> 
> The return value is not evaluated by the only caller, so this should
> probably be void.
> 

[Bala]: will update

>>  static int qca_setup(struct hci_uart *hu)
>>  {
>>  	struct hci_dev *hdev = hu->hdev;
>>  	struct qca_data *qca = hu->priv;
>> +	struct qca_serdev *qcadev;
>>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>>  	int ret;
>>  	int soc_ver = 0;
>> 
>> -	bt_dev_info(hdev, "ROME setup");
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> 
>>  	/* Patch downloading has to be done without IBS mode */
>>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> -
>> -	/* Setup initial baudrate */
>>  	qca_set_init_speed(hu);
>> +
>> +	if (qcadev->btsoc_type == QCA_WCN3990) {
>> +		bt_dev_dbg(hdev, "setting up wcn3990");
>> +		hci_uart_set_flow_control(hu, true);
>> +		ret = qca_send_vendor_cmd(hdev, CHEROKEE_POWERON_PULSE);
>> +		if (ret) {
>> +			bt_dev_err(hdev, "failed to send power on command");
>> +			return ret;
>> +		}
>> +		serdev_device_close(hu->serdev);
>> +		ret = serdev_device_open(hu->serdev);
>> +		if (ret) {
>> +			bt_dev_err(hdev, "failed to open port");
>> +			return ret;
>> +		}
>> +		msleep(100);
>> +		qca_set_init_speed(hu);
>> +		hci_uart_set_flow_control(hu, false);
>> +		ret = qca_read_soc_version(hdev, &soc_ver);
>> +		if (ret < 0 || soc_ver == 0) {
>> +			bt_dev_err(hdev, "Failed to get version %d", ret);
> 
> serdev_device_close() ?
> 
> Also applies to other error paths in this function.
> 
[Bala]: sorry, i didn't get you.

>>  static int qca_serdev_probe(struct serdev_device *serdev)
>>  {
>>  	struct qca_serdev *qcadev;
>> +	const struct qca_vreg_data *data;
>>  	int err;
>> 
>>  	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
>> @@ -1041,47 +1264,85 @@ static int qca_serdev_probe(struct 
>> serdev_device *serdev)
>>  		return -ENOMEM;
>> 
>>  	qcadev->serdev_hu.serdev = serdev;
>> +	data = of_device_get_match_data(&serdev->dev);
>> +	if (data && data->soc_type == QCA_WCN3990)
>> +		qcadev->btsoc_type = QCA_WCN3990;
>> +	else
>> +		qcadev->btsoc_type = QCA_ROME;
>> +
>>  	serdev_device_set_drvdata(serdev, qcadev);
>> +	if (qcadev->btsoc_type == QCA_WCN3990) {
> 
> nit: the double "if (soc_type == QCA_WCN3990)" is a bit odd. Consider
> changing this condition to "if (data && data->soc_type == QCA_WCN3990)"
> and assign qcadev->btsoc_type in the corresponding branch.

[bala]: will update.

I have idea of removing flow control from qca_setup() and use them in 
qca_set_speed()
"i need to disable hardware flow control when sending change baudrate 
request to WCN3990.
enabling it after setting host baudrate. this is only for wcn3990.
"

static int qca_set_speed(struct hci_uart *hu, unsigned int speed,
                          enum qca_speed_type speed_type,
                          enum qca_btsoc_type soc_type)
{
         unsigned int qca_baudrate;
         int ret;

         if (speed_type == QCA_INIT_SPEED)
                 goto change_host_baudrate;

         if (soc_type == QCA_WCN3990)
                 hci_uart_set_flow_control(hu, true);

         qca_baudrate = qca_get_baudrate_value(speed);
         bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
         ret = qca_set_baudrate(hu->hdev, qca_baudrate);
         if (ret) {
                 bt_dev_err(hu->hdev, "Failed to change the baudrate 
(%d)", ret);
                 return ret;
         }

change_host_baudrate:

         host_set_baudrate(hu, speed);
         if (soc_type == QCA_WCN3990)
                 hci_uart_set_flow_control(hu, false);

         return ret;
}


is it good idea?
-- 
Regards
Balakrishna.
