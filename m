Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Arend Van Spriel" <arend@broadcom.com>
Subject: RE: [PATCH v2 3/5] Broadcom Bluetooth UART Platform Driver
Date: Fri, 12 Jun 2015 16:26:04 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E942615DC@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
 <1433966720-17482-4-git-send-email-ifaenson@broadcom.com>
 <187EFB2B-BD56-46BB-A022-6507A8F8AE66@holtmann.org>
In-Reply-To: <187EFB2B-BD56-46BB-A022-6507A8F8AE66@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Appreciate extensive comments on the very large patch.

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Friday, June 12, 2015 4:46 AM
To: Ilya Faenson
Cc: linux-bluetooth@vger.kernel.org; Arend Van Spriel
Subject: Re: [PATCH v2 3/5] Broadcom Bluetooth UART Platform Driver

Hi Ilya,

> Introduce the device tree enumerated Broadcom Bluetooth UART driver.
>=20
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/Kconfig      |   9 +
> drivers/bluetooth/Makefile     |   1 +
> drivers/bluetooth/btbcm_uart.c | 673 ++++++++++++++++++++++++++++++++++++=
+++++
> drivers/bluetooth/btbcm_uart.h |  89 ++++++
> 4 files changed, 772 insertions(+)
> create mode 100644 drivers/bluetooth/btbcm_uart.c
> create mode 100644 drivers/bluetooth/btbcm_uart.h
>=20
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 2e77707..5eee3ed 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -143,6 +143,7 @@ config BT_HCIUART_BCM
> 	bool "Broadcom protocol support"
> 	depends on BT_HCIUART
> 	select BT_HCIUART_H4
> +	select BT_UART_BCM
> 	select BT_BCM
> 	help
> 	  The Broadcom protocol support enables Bluetooth HCI over serial
> @@ -150,6 +151,14 @@ config BT_HCIUART_BCM
>=20
> 	  Say Y here to compile support for Broadcom protocol.
>=20
> +config BT_UART_BCM

if we follow our new naming that we have pushed since a few years now for n=
ew modules, then this should be BT_BCM_UART actually.

IF: Okay, will change.

> +	tristate "Broadcom BT UART driver"
> +	depends on BT_HCIUART_H4 && TTY

So I am thinking that we do not even make this an user visible option. This=
 should be just automatically selected from BT_HCIUART_BCM and that is it.

Meaning this is will be enough in the end:

	config BT_BCM_UART
		tristate

And I would just put it directly under the BT_BCM entry we already have.

IF: As per today's Loic's comment, the platform driver should be optional. =
I agree. I think it should be configured separately as well.

> +	help
> +	  This driver supports the HCI_UART_BT protocol.
> +
> +	  It manages Bluetooth UART device properties and GPIOs.
> +

This is something we have to figure out from a design point of view. Do we =
want to keep this as a separate module or not. My initial thinking here is =
that the platform driver should be just registered from bcm_init in hci_bcm=
.c.

I mean wouldn't it be a lot simpler if we can match up the BT HCI UART bcm_=
proto driver to the platform driver? I have no objection to make this a sep=
arate module, but I want to make sure that we looked at these two options.

If we ever get to UART slave drivers, then this would be essentially the UA=
RT slave driver, correct?

IF: The platform and ACPI (in the future) are logically separate drivers. I=
 would not want to see them both within a BlueZ protocol. Sharing a module =
will not make mapping a protocol instance into a driver instance any easier=
. They would still need to exchange the identifying info. They are logicall=
y two completely different entities in my opinion. UART slave driver, to th=
e best of my limited current understanding, will just introduce one more la=
yer into the already fairly complicated picture. The platform and ACPI driv=
ers may still be needed to manage GPIOs and wakeup interrupts. Also, BlueZ =
protocol resides above the tty line discipline while UART slave is below so=
 having them in a single module would be very confusing in my opinion.

