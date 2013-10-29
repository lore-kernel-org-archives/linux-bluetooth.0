Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Oct 2013 12:27:24 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/5] android/hal: Add support for handling bond state
 change event
Message-ID: <20131029102722.GB27517@aemeltch-MOBL1>
References: <1383041789-28360-1-git-send-email-szymon.janc@tieto.com>
 <1383041789-28360-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383041789-28360-3-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 29, 2013 at 11:16:27AM +0100, Szymon Janc wrote:
> ---
>  android/hal-bluetooth.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> index 5f6dcbe..067f420 100644
> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -68,6 +68,17 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
>  	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
>  }
>  
> +static void handle_bond_state_change(void *buf)
> +{
> +	struct hal_ev_bond_state_changed *ev = buf;
> +	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
> +
> +	if (!bt_hal_cbacks->bond_state_changed_cb)
> +		return;
> +
> +	bt_hal_cbacks->bond_state_changed_cb(ev->status, addr, ev->state);

We shall use the same style like for other callbacks.

Best regards 
Andrei Emeltchenko 

> +}
> +
>  void bt_thread_associate(void)
>  {
>  	if (bt_hal_cbacks->thread_evt_cb)
> @@ -98,6 +109,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
>  	case HAL_EV_ADAPTER_PROPS_CHANGED:
>  		handle_adapter_props_changed(buf, len);
>  		break;
> +	case HAL_EV_BOND_STATE_CHANGED:
> +		handle_bond_state_change(buf);
> +		break;
>  	default:
>  		DBG("Unhandled callback opcode=0x%x", opcode);
>  		break;
> -- 
> 1.8.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
