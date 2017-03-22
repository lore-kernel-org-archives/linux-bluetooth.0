Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170321223216.11733-10-sre@kernel.org>
References: <20170321223216.11733-1-sre@kernel.org> <20170321223216.11733-10-sre@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 22 Mar 2017 16:26:28 -0500
Message-ID: <CAL_Jsq+UXxocmpSJwJ8dVY0ZSLn1Rk+GfTRKP7Wqvo-_cE4qPg@mail.gmail.com>
Subject: Re: [PATCHv2 09/11] Bluetooth: add nokia driver
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 21, 2017 at 5:32 PM, Sebastian Reichel <sre@kernel.org> wrote:
> This adds a driver for the Nokia H4+ protocol, which is used
> at least on the Nokia N9, N900 & N950.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---

> +       btdev->wakeup_host = devm_gpiod_get(dev, "host-wakeup", GPIOD_IN);
> +       if (IS_ERR(btdev->wakeup_host)) {
> +               err = PTR_ERR(btdev->wakeup_host);
> +               dev_err(dev, "could not get host wakeup gpio: %d", err);
> +               return err;
> +       }
> +
> +       btdev->wake_irq = gpiod_to_irq(btdev->wakeup_host);

Missed this in the binding review, but generally, we make these
interrupts rather than gpios in the binding.

> +
> +       err = devm_request_threaded_irq(dev, btdev->wake_irq, NULL,
> +               wakeup_handler,
> +               IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +               "wakeup", btdev);
> +       if (err) {
> +               dev_err(dev, "could request wakeup irq: %d", err);
> +               return err;
> +       }
