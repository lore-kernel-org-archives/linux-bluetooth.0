Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Mar 2010 10:39:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] Check modem_obj_path is not NULL
Message-ID: <20100329073957.GA20677@jh-x301>
References: <1269894774-3193-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269894774-3193-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Mon, Mar 29, 2010, Forrest Zhao wrote:
> This could prevent crash in case modem_obj_path is NULL.
> ---
>  audio/telephony-ofono.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
> index 45c3905..c145e87 100644
> --- a/audio/telephony-ofono.c
> +++ b/audio/telephony-ofono.c
> @@ -281,6 +281,10 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
>  
>  	debug("telephony-ofono: dial request to %s", number);
>  
> +	if (!modem_obj_path)
> +		telephony_dial_number_rsp(telephony_device,
> +					CME_ERROR_AG_FAILURE);
> +
>  	if (!strncmp(number, "*31#", 4)) {
>  		number += 4;
>  		clir = "enabled";
> @@ -311,6 +315,10 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
>  
>  	debug("telephony-ofono: transmit dtmf: %c", tone);
>  
> +	if (!modem_obj_path)
> +		telephony_transmit_dtmf_rsp(telephony_device,
> +					CME_ERROR_AG_FAILURE);
> +
>  	tone_string = g_strdup_printf("%c", tone);
>  	ret = send_method_call(OFONO_BUS_NAME, modem_obj_path,

This doesn't look right. You report an error but still proceed in the
functions (which will later try to access modem_obj_path). I guess you
should return from the functions in both of these if-clauses.

Johan