> config BT_HCIBCM203X
> 	tristate "HCI BCM203x USB driver"
> 	depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index f40e194..e908a88 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_BT_MRVL)		+=3D btmrvl.o
> obj-$(CONFIG_BT_MRVL_SDIO)	+=3D btmrvl_sdio.o
> obj-$(CONFIG_BT_WILINK)		+=3D btwilink.o
> obj-$(CONFIG_BT_BCM)		+=3D btbcm.o
> +obj-$(CONFIG_BT_UART_BCM)	+=3D btbcm_uart.o
> obj-$(CONFIG_BT_RTL)		+=3D btrtl.o
>=20
> btmrvl-y			:=3D btmrvl_main.o
> diff --git a/drivers/bluetooth/btbcm_uart.c b/drivers/bluetooth/btbcm_uar=
t.c
> new file mode 100644
> index 0000000..ccd02a9
> --- /dev/null
> +++ b/drivers/bluetooth/btbcm_uart.c
> @@ -0,0 +1,673 @@
> +/*
> + *  Bluetooth BCM UART Driver
> + *
> + *  Copyright (c) 2015 Broadcom Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/fcntl.h>
> +#include <linux/interrupt.h>
> +#include <linux/ptrace.h>
> +#include <linux/poll.h>
> +
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/signal.h>
> +#include <linux/ioctl.h>
> +#include <linux/skbuff.h>
> +#include <linux/list.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_platform.h>
> +
> +#include "btbcm_uart.h"
> +
> +static int idle_timeout =3D 5;
> +module_param(idle_timeout, int, 0);
> +MODULE_PARM_DESC(idle_timeout, "Bluetooth idle timeout in seconds");

I wonder if this isn't a debugfs option? I have told Marvell that some of t=
heir additions might be better served as debugfs option. So for example hoo=
ked up under /sys/kernel/debug/bluetooth/hci0/bcm_xx for example.

Not sure if this is easy to do or even if this is something static, then it=
 should be a DT entry.

IF: I've actually had it as the DT parameter initially but the application =
engineer for a customer wanted it easily changeable at runtime. I think it =
would be an overkill to roll out the debugfs support for this single parame=
ter. Also, what about the platforms (like phones) where debugfs is not avai=
lable at all?

> +
> +/* Device context */
> +struct bcm_device {
> +	struct list_head list;
> +
> +	struct platform_device *pdev;
> +	struct gpio_desc *bt_wake_gpio;
> +	struct gpio_desc *dev_wake_gpio;
> +	struct gpio_desc *reg_on_gpio;
> +	int bt_wake_irq;
> +	int dev_wake_active_low;
> +	int reg_on_active_low;
> +	int bt_wake_active_low;
> +	bool configure_sleep;
> +	u32 manual_fc;
> +	u32 oper_speed;
> +	bool configure_audio;
> +	u32 pcm_clockmode;
> +	u32 pcm_fillmethod;
> +	u32 pcm_fillnum;
> +	u32 pcm_fillvalue;
> +	u32 pcm_incallbitclock;
> +	u32 pcm_lsbfirst;
> +	u32 pcm_rightjustify;
> +	u32 pcm_routing;
> +	u32 pcm_shortframesync;
> +	u32 pcm_syncmode;
> +
> +	char tty_name[64];
> +
> +	struct btbcm_uart_callbacks protocol_callbacks;
> +	struct work_struct wakeup_work;
> +};
> +
> +/* List of BCM BT UART devices */
> +static DEFINE_SPINLOCK(device_list_lock);
> +static LIST_HEAD(device_list);
> +
> +/*
> + * Calling the BCM protocol at lower execution priority
> + */

Please follow network subsystem coding style rules for comments.

IF: Okay.

> +static void bcm_bt_wakeup_task(struct work_struct *ws)

Instead of *ws, lets use *work here to be a bit more consistent on how the =
Bluetooth subsystem labels them.

IF: Okay.

