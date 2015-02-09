Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/handsfree: Don't disconnect on unknown command in SLC
Date: Mon, 09 Feb 2015 15:18:16 +0100
Message-ID: <1676628.j94jvBEq7a@leonov>
In-Reply-To: <1423477896-5082-1-git-send-email-szymon.janc@tieto.com>
References: <1423477896-5082-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 09 of February 2015 11:31:35 Szymon Janc wrote:
> When connecting HFP simply reply with ERROR to any command not related
> to SLC creation but don't disconnect in such case.
> 
> This fix connection issue with Jaguar XF 2009 carkit that sends
> AT+CPIN? command before AT+BRSF.
> ---
>  android/handsfree.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 76f5653..4020ed5 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -315,12 +315,6 @@ static void at_cmd_unknown(const char *command, void
> *user_data) uint8_t buf[IPC_MTU];
>  	struct hal_ev_handsfree_unknown_at *ev = (void *) buf;
> 
> -	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED) {
> -		hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
> -		hfp_gw_disconnect(dev->gw);
> -		return;
> -	}
> -
>  	bdaddr2android(&dev->bdaddr, ev->bdaddr);
> 
>  	/* copy while string including terminating NULL */
> @@ -1147,6 +1141,8 @@ static void at_cmd_ckpd(struct hfp_context *result,
> enum hfp_gw_cmd_type type,
> 
>  static void register_post_slc_at(struct hf_device *dev)
>  {
> +	hfp_gw_set_command_handler(dev->gw, at_cmd_unknown, dev, NULL);
> +
>  	if (dev->hsp) {
>  		hfp_gw_register(dev->gw, at_cmd_ckpd, "+CKPD", dev, NULL);
>  		hfp_gw_register(dev->gw, at_cmd_vgs, "+VGS", dev, NULL);
> @@ -1468,7 +1464,6 @@ static void connect_cb(GIOChannel *chan, GError *err,
> gpointer user_data) g_io_channel_set_close_on_unref(chan, FALSE);
> 
>  	hfp_gw_set_close_on_unref(dev->gw, true);
> -	hfp_gw_set_command_handler(dev->gw, at_cmd_unknown, dev, NULL);
>  	hfp_gw_set_disconnect_handler(dev->gw, disconnect_watch, dev, NULL);
> 
>  	if (dev->hsp) {

Applied.

-- 
BR
Szymon Janc
