Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Add RequestSecurePinCode to agent API
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 09 Jun 2011 12:24:19 +0200
In-Reply-To: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1307615061.2589.36.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> The method is called if min. 16 bytes pincode is mendatory
> to authenticate connection.
> 
> In practice this will be called only with mgmtops switched on. Hciops
> don't support secure pin code so far.
> ---
>  doc/agent-api.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/agent-api.txt b/doc/agent-api.txt
> index 9ab2063..b1cb354 100644
> --- a/doc/agent-api.txt
> +++ b/doc/agent-api.txt
> @@ -31,6 +31,17 @@ Methods		void Release()
>  			Possible errors: org.bluez.Error.Rejected
>  			                 org.bluez.Error.Canceled
>  
> +		string RequestSecurePinCode(object device)
> +
> +			This method gets called when the service daemon
> +			needs to get the secure passkey for an authentication.
> +
> +			The return value should be a string of 16 characters
> +			length. The string can be alphanumeric.
> +
> +			Possible errors: org.bluez.Error.Rejected
> +			                 org.bluez.Error.Canceled
> +

I do not like this since it is really legacy stuff and makes since
really complicated. And now we are making big efforts to support this
and that is bad. Since Simple Pairing solved this nicely for us.

However I need to talk with Johan about this and figure something out.

Regards

Marcel


