Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 16:33:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5] Fix disconnect devices after enabling offline mode
Message-ID: <20110601133352.GA6226@dell.ger.corp.intel.com>
References: <1306933988-23209-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306933988-23209-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Jun 01, 2011, Rafal Michalski wrote:
> Previously paired and connected devices were disconnected automatically
> after turning bluetooth off directly via bluetooth UI. This patch makes
> that also other ways of turning bluetooth off (which should lead to
> disconnecting paired and connected devices), such as enabling offline
> mode (which turns bluetooth off as well), can be handled properly.
> ---
>  src/adapter.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)

Thanks. The patch has now been pushed upstream with one more minor
change:

> +	if (adapter->connections) {
> +		g_slist_foreach(adapter->connections,
> +				(GFunc) device_request_disconnect, NULL);
> +
> +		adapter->off_timer = g_timeout_add_seconds(OFF_TIMER,
> +					switch_off_timeout, adapter);
> +
> +		return 0;
> +	}
> +
>  	return adapter_ops->set_powered(adapter->dev_id, FALSE);
>  }

I switched this around to:

	if (adapter->connections == NULL)
		return adapter_ops->set_powered(adapter->dev_id, FALSE);
	...

It makes it bit more readable.

Johan
