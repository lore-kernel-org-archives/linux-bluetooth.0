Return-Path: <mka@chromium.org>
Date: Thu, 26 Jul 2018 12:51:29 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
	rtatiya@codeaurora.org, hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180726195129.GW129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-8-bgodavar@codeaurora.org>
 <20180723195441.GM129942@google.com>
 <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
 <20180725183144.GQ129942@google.com>
 <0666f40967de21db9ef3df9d94517ac1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0666f40967de21db9ef3df9d94517ac1@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 26, 2018 at 07:51:13PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-07-26 00:01, Matthias Kaehlcke wrote:
> > On Tue, Jul 24, 2018 at 09:25:16PM +0530, Balakrishna Godavarthi wrote:
> > > Hi Matthias,
> > > 
> > > On 2018-07-24 01:24, Matthias Kaehlcke wrote:
> > > > On Fri, Jul 20, 2018 at 07:02:43PM +0530, Balakrishna Godavarthi wrote:
> > > > > +	 * sometimes we will face communication synchronization issues,
> > > > > +	 * like reading version command timeouts. In which HCI_SETUP fails,
> > > > > +	 * to overcome these issues, we try to communicate by performing an
> > > > > +	 * COLD power OFF and ON.
> > > > > +	 */
> > > > > +	for (i = 1; i <= 10 && ret; i++) {
> > > >
> > > > Is it really that bad that more than say 3 iterations might be needed?
> > > >
> > > [Bala]: will restrict to 3 iterations.
> > 
> > Is 3x expected to be enough to 'guarantee' as successful
> > initialization? Just wondered about the 10x since it suddendly changed
> > from 1x. What is the failure rate without retries?
> > 
> > Could you provide more information about the 'communication
> > synchronization issues'? Is the root cause understood? Maybe there is
> > a better way than retries.
> > 
> 
> [Bala]: basically before sending a every patch series we run a stress test
> to the driver to detect the bugs.
>         in recent test results found one interesting bug that BT setups
> fails with version request timeouts,
>         after we do a reboot for the device.
>         we debugged the issue and found that wcn3900 is not responding to
> the version request commands
>         sent by HOST. this is because before reboot, wcn3990 is in on state
> i.e. we are communicating to device.
>         then we did a reboot and HOST is not sending a power off request to
> the regulators to turn off.
>         so after reboot wcn3990 is still in ON state where it will not
> respond to version request commands which in turn fails HCI_SETUP.
>         so we are sending the power off pulse and then sending the power on
> pulse.
>         coming back to 3x or 10x iteration this is to avoid any such
> synchronization issues.
>         i agreed for 3x because of stress test results. we have success rate
> of 99% for single iteration, where as 3x iterations will helps to handle 1%
> fails cases.

Thanks for the clarification. Couldn't you assure the device is in a
defined state by calling qca_power_shutdown() as one of the first
things in qca_wcn3990_init()?

Some more comments on the functions, for if the retry loop is kept:

> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	int i, ret = 1;
> +
> +	/* WCN3990 is a discrete Bluetooth chip connected to APPS processor.
> +	 * sometimes we will face communication synchronization issues,
> +	 * like reading version command timeouts. In which HCI_SETUP fails,
> +	 * to overcome these issues, we try to communicate by performing an
> +	 * COLD power OFF and ON.
> +	 */
> +	for (i = 1; i <= 10 && ret; i++) {
> +		/* This helper will turn ON chip if it is powered off.
> +		 * if the chip is already powered ON, function call will
> +		 * return zero.
> +		 */
> +		ret = qca_power_setup(hu, true);
> +		if (ret)
> +			goto regs_off;

A failure here is not caused by a communication problem, so this
should probably be a 'return' instead of a 'goto'.

> +
> +		/* Forcefully enable wcn3990 to enter in to boot mode. */
> +		host_set_baudrate(hu, 2400);
> +		ret = qca_send_vendor_pulse(hdev, QCA_WCN3990_FORCE_BOOT_PULSE);
> +		if (ret)
> +			goto regs_off;
> +
> +		qca_set_speed(hu, QCA_INIT_SPEED);
> +		ret = qca_send_vendor_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
> +		if (ret)
> +			goto regs_off;
> +
> +		/* Wait for 100 ms for SoC to boot */
> +		msleep(100);
> +
> +		/* Now the device is in ready state to communicate with host.
> +		 * To sync HOST with device we need to reopen port.
> +		 * Without this, we will have RTS and CTS synchronization
> +		 * issues.
> +		 */
> +		serdev_device_close(hu->serdev);
> +		ret = serdev_device_open(hu->serdev);
> +		if (ret) {
> +			bt_dev_err(hu->hdev, "failed to open port");
> +			break;

			return ret;

> +		}
 > +
> +		hci_uart_set_flow_control(hu, false);
> +		ret = qca_read_soc_version(hdev, soc_ver);
> +		if (ret < 0 || soc_ver == 0)
> +			bt_dev_err(hdev, "Failed to get version:%d", ret);

nit: add a space between ':' and '%d'

> +
> +		if (!ret)
> +			break;

			return 0;

> +
> +regs_off:
> +		bt_dev_err(hdev, "retrying to establish communication: %d", i);
> +		qca_power_shutdown(hdev);

Is qca_power_shutdown() needed or would qca_power_setup(hu,
false) be enough? This is qca_power_shutdown():

static int qca_power_shutdown(struct hci_dev *hdev)
{
        struct hci_uart *hu = hci_get_drvdata(hdev);

        host_set_baudrate(hu, 2400);
        qca_send_vendor_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
        return qca_power_setup(hu, false);
}

It additionally sends the power off pulse, which is also done in the
loop (though it is currently called QCA_WCN3990_FORCE_BOOT_PULSE).

The code flow with the gotos and the error handling at the end of the
loop is a bit messy. Moving the power down to the top of the loop
(basically in line with my comment above to get rid of the loop) would
help here. In this case checking 'ret' in the loop condition (which I
suggested to remove) would make sense, since it elimninates the need
for the break/return in the success case. But if we can do without the
loop even better :)

> > If I understand correctly you describe a hypothetical situation of a
> > future wcn3990 variant having lower power requirements. I'd say let's
> > deal with this when these chips actually exist and need to be
> > supported by Linux. As of now it seems there is no need for current
> > limits in the DT.
> > 
> 
> [Bala]: will remove current property for dts.
>         in previous mail you asked me a question for currents
>         "The currents of 300mA and 450mA seem high for Bluetooth, I'm not an
>          expert in this area though, they might be reasonable peak currents
> for
>          certain use cases."
> 
>          yes we require 450mA and 300mA of current for rf and ch0 pins.
> setting regulator to required load will not pump load current to wcn3990
>         it depends on operations, typical the above are the max current
> drawn by the two pins.

Ok, thanks for confirming.
