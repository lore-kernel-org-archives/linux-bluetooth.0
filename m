Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2014 10:25:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] core: don't set BR/EDR support when no flags present
Message-ID: <20140404072528.GA16753@t440s.lan>
References: <CAHZ1yCmu26xibOaeGUP3HGhp7cvC0eXuviJBRq2VDD0fE6U6SQ@mail.gmail.com>
 <1396564054-20566-1-git-send-email-scott@netsplit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396564054-20566-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Thu, Apr 03, 2014, Scott James Remnant wrote:
> The logic for setting the BR/EDR supported flag checked for the
> non-presence of the BR/EDR Unsupported flag without checking whether
> any flags were present at all.
> 
> This meant all LE-only devices that returned Scan Response Data were
> being marked as supporting BR/EDR, since the flag was only set in the
> initial AD and not the SRD.
> ---
>  src/adapter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index e396a3d..b8b9a9c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4342,7 +4342,8 @@ static void update_found_devices(struct btd_adapter *adapter,
>  
>  	device_update_last_seen(dev, bdaddr_type);
>  
> -	if (bdaddr_type != BDADDR_BREDR && !(eir_data.flags & EIR_BREDR_UNSUP))
> +	if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
> +					!(eir_data.flags & EIR_BREDR_UNSUP))
>  		device_set_bredr_support(dev, true);
>  
>  	if (eir_data.name != NULL && eir_data.name_complete)

Both patches have been applied. Thanks.

One thing to note regarding this first one: this is actually not a
problem with current bluetooth-next since there we merge the adv_ind and
scan_rsp into a single mgmt device found event. I.e. with such a kernel
we will not need to have this extra non-zero flags check. I added an
extra code comment to this place so we don't forget to fix it.

Johan
