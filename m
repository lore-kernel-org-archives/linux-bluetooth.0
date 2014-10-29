Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414421776-4029-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1414421776-4029-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Wed, 29 Oct 2014 13:41:34 +0200
Message-ID: <CABBYNZKzgANn_ys7xEzsrsmSG-qu_5XX0Es36P8cdGPLXa=2EA@mail.gmail.com>
Subject: Re: [PATCH 1/4] android/tester: Fix wrong state comparison in A2DP
 and AVRCP tests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Oct 27, 2014 at 4:56 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> ---

Could you please add a description why this is needed, even though I
get it is always good idea to add a bit more description since it is
fixing something.

>  android/tester-main.c | 20 ++++++++++++++++++--
>  android/tester-main.h | 11 +++++++----
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/android/tester-main.c b/android/tester-main.c
> index f4d18e2..8cf62c2 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -654,6 +654,22 @@ static bool match_data(struct step *step)
>                 return false;
>         }
>
> +       if (exp->callback_result.av_conn_state !=
> +                                       step->callback_result.av_conn_state) {
> +               tester_debug("Callback av conn state mismatch: 0x%x vs 0x%x",
> +                                       step->callback_result.av_conn_state,
> +                                       exp->callback_result.av_conn_state);
> +               return false;
> +       }
> +
> +       if (exp->callback_result.av_audio_state !=
> +                                       step->callback_result.av_audio_state) {
> +               tester_debug("Callback av audio state mismatch: 0x%x vs 0x%x",
> +                                       step->callback_result.av_audio_state,
> +                                       exp->callback_result.av_audio_state);
> +               return false;
> +       }
> +
>         if (exp->callback_result.pairing_variant !=
>                                         step->callback_result.pairing_variant) {
>                 tester_debug("Callback pairing result mismatch: %d vs %d",
> @@ -1863,7 +1879,7 @@ static void a2dp_connection_state_cb(btav_connection_state_t state,
>         struct step *step = g_new0(struct step, 1);
>
>         step->callback = CB_A2DP_CONN_STATE;
> -       step->callback_result.state = state;
> +       step->callback_result.av_conn_state = state;
>
>         schedule_callback_verification(step);
>  }
> @@ -1873,7 +1889,7 @@ static void a2dp_audio_state_cb(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
>         struct step *step = g_new0(struct step, 1);
>
>         step->callback = CB_A2DP_AUDIO_STATE;
> -       step->callback_result.state = state;
> +       step->callback_result.av_audio_state = state;
>
>         schedule_callback_verification(step);
>  }
> diff --git a/android/tester-main.h b/android/tester-main.h
> index c938d44..ff6e43c 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -387,14 +387,14 @@ struct pdu_set {
>                 .callback_result.channel_state = cb_state, \
>         }
>
> -#define CALLBACK_AV_CONN_STATE(cb, cb_state) { \
> +#define CALLBACK_AV_CONN_STATE(cb, cb_av_conn_state) { \
>                 .callback = cb, \
> -               .callback_result.state = cb_state, \
> +               .callback_result.av_conn_state = cb_av_conn_state, \
>         }
>
> -#define CALLBACK_AV_AUDIO_STATE(cb, cb_state) { \
> +#define CALLBACK_AV_AUDIO_STATE(cb, cb_av_audio_state) { \
>                 .callback = cb, \
> -               .callback_result.state = cb_state, \
> +               .callback_result.av_audio_state = cb_av_audio_state, \
>         }
>
>  #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
> @@ -641,6 +641,9 @@ struct bt_callback_data {
>         int mdep_cfg_index;
>         bthl_app_reg_state_t app_state;
>         bthl_channel_state_t channel_state;
> +
> +       btav_connection_state_t av_conn_state;
> +       btav_audio_state_t av_audio_state;
>  };
>
>  /*
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
