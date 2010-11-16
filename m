Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 16:24:12 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCHv3 5/7] Add approval request for incoming pairing
 requests with OOB mechanism
Message-ID: <20101116162412.GB3638@jh-x301>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com>
 <1289922247-20712-6-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289922247-20712-6-git-send-email-szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 16, 2010, Szymon Janc wrote:
> +	if (!device_has_oob_data(device)
> +			|| btd_event_user_approve(&BDADDR(index), dba))

That should be:

if (!device_has_oob_data(device) ||
			btd_event_user_approve(&BDADDR(index), dba) < 0)

Otherwise it looks like btd_event_user_approve might return a boolean.

> +	req->msg = dbus_message_new_method_call(agent->name, agent->path,
> +				"org.bluez.Agent", "RequestApproval");

I think the name of this method is one of the more important things to
get right before we push this upstream. I'm not so sure of the current
proposal. I have a feeling that it'd be a good idea to have the term
"pair" somewhere explicitly in the name. How about "RequestPairing"? I
know Marcel will have something to say about this too.

Johan
