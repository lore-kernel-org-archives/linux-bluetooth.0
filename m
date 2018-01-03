Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1514995927.7000.582.camel@linux.intel.com>
Subject: Re: [PATCH v2 10/10] Bluetooth: hci_bcm: Support Apple GPIO handling
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Frederic Danis
 <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy
 <leif.liddy@gmail.com>,  Daniel Roschka <danielroschka@phoenitydawn.de>,
 Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang"
 <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
Date: Wed, 03 Jan 2018 18:12:07 +0200
In-Reply-To: <477d9c5294b1d1df06942cd1c30238d91d900253.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
	 <477d9c5294b1d1df06942cd1c30238d91d900253.1514916630.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2018-01-02 at 20:08 +0100, Lukas Wunner wrote:
> Enable Bluetooth on the following Macs which provide custom ACPI
> methods
> to toggle the GPIOs for device wake and shutdown instead of accessing
> the pins directly:

> +static inline int bcm_apple_get_resources(struct bcm_device *dev)
> +{ return -EOPNOTSUPP; }
> +static inline int bcm_apple_set_power(struct bcm_device *dev, bool
> powered)
> +{ return -EOPNOTSUPP; }
> +static inline int bcm_apple_set_low_power(struct bcm_device *dev,
> bool enable)
> +{ return -EOPNOTSUPP; }
> 

Might be a silly question but can we create some struct with callbacks
and assign it differently based on Apple / non-Apple cases?

In that case you don't need conditionals to call (you will always have
them defined to something).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
