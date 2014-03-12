Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394637058-586-7-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1394637058-586-7-git-send-email-ravikumar.veeramally@linux.intel.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Wed, 12 Mar 2014 16:57:28 +0100
Message-ID: <CAF3PWx11bdQfjfGmVRBvVagfA0tn81arDKzWw_K8T9+MuK+v2A@mail.gmail.com>
Subject: Re: [PATCH 06/15] android/hal-msg: Add HDP app channel state event struct
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On 12 March 2014 16:10, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> ---
>  android/hal-msg.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 694529f..0139543 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -1001,12 +1001,28 @@ struct hal_ev_pan_conn_state {
>  #define HAL_HEALTH_APP_DEREG_SUCCESS           0x02
>  #define HAL_HEALTH_APP_DEREG_FAILED            0x03
>
> +#define HAL_HEALTH_CHANL_STATE_CONNECTING      0x00
> +#define HAL_HEALTH_CHANL_STATE_CONNECTED       0x01
> +#define HAL_HEALTH_CHANL_STATE_DISCONNECTING   0x02
> +#define HAL_HEALTH_CHANL_STATE_DISCONNECTED    0x03
> +#define HAL_HEALTH_CHANL_STATE_DESTROYED       0x04
> +
>  #define HAL_EV_HEALTH_APP_REG_STATE            0x81
>  struct hal_ev_health_app_reg_state {
>         uint16_t id;
>         uint8_t  state;
>  } __attribute__((packed));
>
> +#define HAL_EV_HEALTH_CHNL_STATE               0x82

You have CHNL here and CHANL in states definitions - better have them
consistent. I guess either CHAN or CHANNEL would be actually better.

> +struct hal_ev_health_chnl_state {
> +       uint16_t app_id;
> +       uint8_t  bdaddr[6];
> +       uint8_t  mdep_index;
> +       uint16_t chnl_id;
> +       uint8_t  chnl_state;

Same here - chan or channel.

> +       uint32_t file_descr;

fd shall be passed as auxiliary data - there's parameter for this in
IPC calls. Now you just pass plain int value which is useless as fd.

BR,
Andrzej
