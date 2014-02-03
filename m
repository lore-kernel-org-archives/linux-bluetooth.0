Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Feb 2014 15:19:36 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/pan: Fix control state change callback
 parameters order
Message-ID: <20140203131935.GG2930@aemeltch-MOBL1>
References: <1390484367-6332-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390484367-6332-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Thu, Jan 23, 2014 at 03:39:25PM +0200, Ravi kumar Veeramally wrote:
> Callback declared in bt_pan.h is
> 'typedef void (*btpan_control_state_callback)
> (btpan_control_state_t state, bt_status_t error, int local_role,
> const char* ifname);
> 
> But PanService.Java defined it wrong way.
> private void onControlStateChanged(int local_role, int state,
> int error, String ifname).
> First and third parameters are misplaced, so sending data according
> to PanService.Java, discard this fix if issue fixed in PanService.Java.
> ---
>  android/hal-pan.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/android/hal-pan.c b/android/hal-pan.c
> index 8c0f8d8..a596ffd 100644
> --- a/android/hal-pan.c
> +++ b/android/hal-pan.c
> @@ -45,9 +45,18 @@ static void handle_ctrl_state(void *buf, uint16_t len)
>  {
>  	struct hal_ev_pan_ctrl_state *ev = buf;
>  
> +	/* FIXME: Callback declared in bt_pan.h is 'typedef void
> +	 * (*btpan_control_state_callback)(btpan_control_state_t state,
> +	 * bt_status_t error, int local_role, const char* ifname);
> +	 * But PanService.Java defined it wrong way.
> +	 * private void onControlStateChanged(int local_role, int state,
> +	 * int error, String ifname).
> +	 * First and third parameters are misplaced, so sending data according
> +	 * to PanService.Java, fix this if issue fixed in PanService.Java.

Just noticed that bluedroid use this with different combination of
arguments :)

callback.control_state_cb(state, btpan_role, status, TAP_IF_NAME);

How this ended up working? Maybe because only error and last argument are
important at this moment.

Best regards 
Andrei Emeltchenko 


> +	 */
>  	if (cbs->control_state_cb)
> -		cbs->control_state_cb(ev->state, ev->status,
> -					ev->local_role, (char *)ev->name);
> +		cbs->control_state_cb(ev->local_role, ev->state, ev->status,
> +							(char *)ev->name);
>  }
>  
>  /* handlers will be called from notification thread context,
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
