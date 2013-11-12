Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 15:09:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v2 3/3] android: Change TODO with explaining comment
Message-ID: <20131112130955.GB22931@x220.p-661hnu-f1>
References: <1384260700-16621-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1384260700-16621-4-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384260700-16621-4-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Nov 12, 2013, Lukasz Rymanowski wrote:
> ---
>  android/adapter.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index a59ab4e..ac1ebc2 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -515,7 +515,10 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
>  
>  	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
>  
> -	/* TODO name and CoD of remote devices should probably be cached */
> +	/* It is ok to have empty name and CoD of remote devices here since
> +	* those information has been already provided on device_connected event
> +	* or during device scaning. Android will use that instead.
> +	*/
>  	memset(&hal_ev, 0, sizeof(hal_ev));
>  	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);

Have you considered security mode 3 devices? There you will get a pin
code request before you get a device_connected. You can even try this
yourself by doing "hciconfig hci0 auth" before attempting to pair. That
said, I'm not sure if there is anything we can do better regarding such
devices, but at least we should keep this use case in mind.

Johan
