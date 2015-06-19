Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1434576658-20730-2-git-send-email-ifaenson@broadcom.com>
References: <1434576658-20730-1-git-send-email-ifaenson@broadcom.com>
	<1434576658-20730-2-git-send-email-ifaenson@broadcom.com>
Date: Fri, 19 Jun 2015 16:23:10 -0300
Message-ID: <CAOMZO5BrLeqW=dDJbyqkQGKe68dfGduLNE0ab2KpL9C1qS6unQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Broadcom Bluetooth UART Device Tree bindings
From: Fabio Estevam <festevam@gmail.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Arend van Spriel <arend@broadcom.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 17, 2015 at 6:30 PM, Ilya Faenson <ifaenson@broadcom.com> wrote:

> +Optional properties:
> +
> +  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an interrupt.
> +
> +  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume device.
> +
> +  - bt-reg-on-gpios : reg-on output GPIO to be used to power device on/off.

Shouldn't this be modelled as a regulator instead? What if the board
drives a PMIC output to provide power to the BT interface?