> +{
> +	int gpio_value;
> +	struct bcm_device *p_bcm_device =3D
> +		container_of(ws, struct bcm_device, wakeup_work);

As a more generic rule, have the struct with the assignment from the "user =
data" as the first one.

IF: Okay.

Also p_bcm_device is something we generally do not do. The p_ for as in poi=
nter is not really our style. So I work short it to just *dev here.

IF: Okay.

> +
> +	if (!p_bcm_device) {
> +		BT_DBG("%s - failing, no device", __func__);

Lets avoid __func__ and rely on dynamic debug feature.

IF: Okay.

> +		return;
> +	}
> +
> +	/* Make sure the device is resumed */
> +	gpio_value =3D !p_bcm_device->dev_wake_active_low;
> +	if (p_bcm_device->dev_wake_gpio) {


The variable declaration of gpio_value and it assignment can go here.

IF: Okay.

> +		gpiod_set_value(p_bcm_device->dev_wake_gpio, gpio_value);
> +		BT_DBG("%s - resume %d written, delaying 15 ms",
> +		       __func__, gpio_value);
> +		mdelay(15);
> +	}
> +
> +	/* Let the protocol know it's time to wake up */
> +	if (p_bcm_device->protocol_callbacks.p_wakeup)
> +		p_bcm_device->protocol_callbacks.p_wakeup(
> +			p_bcm_device->protocol_callbacks.context);
> +}
> +
> +/*
> + * Interrupt routine for the wake from the device
> + */
> +static irqreturn_t bcm_bt_uart_isr(int irq, void *context)
> +{
> +	unsigned int bt_wake;
> +	struct bcm_device *p =3D (struct bcm_device *)context;
> +
> +	bt_wake =3D gpiod_get_value(p->bt_wake_gpio);
> +	BT_DBG("%s with bt_wake of %d (active_low %d), req bh",
> +	       __func__, bt_wake, p->bt_wake_active_low);
> +
> +	/* Defer the actual processing to the platform work queue */
> +	schedule_work(&p->wakeup_work);
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Device instance startup
> + */
> +static int bcm_bt_uart_probe(struct platform_device *pdev)
> +{
> +	int ret =3D 0;

Please only assign variables to zero only if that is needed and there is no=
 other way.

IF: Okay.

> +	struct device_node *np =3D pdev->dev.of_node;
> +	const char *tty_name;
> +	struct bcm_device *p_bcm_device =3D NULL;

No point to assign to NULL if you assign anyway. Please remove these.

IF: Okay.

> +
> +	p_bcm_device =3D devm_kzalloc(&pdev->dev, sizeof(*p_bcm_device),
> +		GFP_KERNEL);

Please use proper alignment when calls break into multiple lines.

IF: Okay.

> +	if (!p_bcm_device) {
> +		BT_DBG("%s - failing due to no memory", __func__);
> +		return -ENOMEM;
> +	}

There should be an empty line here. Indicated a logical break if you leave =
the function is a good idea.

IF: Okay.

> +	p_bcm_device->pdev =3D pdev;
> +	BT_DBG("%s %p context", __func__, p_bcm_device);
> +
> +	/* Get dev wake GPIO */
> +	p_bcm_device->dev_wake_gpio =3D gpiod_get(&pdev->dev, "bt-wake");
> +	BT_DBG("%s - gpiod_get for bt-wake returned %p",
> +	       __func__, p_bcm_device->dev_wake_gpio);

I get the feeling that we have a little bit too much BT_DBG. Especially if =
you print errors later on anyway. Keep in mind that a lot of distribution w=
ill have dynamic debug enabled. So going crazy with BT_DBG is not a good id=
ea.

IF: Will try reducing debug spew some.

> +	if (IS_ERR(p_bcm_device->dev_wake_gpio)) {
> +		ret =3D PTR_ERR(p_bcm_device->dev_wake_gpio);
> +		if (ret !=3D -ENOENT) {
> +			dev_err(&pdev->dev,
> +				"%s - dev_wake GPIO: %d\n", __func__, ret);
> +		}

Single calls do not require { }.

IF: Okay, will change.

> +		p_bcm_device->dev_wake_gpio =3D NULL;
> +	} else {
> +		int gpio_value;
> +
> +		p_bcm_device->dev_wake_active_low =3D gpiod_is_active_low
> +			(p_bcm_device->dev_wake_gpio);
> +		BT_DBG("%s - dev_wake a-low is %d (cans %d)",
> +		       __func__, p_bcm_device->dev_wake_active_low,
> +		       gpiod_cansleep(p_bcm_device->dev_wake_gpio));
> +
> +		/* configure dev_wake as output with init resumed state */
> +		gpio_value =3D !p_bcm_device->dev_wake_active_low;
> +		ret =3D gpiod_direction_output(p_bcm_device->dev_wake_gpio,
> +					     gpio_value);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"%s s dev_wake GPIO: %d\n", __func__, ret);
> +			gpiod_put(p_bcm_device->dev_wake_gpio);
> +			p_bcm_device->dev_wake_gpio =3D NULL;
> +			goto end;
> +		} else {
> +			BT_DBG("%s - dev_wake set to %d", __func__,
> +			       gpio_value);
> +		}
> +	}
> +
> +	/* Get power on/off GPIO */
> +	p_bcm_device->reg_on_gpio =3D gpiod_get(&pdev->dev, "bt-reg-on");
> +	BT_DBG("%s - gpiod_get for bt-reg-on returned %p", __func__,
> +	       p_bcm_device->reg_on_gpio);
> +	if (IS_ERR(p_bcm_device->reg_on_gpio)) {
> +		ret =3D PTR_ERR(p_bcm_device->reg_on_gpio);
> +		if (ret !=3D -ENOENT) {
> +			dev_err(&pdev->dev,
> +				"%s - reg_on GPIO: %d\n", __func__, ret);
> +		}
> +		p_bcm_device->reg_on_gpio =3D NULL;
> +	} else {
> +		int poweron_flag;
> +
> +		p_bcm_device->reg_on_active_low =3D gpiod_is_active_low
> +			(p_bcm_device->reg_on_gpio);
> +		BT_DBG("%s - reg_on a-low is %d (cans %d)",
> +		       __func__, p_bcm_device->reg_on_active_low,
> +		       gpiod_cansleep(p_bcm_device->reg_on_gpio));
> +
> +		/* configure reg_on as output with init on state */
> +		poweron_flag =3D !p_bcm_device->reg_on_active_low;
> +		ret =3D gpiod_direction_output(p_bcm_device->reg_on_gpio,
> +					     poweron_flag);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"%s set reg_on GPIO: %d\n", __func__, ret);
> +			gpiod_put(p_bcm_device->reg_on_gpio);
> +			p_bcm_device->reg_on_gpio =3D NULL;
> +		} else {
> +			BT_DBG("%s - reg_on initially set to %d", __func__,
> +			       poweron_flag);
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, p_bcm_device);
> +	/* Must be done before interrupt is requested */
> +	INIT_WORK(&p_bcm_device->wakeup_work, bcm_bt_wakeup_task);
> +
> +	/* Get bt host wake GPIO */
> +	p_bcm_device->bt_wake_gpio =3D gpiod_get(&pdev->dev, "bt-host-wake");
> +	BT_DBG("%s - gpiod_get for bt-host-wake returned %p", __func__,
> +	       p_bcm_device->bt_wake_gpio);
> +	if (IS_ERR(p_bcm_device->bt_wake_gpio)) {
> +		ret =3D PTR_ERR(p_bcm_device->bt_wake_gpio);
> +		if (ret !=3D -ENOENT) {
> +			dev_err(&pdev->dev,
> +				"%s - bt_wake GPIO: %d\n", __func__, ret);
> +		}
> +		p_bcm_device->bt_wake_gpio =3D NULL;
> +	} else {
> +		/* configure bt_wake as input */
> +		ret =3D gpiod_direction_input(p_bcm_device->bt_wake_gpio);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"%s set bt_wake GPIO: %d\n", __func__, ret);
> +			gpiod_put(p_bcm_device->bt_wake_gpio);
> +			p_bcm_device->bt_wake_gpio =3D NULL;
> +		} else {
> +			p_bcm_device->bt_wake_active_low =3D gpiod_is_active_low
> +				(p_bcm_device->bt_wake_gpio);
> +			BT_DBG("%s -bt_wake a-low is %d(cans%d)",
> +			       __func__, p_bcm_device->bt_wake_active_low,
> +			       gpiod_cansleep(p_bcm_device->bt_wake_gpio));
> +			p_bcm_device->bt_wake_irq =3D gpiod_to_irq
> +				(p_bcm_device->bt_wake_gpio);
> +			if (p_bcm_device->bt_wake_irq < 0) {
> +				dev_err(&pdev->dev,
> +				"%s - HOST_WAKE IRQ: %d\n", __func__, ret);

Please use proper alignment. If you run out of space, then consider restruc=
turing this whole code. These many nested if statements are really bad sinc=
e they make the code hard to understand.

One advice would be to actually leave the function or goto to a later step =
in case of errors. In this case that saves you one indentation.

Then } else if { is totally valid as well and I think that might save you a=
 second one. Please work on making this readable so that my brain hurts les=
s when trying to understand it ;)

IF: Will try.

> +			} else {
> +				unsigned long intflags =3D IRQF_TRIGGER_RISING;
> +
> +				if (p_bcm_device->bt_wake_active_low)
> +					intflags =3D IRQF_TRIGGER_FALLING;
> +
> +				ret =3D request_irq(p_bcm_device->bt_wake_irq,
> +						  bcm_bt_uart_isr,
> +						  intflags, "bt_host_wake",
> +						  p_bcm_device);
> +				if (ret < 0) {
> +					dev_err(&pdev->dev,
> +						"%s - failed IRQ %d: %d",
> +						__func__,
> +						p_bcm_device->bt_wake_irq, ret);
> +				} else {
> +					BT_DBG("%s - IRQ %d", __func__,
> +					       p_bcm_device->bt_wake_irq);
> +				}
> +			}
> +		}
> +	}
> +
> +	p_bcm_device->configure_sleep =3D of_property_read_bool(
> +		np, "configure-sleep");

