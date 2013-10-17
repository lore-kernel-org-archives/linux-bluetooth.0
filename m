Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 14:53:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 2/7] android: Implement read_info_complete callback
Message-ID: <20131017115307.GB19836@x220.p-661hnu-f1>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381998406-16662-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381998406-16662-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 17, 2013, Andrei Emeltchenko wrote:
> +static void read_info_complete(uint8_t status, uint16_t length, const void *param,
> +							void *user_data)
> +{
> +	struct bt_adapter *adapter = user_data;
> +	const struct mgmt_rp_read_info *rp = param;
> +
> +	DBG("");
> +
> +	if (status) {
> +		error("Failed to read info for index %u: %s (0x%02x)",
> +			0, mgmt_errstr(status), status);
> +		goto failed;
> +	}
> +
> +	if (length < sizeof(*rp)) {
> +		error("Too small read info complete response");
> +		goto failed;
> +	}
> +
> +	if (!bacmp(&rp->bdaddr, BDADDR_ANY)) {
> +		error("No Bluetooth address");
> +		goto failed;
> +	}
> +
> +	/* Store adapter information */
> +	bacpy(&adapter->bdaddr, &rp->bdaddr);
> +	adapter->dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
> +						(rp->dev_class[2] << 16);
> +	adapter->name = g_strdup((const char *) rp->name);
> +
> +	adapter->supported_settings = btohs(rp->supported_settings);
> +	adapter->current_settings = btohs(rp->current_settings);
> +
> +	/* TODO: Register all event notification handlers */
> +
> +	if (adapter->current_settings & MGMT_SETTING_POWERED)
> +		bt_adapter_start(adapter);
> +
> +	load_link_keys(adapter, NULL);
> +
> +	return;
> +
> +failed:
> +	default_adapter = NULL;
> +}

This way of setting a variable in main.c to NULL without any other way
of notifying failure seems a bit messed up to me. You'll probably just
want to keep the adapter pointer private (static) to adapter.c.

>From where were you planning to initialize the UNIX socket towards the
HAL? I suppose it makes sense to do that once you've completed the basic
init with the read_info, load_link_keys, etc. If you want adapter.c to
do that there's not much needed, but if you need to notify back to
main.c you'll probably need some kind of callback mechanism.

Johan
