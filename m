Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 14:56:49 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 1/2] Add RequestSecurePinCode to agent API
Message-ID: <20110608175648.GA13036@joana>
References: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2011-06-08 16:05:19 +0200]:

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

Why RequestPinCode() isn't enough? It can accept up to 16 characters.
Alternatively we can add a Property to tell when to use pin code or not.

For BlueZ 5.0 we can break this and add a length param to RequestPinCode().

	Gustavo
