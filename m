Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 31 Jul 2018 20:13:52 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v11 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180730205502.GC68975@google.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
 <20180727141320.25218-8-bgodavar@bgodavar-linux.qualcomm.com>
 <20180730205502.GC68975@google.com>
Message-ID: <8a8c786f2c668681032a59888ffc020d@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-07-31 02:25, Matthias Kaehlcke wrote:
> On Fri, Jul 27, 2018 at 07:43:20PM +0530, Balakrishna Godavarthi wrote:
>> From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> 
>> Add support to set voltage/current of various regulators
>> to power up/down Bluetooth chip wcn3990.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v11:
>>     * removed support to read regulator currents from dts.
>>     * updated review comments.
> 
> Updated regulator voltage ranges?
> 
>> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
>> +{
>> +	struct hci_dev *hdev = hu->hdev;
>> +	int i, ret;
>> +
>> +	/* wcn3990 is a discrete Bluetooth chip connected to SoC.
>> +	 * sometimes we will face communication synchronization issues,
>> +	 * like reading version command timeouts. In which HCI_SETUP fails,
>> +	 * to overcome these issues, we try to communicate by performing an
>> +	 * cold power off and on.
>> +	 */
>> +	for (i = 0; i <= 3; i++) {
>> +		ret = qca_power_setup(hu, true);
>> +		if (ret)
>> +			goto regs_off;
>> +
>> +		/* Forcefully enable wcn3990 to enter in to boot mode. */
>> +		host_set_baudrate(hu, 2400);
>> +		ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
>> +		if (ret)
>> +			goto regs_off;
>> +
>> +		qca_set_speed(hu, QCA_INIT_SPEED);
>> +		ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
>> +		if (ret)
>> +			goto regs_off;
>> +
>> +		/* Wait for 100 ms for SoC to boot */
>> +		msleep(100);
>> +
>> +		/* Now the device is in ready state to communicate with host.
>> +		 * To sync host with device we need to reopen port.
>> +		 * Without this, we will have RTS and CTS synchronization
>> +		 * issues.
>> +		 */
>> +		serdev_device_close(hu->serdev);
>> +		ret = serdev_device_open(hu->serdev);
>> +		if (ret) {
>> +			bt_dev_err(hu->hdev, "failed to open port");
>> +			break;
>> +		}
>> +
>> +		hci_uart_set_flow_control(hu, false);
>> +		ret = qca_read_soc_version(hdev, soc_ver);
>> +
>> +		if (!ret)
>> +			break;
>> +
>> +regs_off:
>> +		bt_dev_err(hdev, "retrying to establish communication: %d",
>> +			   i + 1);
>> +		qca_power_shutdown(hdev);
>> +	}
>> +
>> +	return ret;
>> +}
> 
> I'm still not convinced that the retry loop is needed/desirable, I
> commented on the discussion on v10.
> 
[Bala] : replied on v10 patch.

>> +static const struct qca_vreg_data qca_soc_data = {
>> +	.soc_type = QCA_WCN3990,
>> +	.vregs = (struct qca_vreg []) {
>> +		{ "vddio",   1800000, 1900000,  15000  },
>> +		{ "vddxo",   1800000, 1900000,  80000  },
>> +		{ "vddrf",   1300000, 1350000,  300000 },
>> +		{ "vddch0",  3300000, 3400000,  450000 },
>> +	},
> 
> In v10 this was:
> 
> 		{ "vddio",   1800000, 1800000,  15000  },
> 		{ "vddxo",   1800000, 1800000,  80000  },
> 		{ "vddrf",   1304000, 1304000,  300000 },
> 		{ "vddch0",  3000000, 3312000,  450000 },
> 
> I don't have concerns about the new voltage ranges, but you should
> mention such changes in the changelog, ideally with a brief
> description why the change was made.

[Bala]: I missed to add, I just updated with latest values from 
datasheet.

-- 
Regards
Balakrishna.
