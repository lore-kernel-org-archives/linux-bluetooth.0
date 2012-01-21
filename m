Return-Path: <cyrus@holtmann.org>
Message-ID: <1327163781.1955.48.camel@aeonflux>
Subject: Re: [RFC PATCH 2/3] agent: add DisplayPinCode method
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Date: Sat, 21 Jan 2012 17:36:21 +0100
In-Reply-To: <1327100744-28782-3-git-send-email-scott@netsplit.com>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
	 <1327100744-28782-3-git-send-email-scott@netsplit.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> Add a second notification type that requests the agent displays a
> string PinCode rather than the numeric Passkey.
> ---
>  doc/agent-api.txt |   12 ++++++++++++
>  src/agent.c       |   27 +++++++++++++++++++++++++++
>  src/agent.h       |    2 ++
>  src/device.c      |   24 ++++++++++++++++--------
>  src/device.h      |    5 +++--
>  src/event.c       |   10 +++++-----
>  test/simple-agent |    5 +++++
>  7 files changed, 70 insertions(+), 15 deletions(-)

as a general rule, please split documentation patches from actual
implementation. That way we can do API review a lot simpler.

Same applies to code and test scripts.

> diff --git a/doc/agent-api.txt b/doc/agent-api.txt
> index 9ab2063..0b32d70 100644
> --- a/doc/agent-api.txt
> +++ b/doc/agent-api.txt
> @@ -61,6 +61,18 @@ Methods		void Release()
>  			so the display should be zero-padded at the start if
>  			the value contains less than 6 digits.
>  
> +		void DisplayPinCode(object device, string pincode)
> +
> +			This method gets called when the service daemon
> +			needs to display a pincode for an authentication.
> +
> +			An empty reply should be returned. When the pincode
> +			needs no longer to be displayed, the Cancel method
> +			of the agent will be called.
> +
> +			During the pairing process this method might be
> +			called multiple times to update the entered value.
> +

I am a little bit concerned here since we are using legacy pairing. I
have not looked at the implementation, but I think we should only reply
with the random PIN code to the controller once this method got returned
with a positive reply.

And in addition I prefer if we handle a negative/reject or non reply at
all to make this work with older agents as well. That way the core can
fallback to just RequestPinCode if this gets rejected.

In addition to that, I am not sure we can actually nicely emulate the
"entered" feature from SSP. I know you mentioned that Apple does
something like this, but it is nowhere near a standard. So do we really
wanna call this method multiple times or just accept that it will be
only called once and if it gets rejected, we fall back to requesting the
PIN code.

Regards

Marcel


