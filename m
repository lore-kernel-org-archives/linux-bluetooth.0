Return-Path: <cyrus@holtmann.org>
Message-ID: <1392714551.5951.275.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH BlueZ 8/8] doc/obex-api: Update documentation
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 18 Feb 2014 10:09:11 +0100
In-Reply-To: <1392393184-15266-8-git-send-email-luiz.dentz@gmail.com>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
	 <1392393184-15266-8-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2014-02-14 at 17:53 +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds Suspend and Resume methods and 'suspended' value as status in
> the Transfer interface documentation.
> ---
>  doc/obex-api.txt | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index 1f22fea..0f57ce1 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -90,12 +90,26 @@ Methods		void Cancel()
>  					 org.bluez.obex.Error.InProgress
>  					 org.bluez.obex.Error.Failed
>  
> +		void Suspend()
> +
> +			Suspend transference.
> +
> +			Possible errors: org.bluez.obex.Error.NotAuthorized
> +					 org.bluez.obex.Error.NotInProgress
> +
> +		void Resume()
> +
> +			Resume transference.
> +
> +			Possible errors: org.bluez.obex.Error.NotAuthorized
> +					 org.bluez.obex.Error.NotInProgress
                                                                ^^^^^^^^^^^^^

Should this be a NotSuspended error? Or is it not an error to resume a
transfer which is currently not suspended?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


