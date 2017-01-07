Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1483798314.26691.3.camel@linux.intel.com>
Subject: Re: [PATCH 8/9] serdev: add a tty port controller driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri
 Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter
 Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>,
	NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Sat, 07 Jan 2017 16:11:54 +0200
In-Reply-To: <20170106162635.19677-9-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
	 <20170106162635.19677-9-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:
> Add a serdev controller driver for tty ports.
> 
> The controller is registered with serdev when tty ports are registered
> with the TTY core. As the TTY core is built-in only, this has the side
> effect of making serdev built-in as well.
> 
> 

> +if SERIAL_DEV_BUS
> +
> +config SERIAL_DEV_CTRL_TTYPORT
> +	bool "Serial device TTY port controller"
> +	depends on TTY

> +	depends on SERIAL_DEV_BUS=y

Do you need one?


> +static int ttyport_receive_buf(struct tty_port *port, const unsigned
> char *cp,
> +				const unsigned char *fp, size_t
> count)
> +{
> +	struct serdev_controller *ctrl = port->client_data;
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +
> +	mutex_lock(&serport->lock);
> +
> +	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> +		goto out;
> +
> +	serdev_controller_receive_buf(ctrl, cp, count);
> +
> +out:

out_unlock: ?

> +	mutex_unlock(&serport->lock);
> +	return count;
> +}
> +
> +static void ttyport_write_wakeup(struct tty_port *port)
> +{
> +	struct serdev_controller *ctrl = port->client_data;
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +
> +	clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags);

This doesn't prevent to be called this function in parallel. Is it okay?

> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		serdev_controller_write_wakeup(ctrl);
> +}

> +
> +static int ttyport_write_buf(struct serdev_controller *ctrl, const
> unsigned char *data, size_t len)
> +{
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty = serport->tty;
> +
> +	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> +	return serport->tty->ops->write(serport->tty, data, len);

Just tty->ops->...(); ?

> +}



> +int serdev_tty_port_register(struct tty_port *port, struct device
> *parent,
> +			    struct tty_driver *drv, int idx)
> +{
> +	struct serdev_controller *ctrl;
> +	struct serport *serport;
> +	int ret;
> +
> +	if (!port || !drv || !parent || !parent->of_node)

And if it's ACPI? Perhaps last is redundant.

> +		return -ENODEV;
> +
> +	ctrl = serdev_controller_alloc(parent, sizeof(struct
> serport));
> +	if (!ctrl)
> +		return -ENOMEM;
> +	serport = serdev_controller_get_drvdata(ctrl);
> +
> +	mutex_init(&serport->lock);
> +	serport->port = port;
> +	serport->tty_idx = idx;
> +	serport->tty_drv = drv;
> +
> +	ctrl->ops = &ctrl_ops;
> +
> +	ret = serdev_controller_add(ctrl);
> +	if (ret)
> +		goto err;
> +
> +	printk(KERN_INFO "serdev: Serial port %s\n", drv->name);

Hmm... It's not a debug message, why not use pr_info()?

> +	return 0;
> +
> +err:

err_controller_put: ?

> +	serdev_controller_put(ctrl);
> +	return ret;
> +}
> +
> +void serdev_tty_port_unregister(struct tty_port *port)
> +{
> +	struct serdev_controller *ctrl = port->client_data;
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +
> 

> +	if (!serport)
> +		return;

Same question, whose responsibility to do this?


+
> +#ifdef CONFIG_SERIAL_DEV_CTRL_TTYPORT
> +int serdev_tty_port_register(struct tty_port *port, struct device
> *parent,
> +			    struct tty_driver *drv, int idx);
> +void serdev_tty_port_unregister(struct tty_port *port);
> +#else
> +static inline int serdev_tty_port_register(struct tty_port *port,
> +					   struct device *parent,
> +					   struct tty_driver *drv,
> int idx)
> +{
> +	return -ENODEV;
> +}
> +static inline void serdev_tty_port_unregister(struct tty_port *port)
> {}

> +#endif

Perhaps comment to see from which if this one.

> +
>  #endif

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