I do not know what the right indentation is here, but it is not this one. M=
ight want to check how other parts of the network subsystem deal with this.

IF: Will change.

> +	BT_DBG("configure-sleep read as %d", p_bcm_device->configure_sleep);
> +	p_bcm_device->manual_fc =3D 0;
> +	if (!of_property_read_u32(np, "manual-fc",
> +				  &p_bcm_device->manual_fc)) {
> +		BT_DBG("manual-fc read as %d",
> +			p_bcm_device->manual_fc);
> +	}
> +	p_bcm_device->oper_speed =3D 3000000;
> +	if (!of_property_read_u32(
> +		np, "oper-speed",
> +		&p_bcm_device->oper_speed)) {
> +		BT_DBG("oper-speed read as %d",
> +			p_bcm_device->oper_speed);

Here the code and test have the same indentation. That is not acceptable at=
 all.

IF: Will change.

> +	}
> +	p_bcm_device->configure_audio =3D of_property_read_bool(
> +		np, "configure-audio");
> +	BT_DBG("configure-audio read as %d", p_bcm_device->configure_audio);
> +	if (p_bcm_device->configure_audio) {
> +		/* Defaults for audio */
> +		p_bcm_device->pcm_clockmode =3D 0;
> +		p_bcm_device->pcm_fillmethod =3D 2;
> +		p_bcm_device->pcm_fillnum =3D 0;
> +		p_bcm_device->pcm_fillvalue =3D 3;
> +		p_bcm_device->pcm_incallbitclock =3D 0;
> +		p_bcm_device->pcm_lsbfirst =3D 0;
> +		p_bcm_device->pcm_rightjustify =3D 0;
> +		p_bcm_device->pcm_routing =3D 0;
> +		p_bcm_device->pcm_shortframesync =3D 0;
> +		p_bcm_device->pcm_syncmode =3D 0;
> +
> +		if (!of_property_read_u32(np, "pcm-clockmode",
> +					  &p_bcm_device->pcm_clockmode))
> +			BT_DBG("pcm-clockmode read as %d",
> +				p_bcm_device->pcm_clockmode);
> +		if (!of_property_read_u32(np, "pcm-fillmethod",
> +					  &p_bcm_device->pcm_fillmethod))
> +			BT_DBG("pcm-fillmethod readas %d",
> +				p_bcm_device->pcm_fillmethod);
> +		if (!of_property_read_u32(np, "pcm-fillnum",
> +					  &p_bcm_device->pcm_fillnum))
> +			BT_DBG("pcm-fillnum read as %d",
> +				p_bcm_device->pcm_fillnum);
> +		if (!of_property_read_u32(np, "pcm-fillvalue",
> +					  &p_bcm_device->pcm_fillvalue))
> +			BT_DBG("pcm-fillvalue read as %d",
> +				p_bcm_device->pcm_fillvalue);
> +		if (!of_property_read_u32(np, "pcm-incallbitclock",
> +					  &p_bcm_device->pcm_incallbitclock))
> +			BT_DBG("pcm-incallbitclock read as %d",
> +				p_bcm_device->pcm_incallbitclock);
> +		if (!of_property_read_u32(np, "pcm-lsbfirst",
> +					  &p_bcm_device->pcm_lsbfirst))
> +			BT_DBG("pcm-lsbfirst read as %d",
> +				p_bcm_device->pcm_lsbfirst);
> +		if (!of_property_read_u32(np, "pcm-rightjustify",
> +					  &p_bcm_device->pcm_rightjustify))
> +			BT_DBG("pcm-rightjustify read as %d",
> +				p_bcm_device->pcm_rightjustify);
> +		if (!of_property_read_u32(np, "pcm-routing",
> +					  &p_bcm_device->pcm_routing))
> +			BT_DBG("pcm-routing read as %d",
> +				p_bcm_device->pcm_routing);
> +		if (!of_property_read_u32(np, "pcm-shortframesync",
> +					  &p_bcm_device->pcm_shortframesync))
> +			BT_DBG("pcm-shortframesync read as %d",
> +				p_bcm_device->pcm_shortframesync);
> +		if (!of_property_read_u32(np, "pcm-syncmode",
> +					  &p_bcm_device->pcm_syncmode))
> +			BT_DBG("pcm-syncmode read as %d",
> +				p_bcm_device->pcm_syncmode);

I wonder if the BT_DBG are all needed here. I mean one debug statement on w=
hat we are going to use is better. If someone ends up trying to debug this,=
 then they can go and look at their DT.

IF: will try tracing a few parameters via the one BT_DBG.

> +	}
> +
> +	if (!of_property_read_string(np, "tty", &tty_name)) {
> +		strcpy(p_bcm_device->tty_name, tty_name);
> +		BT_DBG("tty name read as %s", p_bcm_device->tty_name);
> +	}
> +
> +	BT_DBG("idle_timeout set as %d", idle_timeout);
> +
> +	ret =3D 0;  /* If we made it here, we're fine */
> +
> +	/* Place this instance on the device list */
> +	spin_lock(&device_list_lock);
> +	list_add_tail(&p_bcm_device->list, &device_list);
> +	spin_unlock(&device_list_lock);
> +
> +end:
> +	if (ret) {
> +		if (p_bcm_device->reg_on_gpio) {
> +			gpiod_put(p_bcm_device->reg_on_gpio);
> +			p_bcm_device->reg_on_gpio =3D NULL;
> +		}
> +		if (p_bcm_device->bt_wake_gpio) {
> +			gpiod_put(p_bcm_device->bt_wake_gpio);
> +			p_bcm_device->bt_wake_gpio =3D NULL;
> +		}
> +		if (p_bcm_device->dev_wake_gpio) {
> +			gpiod_put(p_bcm_device->dev_wake_gpio);
> +			p_bcm_device->dev_wake_gpio =3D NULL;
> +		}
> +	}
> +
> +	BT_DBG("%s with the result %d", __func__, ret);
> +	return ret;
> +}
> +
> +/*
> + * Device instance removal
> + */
> +static int bcm_bt_uart_remove(struct platform_device *pdev)
> +{
> +	struct bcm_device *p_bcm_device =3D platform_get_drvdata(pdev);
> +
> +	if (p_bcm_device =3D=3D NULL) {

General preference is !pointer here.

IF: Will change.

> +		BT_DBG("%s - logic error, no probe?!", __func__);
> +		return 0;
> +	}
> +
> +	BT_DBG("%s %p context", __func__, p_bcm_device);
> +
> +	spin_lock(&device_list_lock);
> +	list_del(&p_bcm_device->list);
> +	spin_unlock(&device_list_lock);
> +
> +	BT_DBG("%s - freeing interrupt %d", __func__,
> +		p_bcm_device->bt_wake_irq);
> +	free_irq(p_bcm_device->bt_wake_irq, p_bcm_device);
> +
> +	if (p_bcm_device->reg_on_gpio) {
> +		BT_DBG("%s - releasing reg_on_gpio", __func__);
> +		gpiod_put(p_bcm_device->reg_on_gpio);
> +		p_bcm_device->reg_on_gpio =3D NULL;
> +	}
> +
> +	if (p_bcm_device->dev_wake_gpio) {
> +		BT_DBG("%s - releasing dev_wake_gpio", __func__);
> +		gpiod_put(p_bcm_device->dev_wake_gpio);
> +		p_bcm_device->dev_wake_gpio =3D NULL;
> +	}
> +
> +	if (p_bcm_device->bt_wake_gpio) {
> +		BT_DBG("%s - releasing bt_wake_gpio", __func__);
> +		gpiod_put(p_bcm_device->bt_wake_gpio);
> +		p_bcm_device->bt_wake_gpio =3D NULL;
> +	}
> +
> +	BT_DBG("%s %p done", __func__, p_bcm_device);
> +	return 0;
> +}
> +
> +/*
> + * Platform resume callback
> + */
> +static int bcm_bt_uart_resume(struct device *pdev)
> +{
> +	int gpio_value;
> +	struct bcm_device *p_bcm_device =3D platform_get_drvdata(
> +		to_platform_device(pdev));
> +
> +	if (p_bcm_device =3D=3D NULL) {
> +		BT_DBG("%s - logic error, no device?!", __func__);
> +		return 0;
> +	}
> +
> +	BT_DBG("%s %p", __func__, p_bcm_device);
> +
> +	gpio_value =3D !p_bcm_device->dev_wake_active_low;
> +	if (p_bcm_device->dev_wake_gpio) {
> +		gpiod_set_value(p_bcm_device->dev_wake_gpio, gpio_value);
> +		BT_DBG("%s - %d written, delaying 15 ms", __func__,
> +		       gpio_value);
> +		mdelay(15);
> +	}
> +
> +	/* Let the protocol know the platform is resuming */
> +	if (p_bcm_device->protocol_callbacks.p_resume)
> +		p_bcm_device->protocol_callbacks.p_resume(
> +			p_bcm_device->protocol_callbacks.context);
> +
> +	return 0;
> +}
> +
> +/*
> + * Platform suspend callback
> + */
> +static int bcm_bt_uart_suspend(struct device *pdev)
> +{
> +	int gpio_value;
> +	struct bcm_device *p_bcm_device =3D platform_get_drvdata(
> +		to_platform_device(pdev));
> +
> +	if (p_bcm_device =3D=3D NULL) {
> +		BT_DBG("%s - logic error, no device?!", __func__);
> +		return 0;
> +	}
> +
> +	BT_DBG("%s %p", __func__, p_bcm_device);
> +
> +	/* Let the protocol know the platform is suspending */
> +	if (p_bcm_device->protocol_callbacks.p_suspend)
> +		p_bcm_device->protocol_callbacks.p_suspend(
> +			p_bcm_device->protocol_callbacks.context);
> +
> +	/* Suspend the device */
> +	if (p_bcm_device->dev_wake_gpio) {
> +		gpio_value =3D !!p_bcm_device->dev_wake_active_low;
> +		gpiod_set_value(p_bcm_device->dev_wake_gpio, gpio_value);
> +		BT_DBG("%s - %d written, delaying 15 ms", __func__,
> +			gpio_value);
> +		mdelay(15);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Entry point for calls from the protocol
> + */
> +int btbcm_uart_control(int action, void *device_context,
> +	void *p_data, unsigned long *p_size)
> +{
> +	struct btbcm_uart_callbacks *pc;
> +	struct btbcm_uart_parameters *pp =3D p_data; /* for pars action only */
> +	int ret =3D 0;
> +	int gpio_value, poweron_flag;
> +	struct bcm_device *p_bcm_device =3D device_context;
> +	struct list_head *ptr;
> +	bool is_found =3D false;
> +
> +	/* Special processing for the callback configuration */
> +	if (action =3D=3D BTBCM_UART_ACTION_CONFIGURE_CALLBACKS) {
> +		pc =3D p_data;
> +
> +		BT_DBG("%s - configure callbacks", __func__);
> +		if (p_data =3D=3D NULL || *p_size !=3D sizeof(struct
> +		    btbcm_uart_callbacks) || (pc->interface_version !=3D
> +		    BTBCM_UART_INTERFACE_VERSION)) {
> +			BT_DBG("%s - callbacks mismatch!", __func__);
> +			return -E2BIG;
> +		}
> +
> +		BT_DBG("%s - configure callbacks for %s(%p)", __func__,
> +		       pc->name, pc->context);
> +		if (p_bcm_device =3D=3D NULL) {
> +			spin_lock(&device_list_lock);
> +			list_for_each(ptr, &device_list) {
> +				p_bcm_device =3D list_entry(ptr, struct
> +							  bcm_device, list);
> +				if (!strcmp(p_bcm_device->tty_name, pc->name)) {
> +					is_found =3D true;
> +					break;
> +				}
> +			}
> +
> +			spin_unlock(&device_list_lock);
> +			if (!is_found) {
> +				BT_DBG("%s - no device!", __func__);
> +				return -ENOENT;
> +			}
> +		}
> +
> +		p_bcm_device->protocol_callbacks =3D *pc;
> +		memcpy(p_data, &p_bcm_device, sizeof(p_bcm_device));
> +		*p_size =3D sizeof(p_bcm_device);
> +		return ret;
> +	}
> +
> +	/* All other requests must have the right context */
> +	if (p_bcm_device =3D=3D NULL) {
> +		BT_DBG("%s - failing, no device", __func__);
> +		return -ENOENT;
> +	}
> +
> +	switch (action) {
> +	case BTBCM_UART_ACTION_POWER_ON:
> +		BT_DBG("%s %p - power on", __func__, device_context);
> +		if (p_bcm_device->reg_on_gpio) {
> +			poweron_flag =3D !p_bcm_device->reg_on_active_low;
> +			gpiod_set_value(p_bcm_device->reg_on_gpio,
> +					poweron_flag);
> +			BT_DBG("%s - pwron %d, delay 15 ms", __func__,
> +			       poweron_flag);
> +			mdelay(15);
> +		}
> +		break;
> +
> +	case BTBCM_UART_ACTION_POWER_OFF:
> +		BT_DBG("%s %p - power off", __func__, device_context);
> +		if (p_bcm_device->reg_on_gpio) {
> +			poweron_flag =3D p_bcm_device->reg_on_active_low;
> +			gpiod_set_value(p_bcm_device->reg_on_gpio,
> +					poweron_flag);
> +			BT_DBG("%s - pwroff %d, delay 15 ms", __func__,
> +			       poweron_flag);
> +			mdelay(15);
> +		}
> +		break;
> +
> +	case BTBCM_UART_ACTION_RESUME:
> +		BT_DBG("%s %p - resume", __func__, device_context);
> +		if (p_bcm_device->dev_wake_gpio) {
> +			gpio_value =3D !p_bcm_device->dev_wake_active_low;
> +			gpiod_set_value(p_bcm_device->dev_wake_gpio,
> +					gpio_value);
> +			BT_DBG("%s - resume %d, delay 15 ms", __func__,
> +			       gpio_value);
> +			mdelay(15);
> +		}
> +		break;
> +
> +	case BTBCM_UART_ACTION_SUSPEND:
> +		BT_DBG("%s %p - suspend", __func__, device_context);
> +		if (p_bcm_device->dev_wake_gpio) {
> +			gpio_value =3D !!p_bcm_device->dev_wake_active_low;
> +			gpiod_set_value(p_bcm_device->dev_wake_gpio,
> +					gpio_value);
> +			BT_DBG("btbcm_uart_control - suspend %d, delay 15ms",
> +			       gpio_value);
> +			mdelay(15);
> +		}
> +		break;
> +
> +	case BTBCM_UART_ACTION_GET_PARAMETERS:
> +		BT_DBG("%s %p - get pars", __func__, device_context);
> +		if ((p_data =3D=3D NULL) ||
> +			(*p_size < sizeof(struct btbcm_uart_parameters))) {
> +			BT_DBG("%s - failing, wrong par size", __func__);
> +			return -E2BIG;
> +		}
> +
> +		memset(pp, 0, sizeof(struct btbcm_uart_parameters));
> +		pp->interface_version =3D BTBCM_UART_INTERFACE_VERSION;
> +		pp->configure_sleep =3D p_bcm_device->configure_sleep;
> +		pp->manual_fc =3D p_bcm_device->manual_fc;
> +		pp->dev_wake_active_low =3D p_bcm_device->dev_wake_active_low;
> +		pp->bt_wake_active_low =3D p_bcm_device->bt_wake_active_low;
> +		pp->idle_timeout_in_secs =3D idle_timeout;
> +		pp->oper_speed =3D p_bcm_device->oper_speed;
> +		pp->configure_audio =3D p_bcm_device->configure_audio;
> +		pp->pcm_clockmode =3D p_bcm_device->pcm_clockmode;
> +		pp->pcm_fillmethod =3D p_bcm_device->pcm_fillmethod;
> +		pp->pcm_fillnum =3D p_bcm_device->pcm_fillnum;
> +		pp->pcm_fillvalue =3D p_bcm_device->pcm_fillvalue;
> +		pp->pcm_incallbitclock =3D p_bcm_device->pcm_incallbitclock;
> +		pp->pcm_lsbfirst =3D p_bcm_device->pcm_lsbfirst;
> +		pp->pcm_rightjustify =3D p_bcm_device->pcm_rightjustify;
> +		pp->pcm_routing =3D p_bcm_device->pcm_routing;
> +		pp->pcm_shortframesync =3D p_bcm_device->pcm_shortframesync;
> +		pp->pcm_syncmode =3D p_bcm_device->pcm_syncmode;
> +		*p_size =3D sizeof(struct btbcm_uart_parameters);
> +		break;
> +
> +	default:
> +		BT_DBG("%s %p unknown act %d", __func__,
> +		       device_context, action);
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(btbcm_uart_control);

I am not okay with having one bug exported symbol that does everything. Thi=
s is the kernel and we can export each function individually. No need to ha=
ve this massive single point of entry. So please split these out.

IF: Okay, will change.

> +
> +/* Platform susp and resume callbacks */
> +static SIMPLE_DEV_PM_OPS(bcm_bt_uart_pm_ops,

I think bcm_uart_pm_ops is enough.

IF: Will change.

> +	bcm_bt_uart_suspend, bcm_bt_uart_resume);

Alignment is wrong here.

IF: Will change.

> +
> +/* Driver match table */
> +static const struct of_device_id bcm_bt_uart_table[] =3D {

Remove the bt here. I think bcm_uart_table is enough.

IF: will do.

> +	{ .compatible =3D "brcm,brcm-bt-uart" },
> +	{}
> +};
> +
> +/* Driver configuration */
> +static struct platform_driver bcm_bt_uart_driver =3D {

Just call it bcm_uart_driver.

IF: Okay.

> +	.probe =3D bcm_bt_uart_probe,
> +	.remove =3D bcm_bt_uart_remove,
> +	.driver =3D {
> +		.name =3D "brcm_bt_uart",

Matching up with our naming, this should be "btbcm_uart" or "bt_bcm_uart".

IF: This should match with the "compatible" string that we must keep with t=
he "brcm" prefix.

> +		.of_match_table =3D of_match_ptr(bcm_bt_uart_table),
> +		.owner =3D THIS_MODULE,
> +		.pm =3D &bcm_bt_uart_pm_ops,
> +	},
> +};

In general it is .name<tab>=3D<space>value,

IF: Okay, will change.

> +
> +module_platform_driver(bcm_bt_uart_driver);
> +
> +MODULE_AUTHOR("Ilya Faenson");

Preference is to include the email address in the author information.

IF: Will do.

> +MODULE_DESCRIPTION("Broadcom Bluetooth UART Driver");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/drivers/bluetooth/btbcm_uart.h b/drivers/bluetooth/btbcm_uar=
t.h
> new file mode 100644
> index 0000000..fbc7285
> --- /dev/null
> +++ b/drivers/bluetooth/btbcm_uart.h
> @@ -0,0 +1,89 @@
> +/*
> + *  Bluetooth BCM UART Driver Header
> + *
> + *  Copyright (c) 2015 Broadcom Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef BTBCM_UART_H
> +#define BTBCM_UART_H

Remove these since we do not do these includes guards for local includes in=
 drivers/bluetooth/.

IF: Okay.

> +
> +/* Change the version if you change anything in this header */
> +#define BTBCM_UART_INTERFACE_VERSION 1

No idea why we need this. There is no external consumer of this. Please get=
 rid of this.

IF: Okay.

> +/* Callbacks from the driver into the protocol */
> +typedef void (*p_suspend_callback)(void *context);
> +typedef void (*p_resume_callback)(void *context);
> +typedef void (*p_wakeup_callback)(void *context);

I do not see the need for these typedefs.

IF: Okay.

> +struct btbcm_uart_callbacks {
> +	int interface_version; /* interface # compiled against */

Get rid of this.

IF: Okay.

> +	void *context;         /* protocol instance context */
> +	char name[64];         /* protocol tty device, for example, ttyS0 */
> +
> +	/* client callbacks */
> +	p_suspend_callback p_suspend;
> +	p_resume_callback p_resume;
> +	p_wakeup_callback p_wakeup;

Just spell these out here.

IF: Okay.

> +};
> +
> +/* Driver parameters retrieved from the DT or ACPI */
> +struct btbcm_uart_parameters {
> +	int interface_version; /* interface # compiled against */

Get rid of this as well.

IF: Okay.

> +
> +	/* Parameters themselves */
> +	bool configure_sleep;
> +	int manual_fc;
> +	int dev_wake_active_low;
> +	int bt_wake_active_low;
> +	int idle_timeout_in_secs;
> +	int oper_speed;
> +	bool configure_audio;
> +	int pcm_clockmode;
> +	int pcm_fillmethod;
> +	int pcm_fillnum;
> +	int pcm_fillvalue;
> +	int pcm_incallbitclock;
> +	int pcm_lsbfirst;
> +	int pcm_rightjustify;
> +	int pcm_routing;
> +	int pcm_shortframesync;
> +	int pcm_syncmode;
> +};
> +
> +/*
> + * Actions on the BTBCM_UART driver
> + */
> +
> +/* Configure protocol callbacks */
> +#define BTBCM_UART_ACTION_CONFIGURE_CALLBACKS 0
> +
> +/* Retrieve BT device parameters */
> +#define BTBCM_UART_ACTION_GET_PARAMETERS      1
> +
> +/* Resume the BT device via GPIO */
> +#define BTBCM_UART_ACTION_RESUME              2
> +
> +/* Suspend the BT device via GPIO */
> +#define BTBCM_UART_ACTION_SUSPEND             3
> +
> +/* Power the BT device off via GPIO */
> +#define BTBCM_UART_ACTION_POWER_OFF           4
> +
> +/* Power the BT device on via GPIO */
> +#define BTBCM_UART_ACTION_POWER_ON            5
> +
> +/* Execute an action on the BT device */
> +extern int btbcm_uart_control(int action, void *device_context,
> +			      void *p_data, unsigned long *p_size);
> +
> +#endif

Regards

Marcel
