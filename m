Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 20 Sep 2018 19:18:25 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_qca: Add poweroff support during
 hci down for wcn3990
In-Reply-To: <20180919172137.GQ22824@google.com>
References: <20180919152113.7611-1-bgodavar@codeaurora.org>
 <20180919152113.7611-2-bgodavar@codeaurora.org>
 <20180919172137.GQ22824@google.com>
Message-ID: <47d7644bfaf5844c9194ff7739ea1762@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-09-19 22:51, Matthias Kaehlcke wrote:
> On Wed, Sep 19, 2018 at 08:51:13PM +0530, Balakrishna Godavarthi wrote:
>> This patch enables power off support for hci down and power on support
>> for hci up. As wcn3990 power sources are ignited by regulators, we 
>> will
>> turn off them during hci down, i.e. an complete power off of wcn3990.
>> So while hci up, we will call vendor specific open/close and setup 
>> which
>> will turn on the regulators, requests BT chip version and download the
>> firmware.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 74f5fede0274..c3038afa42af 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -168,6 +168,7 @@ struct qca_serdev {
>> 
>>  static int qca_power_setup(struct hci_uart *hu, bool on);
>>  static void qca_power_shutdown(struct hci_uart *hu);
>> +static int qca_power_off(struct hci_dev *hdev);
>> 
>>  static void __serial_clock_on(struct tty_struct *tty)
>>  {
>> @@ -1099,8 +1100,26 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  static int qca_wcn3990_init(struct hci_uart *hu)
>>  {
>>  	struct hci_dev *hdev = hu->hdev;
>> +	struct qca_serdev *qcadev;
>>  	int ret;
>> 
>> +	/* Check for vregs status, may be hci0 down has turned
>> +	 * off the vregs.
>> +	 */
> 
> nit: it's not necessarily 'hci0', there may be systems with more than
> one Bluetooth controller. You could say hciN instead, you might also
> want to put quotes around 'hciN down' to make clearer this is
> referring to a command.
> 
[Bala]: will update.

>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +	if (qcadev->bt_power->vregs_on == false) {
> 
> nit:
> 	if (!qcadev->bt_power->vregs_on) {
> 
> is more common and easier to read IMO
> 

[Bala]: will update.

>> +		serdev_device_close(hu->serdev);
>> +		ret = qca_power_setup(hu, true);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = serdev_device_open(hu->serdev);
>> +		if (ret) {
>> +			bt_dev_err(hu->hdev, "failed to open port");
> 
> switch the regulators off again?

[Bala]: it is not required to call the regulators off, when the serdev 
open fails.
         as the non zero return status will call the hci_dev_do_close() 
i.e. hdev->shutdown()
> 
>> +			return ret;
>> +		}
>> +	}
>> +
>>  	/* Forcefully enable wcn3990 to enter in to boot mode. */
>>  	host_set_baudrate(hu, 2400);
>>  	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
>> @@ -1152,6 +1171,12 @@ static int qca_setup(struct hci_uart *hu)
>> 
>>  	if (qcadev->btsoc_type == QCA_WCN3990) {
>>  		bt_dev_info(hdev, "setting up wcn3990");
>> +
>> +		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
>> +		 * setup for every hci0 up.
> 
> nit: 'hciN up'?

[Bala]: will update.

> 
>> +		 */
>> +		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>> +		hu->hdev->shutdown = qca_power_off;
>>  		ret = qca_wcn3990_init(hu);
>>  		if (ret)
>>  			return ret;
>> @@ -1242,6 +1267,14 @@ static void qca_power_shutdown(struct hci_uart 
>> *hu)
>>  	qca_power_setup(hu, false);
>>  }
>> 
>> +static int qca_power_off(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +
>> +	qca_power_shutdown(hu);
> 
> Would it make sense to add a return value qca_power_shutdown() now
> that it is called by a non-void function? Might not be worth the
> hassle though, hci_dev_do_close() - the only caller of
> hdev->shutdown() - doesn't check the return value either.
> 

[Bala]: even i felt the same, but hci_dev_do_close() is not checking for 
the status.

> Cheers
> 
> Matthias

-- 
Regards
Balakrishna.
