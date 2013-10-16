Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 13:31:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/6] android: Add adapter and device struct for BlueZ
 daemon
Message-ID: <20131016103140.GD14764@x220.p-661hnu-f1>
References: <1381913215-17957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381913215-17957-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381913215-17957-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 16, 2013, Andrei Emeltchenko wrote:
> +struct bt_adapter {
> +	struct mgmt *mgmt;
> +	bdaddr_t bdaddr;
> +	uint32_t dev_class;
> +
> +	char *name;
> +
> +	uint32_t supported_settings;
> +	uint32_t current_settings;
> +
> +	GList *found_devices;
> +};

Please don't add variables this way if you don't have code that actually
uses them at least later in the patch set. Just add them when they
eventually are needed.

> +struct bt_device {
> +	bdaddr_t bdaddr;
> +	uint8_t bdaddr_type;
> +	uint32_t cod;
> +	char *name;
> +};

Same thing here.

Johan
