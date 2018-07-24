Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 24 Jul 2018 12:32:36 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
In-Reply-To: <20180723175611.GL129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-5-bgodavar@codeaurora.org>
 <20180723175611.GL129942@google.com>
Message-ID: <12b59e77a4ee99c3de7bbd73ff10ce4b@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-07-23 23:26, Matthias Kaehlcke wrote:
> On Fri, Jul 20, 2018 at 07:02:40PM +0530, Balakrishna Godavarthi wrote:
>> In function qca_setup, we set initial and operating speeds for 
>> Qualcomm
>> Bluetooth SoC's. This block of code is common across different
>> Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
>> a wrapper function to set the speeds. So that future coming SoC's
>> can use these wrapper functions to set speeds.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 93 
>> ++++++++++++++++++++++++++++---------
>>  1 file changed, 70 insertions(+), 23 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 5f1c0a8fd5cd..5f8a74d65bec 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -119,6 +119,11 @@ struct qca_data {
>>  	u64 votes_off;
>>  };
>> 
>> +enum qca_speed_type {
>> +	QCA_INIT_SPEED = 1,
>> +	QCA_OPER_SPEED
>> +};
>> +
>>  struct qca_serdev {
>>  	struct hci_uart	 serdev_hu;
>>  	struct gpio_desc *bt_en;
>> @@ -923,6 +928,61 @@ static inline void host_set_baudrate(struct 
>> hci_uart *hu, unsigned int speed)
>>  		hci_uart_set_baudrate(hu, speed);
>>  }
>> 
>> +static unsigned int qca_get_speed(struct hci_uart *hu,
>> +				  enum qca_speed_type speed_type)
>> +{
>> +	unsigned int speed = 0;
>> +
>> +	if (speed_type == QCA_INIT_SPEED) {
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +	} else {
>> +		if (hu->oper_speed)
>> +			speed = hu->oper_speed;
>> +		else if (hu->proto->oper_speed)
>> +			speed = hu->proto->oper_speed;
>> +	}
>> +
>> +	return speed;
>> +}
>> +
>> +static int qca_check_speeds(struct hci_uart *hu)
>> +{
>> +	if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
>> +	    !qca_get_speed(hu, QCA_OPER_SPEED))
>> +		return -EINVAL;
> 
> You changed this from:
> 
> 	/* One or the other speeds should be non zero. */
> 	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
> 	    !qca_get_speed(hu, QCA_OPER_SPEED))
> 		return -EINVAL;
> 
> There is no entry in the change log. What is the reason for this
> change?

[Bala] : My bad i missed to add the log,as the above  if for ROME chip, 
having INIT or OPER speed is fine.

-- 
Regards
Balakrishna.
