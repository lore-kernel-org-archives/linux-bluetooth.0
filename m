Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree: Add support for three-way calling
Date: Sat, 15 Mar 2014 22:29:39 +0100
Message-ID: <4270176.ob81u6ACZJ@leonov>
In-Reply-To: <1394791220-7150-1-git-send-email-szymon.janc@tieto.com>
References: <1394791220-7150-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 14 of March 2014 11:00:20 Szymon Janc wrote:
> This adds code needed for translating phone_state_change command to
> call, callsetup and callheld indicators. Android HAL specifcy common
> type for all calls state but only subset of values are valid for
> phone_state_change.
> ---
>  android/handsfree.c | 123
> +++++++++++++++++++++++++++++++++++----------------- 1 file changed, 84
> insertions(+), 39 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index e488859..ff03660 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -136,6 +136,9 @@ static struct {
>  	bool ccwa_enabled;
>  	bool indicators_enabled;
>  	struct indicator inds[IND_COUNT];
> +	int num_active;
> +	int num_held;
> +	int setup_state;
> 
>  	uint8_t negotiated_codec;
>  	uint8_t proposed_codec;
> @@ -1979,38 +1982,59 @@ static gboolean ring_cb(gpointer user_data)
>  	return TRUE;
>  }
> 
> -static void phone_state_active(int num_active, int num_held)
> +static void phone_state_dialing(int num_active, int num_held)
>  {
> +	update_indicator(IND_CALLSETUP, 2);
> 
> +	if (num_active == 0 && num_held > 0)
> +		update_indicator(IND_CALLHELD, 2);
>  }
> 
> -static void phone_state_held(int num_active, int num_held)
> +static void phone_state_alerting(int num_active, int num_held)
>  {
> -
> +	update_indicator(IND_CALLSETUP, 3);
>  }
> 
> -static void phone_state_dialing(int num_active, int num_held)
> +static void phone_state_waiting(int num_active, int num_held, uint8_t type,
> +					const uint8_t *number, int number_len)
>  {
> -	update_indicator(IND_CALLSETUP, 2);
> -}
> +	char *num;
> 
> -static void phone_state_alerting(int num_active, int num_held)
> -{
> -	update_indicator(IND_CALLSETUP, 3);
> +	if (!device.ccwa_enabled)
> +		return;
> +
> +	num = number_len ? (char *) number : "";
> +
> +	if (type == HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL && num[0] != '+')
> +		hfp_gw_send_info(device.gw, "+CCWA: \"+%s\",%u", num, type );
> +	else
> +		hfp_gw_send_info(device.gw, "+CCWA: \"%s\",%u", num, type );
> +
> +	update_indicator(IND_CALLSETUP, 1);
>  }
> 
>  static void phone_state_incoming(int num_active, int num_held, uint8_t
> type, -							const char *number)
> +					const uint8_t *number, int number_len)
>  {
> -	char *clip = NULL;
> +	char *clip, *num;
> +
> +	if (device.setup_state == HAL_HANDSFREE_CALL_STATE_INCOMING)
> +		return;
> +
> +	if (num_active > 0 || num_held > 0) {
> +		phone_state_waiting(num_active, num_held, type, number,
> +								number_len);
> +		return;
> +	}
> 
>  	update_indicator(IND_CALLSETUP, 1);
> 
> -	if (type == HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL &&
> -							number[0] != '+')
> -		clip = g_strdup_printf("+CLIP: \"+%s\",%u", number, type );
> +	num = number_len ? (char *) number : "";
> +
> +	if (type == HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL && num[0] != '+')
> +		clip = g_strdup_printf("+CLIP: \"+%s\",%u", num, type );
>  	else
> -		clip = g_strdup_printf("+CLIP: \"%s\",%u", number, type );
> +		clip = g_strdup_printf("+CLIP: \"%s\",%u", num, type );
> 
>  	/* send first RING */
>  	ring_cb(clip);
> @@ -2023,29 +2047,55 @@ static void phone_state_incoming(int num_active, int
> num_held, uint8_t type, g_free(clip);
>  }
> 
> -static void phone_state_waiting(int num_active, int num_held, uint8_t type,
> -							const char *number)
> -{
> -
> -}
> -
>  static void phone_state_idle(int num_active, int num_held)
>  {
> -
> -	update_indicator(IND_CALL, !!num_active);
> -
>  	if (device.ring) {
>  		g_source_remove(device.ring);
>  		device.ring = 0;
>  	}
> 
> -	update_indicator(IND_CALLSETUP, 0);
> +	switch (device.setup_state) {
> +	case HAL_HANDSFREE_CALL_STATE_INCOMING:
> +		if (num_active > device.num_active)
> +			update_indicator(IND_CALL, 1);
> +
> +		if (num_held > device.num_held)
> +			update_indicator(IND_CALLHELD, 1);
> +
> +		update_indicator(IND_CALLSETUP, 0);
> +		break;
> +	case HAL_HANDSFREE_CALL_STATE_DIALING:
> +	case HAL_HANDSFREE_CALL_STATE_ALERTING:
> +		if (num_active > device.num_active)
> +			update_indicator(IND_CALL, 1);
> +
> +		update_indicator(IND_CALLSETUP, 0);
> +		break;
> +	case HAL_HANDSFREE_CALL_STATE_IDLE:
> +		/* check if calls swapped */
> +		if (num_held != 0 && num_active != 0 &&
> +				device.num_active == num_held &&
> +				device.num_held == num_active) {
> +			/* TODO better way for forcing indicator */
> +			device.inds[IND_CALLHELD].val = 0;
> +			update_indicator(IND_CALLHELD, 1);
> +		} else {
> +			update_indicator(IND_CALLHELD,
> +					num_held ? (num_active ? 1 : 2) : 0);
> +		}
> +		update_indicator(IND_CALL, !!(num_active + num_held));
> +		update_indicator(IND_CALLSETUP, 0);
> +
> +		break;
> +	default:
> +		DBG("unhandled state %u", device.setup_state);
> +		break;
> +	}
>  }
> 
>  static void handle_phone_state_change(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_handsfree_phone_state_change *cmd = buf;
> -	const char *number;
>  	uint8_t status;
> 
>  	if (len != sizeof(*cmd) + cmd->number_len || (cmd->number_len != 0 &&
> @@ -2058,15 +2108,7 @@ static void handle_phone_state_change(const void
> *buf, uint16_t len) DBG("active=%u hold=%u state=%u", cmd->num_active,
> cmd->num_held, cmd->state);
> 
> -	number = cmd->number_len ? (char *) cmd->number : "";
> -
>  	switch (cmd->state) {
> -	case HAL_HANDSFREE_CALL_STATE_ACTIVE:
> -		phone_state_active(cmd->num_active, cmd->num_held);
> -		break;
> -	case HAL_HANDSFREE_CALL_STATE_HELD:
> -		phone_state_held(cmd->num_active, cmd->num_held);
> -		break;
>  	case HAL_HANDSFREE_CALL_STATE_DIALING:
>  		phone_state_dialing(cmd->num_active, cmd->num_held);
>  		break;
> @@ -2075,20 +2117,23 @@ static void handle_phone_state_change(const void
> *buf, uint16_t len) break;
>  	case HAL_HANDSFREE_CALL_STATE_INCOMING:
>  		phone_state_incoming(cmd->num_active, cmd->num_held, cmd->type,
> -									number);
> -		break;
> -	case HAL_HANDSFREE_CALL_STATE_WAITING:
> -		phone_state_waiting(cmd->num_active, cmd->num_held, cmd->type,
> -									number);
> +						cmd->number, cmd->number_len);
>  		break;
>  	case HAL_HANDSFREE_CALL_STATE_IDLE:
>  		phone_state_idle(cmd->num_active, cmd->num_held);
>  		break;
>  	default:
> +		DBG("unhandled new state %u (current state %u)", cmd->state,
> +							device.setup_state);
> +
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
>  	}
> 
> +	device.num_active = cmd->num_active;
> +	device.num_held = cmd->num_held;
> +	device.setup_state = cmd->state;
> +
>  	status = HAL_STATUS_SUCCESS;
> 
>  failed:

Pushed.

-- 
BR
Szymon Janc
