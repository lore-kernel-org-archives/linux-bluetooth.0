Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Feb 2014 14:41:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Handle MGMT_SETTING_LE change
Message-ID: <20140213124134.GA13866@x220.p-661hnu-f1>
References: <20140213014521.59803100423@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140213014521.59803100423@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Wed, Feb 12, 2014, Petri Gynther wrote:
> On some BLE-capable adapters, BLE is not enabled by default. When BLE is
> enabled after the adapter is already powered up, we need to call
> trigger_passive_scanning() so that paired BLE devices (e.g. HoG devices)
> are able to reconnect back to host.

No dual-mode adapter should have LE enabled by default and we do have
the following piece of code that gets run for any newly discovered
adapter:

        if ((adapter->supported_settings & MGMT_SETTING_LE) &&
                        !(adapter->current_settings & MGMT_SETTING_LE))
                set_mode(adapter, MGMT_OP_SET_LE, 0x01);

So the commit message is a bit confusing to me. How exactly do you end
up reproducing this scenario? I could imagine this maybe happening if
bluetoothd crashes and gets restarted when the adapter state is already
powered on. Either way you should explain this in the commit message.

> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -405,6 +405,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
>  static void trigger_pairable_timeout(struct btd_adapter *adapter);
>  static void adapter_start(struct btd_adapter *adapter);
>  static void adapter_stop(struct btd_adapter *adapter);
> +static void trigger_passive_scanning(struct btd_adapter *adapter);

Since we try to avoid forward declarations like this whenever possible, did you
investigate what would be needed to not need it here. I.e. is it really
a lot of dependent functions that would need to be moved further up
together with trigger_passive_scanning() or is there even a circular
dependency somewhere that makes the forward declaration inevitable?

> +	if (changed_mask & MGMT_SETTING_LE) {
> +		if ((adapter->current_settings & MGMT_SETTING_POWERED) &&
> +		    (adapter->current_settings & MGMT_SETTING_LE)) {
> +			trigger_passive_scanning(adapter);
> +		}
> +	}

The { } isn't needed for the internal if-statement.

Johan
