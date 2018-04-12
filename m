Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 2/3] Add support to power Bluetooth QCA chips attached to
 MSM
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3e618b0e031d45ecf16540e4b9ab4ed9@codeaurora.org>
Date: Thu, 12 Apr 2018 16:52:18 +0200
Cc: Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Message-Id: <4E06C9FC-4664-40F9-9D74-A525C583211F@holtmann.org>
References: <1523015546-994-1-git-send-email-bgodavar@codeaurora.org>
 <1523015546-994-3-git-send-email-bgodavar@codeaurora.org>
 <8D0DD743-B798-4581-BA36-0513FB3AAF63@holtmann.org>
 <3e618b0e031d45ecf16540e4b9ab4ed9@codeaurora.org>
To: rtatiya@codeaurora.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rupesh,

>>> Add support to set voltage/current of various regulators to power up/down
>>> BT QCA chips attached to MSM.
>>> Change-Id: I3600dd7bc97c753bc9cf7f8ac39d7b90bc21c67d
>>> Signed-off-by: Rupesh Tatiya <rtatiya@codeaurora.org>
>>> ---
>>> drivers/bluetooth/Makefile      |   5 +-
>>> drivers/bluetooth/btqca_power.c | 177 ++++++++++++++++++++++++++++++++++++++++
>>> drivers/bluetooth/btqca_power.h |  71 ++++++++++++++++
>>> 3 files changed, 251 insertions(+), 2 deletions(-)
>>> create mode 100644 drivers/bluetooth/btqca_power.c
>>> create mode 100644 drivers/bluetooth/btqca_power.h
>>> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
>>> index 4e4e44d..f963909 100644
>>> --- a/drivers/bluetooth/Makefile
>>> +++ b/drivers/bluetooth/Makefile
>>> @@ -24,8 +24,9 @@ obj-$(CONFIG_BT_WILINK)		+= btwilink.o
>>> obj-$(CONFIG_BT_QCOMSMD)	+= btqcomsmd.o
>>> obj-$(CONFIG_BT_BCM)		+= btbcm.o
>>> obj-$(CONFIG_BT_RTL)		+= btrtl.o
>>> -obj-$(CONFIG_BT_QCA)		+= btqca.o
>>> -
>>> +obj-$(CONFIG_BT_QCA)		+= btqca_uart.o
>>> +btqca_uart-$(CONFIG_BT_QCA)	+= btqca.o
>>> +btqca_uart-$(CONFIG_BT_QCA)	+= btqca_power.o
>>> obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
>>> btmrvl-y			:= btmrvl_main.o
>>> diff --git a/drivers/bluetooth/btqca_power.c b/drivers/bluetooth/btqca_power.c
>>> new file mode 100644
>>> index 0000000..a189ff1
>>> --- /dev/null
>>> +++ b/drivers/bluetooth/btqca_power.c
>>> @@ -0,0 +1,177 @@
>>> +/* Copyright (c) 2009-2010, 2013-2018 The Linux Foundation.
>>> + * All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +/*
>>> + * Bluetooth Power Switch Module
>>> + * controls power to external Bluetooth device
>>> + * with interface to power management device
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/module.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/of_device.h>
>>> +#include <net/bluetooth/bluetooth.h>
>>> +
>>> +#include "btqca_power.h"
>>> +
>>> +static struct btqca_power *qca;
>>> +
>>> +static const struct btqca_vreg_data cherokee_data = {
>>> +	.soc_type = BTQCA_CHEROKEE,
>>> +	.vregs = (struct btqca_vreg []) {
>>> +		{ "vddio",   1352000, 1352000,  0 },
>>> +		{ "vddxtal", 1904000, 2040000,  0 },
>>> +		{ "vddcore", 1800000, 1800000,  1 },
>>> +		{ "vddpa",   130400,  1304000,  1 },
>>> +		{ "vddldo",  3000000, 3312000,  1 },
>>> +		{ "vddpwd",  3312000, 3600000,  0 },
>>> +	},
>>> +	.num_vregs = 6,
>>> +};
>>> +
>>> +static const struct of_device_id btqca_power_match_table[] = {
>>> +	{ .compatible = "qca,wcn3990", .data = &cherokee_data},
>>> +	{}
>>> +};
>>> +
>>> +int btqca_get_soc_type(enum btqca_soc_t *type)
>>> +{
>>> +	if (!qca || !qca->vreg_data)
>>> +		return -EINVAL;
>>> +
>>> +	*type = qca->vreg_data->soc_type;
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(btqca_get_soc_type);
>>> +
>>> +int btqca_power_setup(int on)
>>> +{
>>> +	int ret = 0;
>>> +	int i;
>>> +	struct btqca_vreg *vregs;
>>> +
>>> +	if (!qca || !qca->vreg_data || !qca->vreg_bulk)
>>> +		return -EINVAL;
>>> +	vregs = qca->vreg_data->vregs;
>>> +
>>> +	BT_DBG("on: %d", on);
>>> +
>>> +	if (on) {
>>> +		for (i = 0; i < qca->vreg_data->num_vregs; i++) {
>>> +			regulator_set_voltage(qca->vreg_bulk[i].consumer,
>>> +					      vregs[i].min_v,
>>> +					      vregs[i].max_v);
>>> +
>>> +			if (vregs[i].load_ua)
>>> +				regulator_set_load(qca->vreg_bulk[i].consumer,
>>> +						   vregs[i].load_ua);
>>> +
>>> +			regulator_enable(qca->vreg_bulk[i].consumer);
>>> +		}
>>> +	} else {
>>> +		for (i = 0; i < qca->vreg_data->num_vregs; i++) {
>>> +			regulator_disable(qca->vreg_bulk[i].consumer);
>>> +
>>> +			regulator_set_voltage(qca->vreg_bulk[i].consumer,
>>> +						0, vregs[i].max_v);
>>> +
>>> +			regulator_set_load(qca->vreg_bulk[i].consumer, 0);
>>> +		}
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(btqca_power_setup);
>> I do not get why this is a separate module and totally disconnected
>> from the Bluetooth driver. We have pending patches for using serdev
>> for the hci_qca.c and it seems that should be all build together. I am
>> not really keen on adding platform device and platform data here. So
>> frankly I am missing the big picture on how this is suppose to work.
>> We are driving towards serdev and thus a clean support for UART based
>> devices. This seems to be doing something else.
>> Regards
>> Marcel
> 
> These patches are for older design based on line discipline and
> hciattach/btattach. I was unaware of the serdev side of changes. We will
> rewrite these changes on top of serdev patches for hci_qca.c
> 
> In the bigger picture, this change contains code to power on/off WCN3990.
> Across different host MSMs and PMICs, the regulators that need to be voted are
> different. So we add these changes into device tree. The on/off API is called
> from hci_qca.c. (HCIDEVUP -> qca_setup -> btacq_power_setup). In serdev design,
> we will read these regulators as a part of probe & still vote them in
> context of HCIDEVUP/HCIDEVDOWN.

the power control really needs to happen in open/close callbacks. Doing them in setup is a bit too late. We expect the transport to be ready since setup is allowed to execute HCI commands.

> One minor issue I have with serdev is, it seems to be aligned with BlueZ
> architecture. There are other protocol stacks which are completely written
> in userspace & do not have any protocol layers (and line discipline in old
> design) in kernel (e.g. Fluoride in Android). Even for such cases, the sequence
> to turn WCN3990 on/off does not change. In such case, we expose a char device or
> sysfs entry to userspace & perform voting through ioctl calls. This code can not
> be reused in such cases. Hypothetically, voting code can be added to something
> like tty_serdev (parallel to n_tty line discipline) for non-BlueZ cases.

Just use HCI_CHANNEL_USER. It will give you raw HCI access. There is a driver for that in Android as well. It will then work with any hardware and the power control is correctly done by the kernel.

> But serdev seems to link voting code to tty clients (hci_serdev or tty_serdev) when
> client really does not have any relation to it (at least in case of WCN3990).
> I would be very happy to get my understanding corrected if there are any
> mistakes and hear your thoughts on this.

Don’t get this. If you run Bluetooth, that means any opening of the TTY is done to run Bluetooth.

Regards

Marcel

