Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 11:24:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: ramm@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: Fix Device Scan and connection collision
Message-ID: <20120718082410.GA10318@x220.ger.corp.intel.com>
References: <1342596961-3446-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342596961-3446-1-git-send-email-ramm@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ram,

On Wed, Jul 18, 2012, ramm@ti.com wrote:
> During search of devices, HCI Remote Name Request Command is sent for
> every device which name was not included in inquiry result. But the
> same command is also sent during incoming connection establishing
> procedure. Function hci_check_pending_name() was fixed in order to
> handle this situation which led to a kernel crash when initiating
> an incoming connection from a device that was not found in the
> inquiry while doing a search. There is no need to continue resolving
> the next name if we get the request from the incoming connection
> procedure as it will be done upon receiving another remote name
> request complete event
> 
> Signed-off-by: Ram Malovany <ramm@ti.com>
> ---
>  net/bluetooth/hci_event.c |   21 ++++++++++++++-------
>  1 files changed, 14 insertions(+), 7 deletions(-)

The fixes in this patch seem correct to me but there seems to be three
of them and each one could be considered independently. I'd therefore
split this into three separate patches:

>  	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
> -	if (hci_resolve_name(hdev, e) == 0) {
> +	if (e && hci_resolve_name(hdev, e) == 0) {
>  		e->name_state = NAME_PENDING;
>  		return true;
>  	}

This missing NULL check is the first fix. You might actually consider
doing:

	if (!e)
		return false;

	...

>  	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
> -	if (e) {
> +	if (!e)
> +		return;

This is the second fix. Since it's not directly clear why it's safe to
risk not setting DISCOVERY_STOPPED in this case I'd also add a code
comment explaining it (that if there's no matching entry in the cache it
must mean that there's another pending command ongoing which we can
safely wait for).

> +	} else {
> +		e->name_state = NAME_NOT_KNOWN;
>  	}

This missing setting back to NAME_NOT_KNOWN when name resolving fails is
the third fix.

Please let me know if I misunderstood something or if some of these
fixes really must go into the same patch (e.g. if applying just one of
them will make the code more broken than it is now).

Johan
