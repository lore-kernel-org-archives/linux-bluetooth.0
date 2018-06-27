Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180626114559.22560-1-luiz.dentz@gmail.com>
References: <20180626114559.22560-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Jun 2018 11:01:34 +0300
Message-ID: <CABBYNZ+bFKi088dP-Xon7eJmL8=UFock_ksqAKtLX0SbRC03+A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] policy: Add logic to connect a Sink
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 26, 2018 at 2:45 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If HFP/HSP HS connects and the device also supports a Sink connect it
> as well since some devices (e.g. Sony MW600) may not connect it
> automatically.
> ---
>  plugins/policy.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/plugins/policy.c b/plugins/policy.c
> index 1f5a506a2..de51e58b9 100644
> --- a/plugins/policy.c
> +++ b/plugins/policy.c
> @@ -297,6 +297,42 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
>         }
>  }
>
> +static void hs_cb(struct btd_service *service, btd_service_state_t old_state,
> +                                               btd_service_state_t new_state)
> +{
> +       struct btd_device *dev = btd_service_get_device(service);
> +       struct policy_data *data;
> +       struct btd_service *sink;
> +
> +       /* If the device supports Sink set a timer to connect it as well */
> +       sink = btd_device_get_service(dev, A2DP_SINK_UUID);
> +       if (sink == NULL)
> +               return;
> +
> +       data = policy_get_data(dev);
> +
> +       switch (new_state) {
> +       case BTD_SERVICE_STATE_UNAVAILABLE:
> +               break;
> +       case BTD_SERVICE_STATE_DISCONNECTED:
> +               break;
> +       case BTD_SERVICE_STATE_CONNECTING:
> +               break;
> +       case BTD_SERVICE_STATE_CONNECTED:
> +               /* Check if service initiate the connection then proceed
> +                * immediately otherwise set timer
> +                */
> +               if (old_state == BTD_SERVICE_STATE_CONNECTING)
> +                       policy_connect(data, sink);
> +               else if (btd_service_get_state(sink) !=
> +                                               BTD_SERVICE_STATE_CONNECTED)
> +                       policy_set_sink_timer(data);
> +               break;
> +       case BTD_SERVICE_STATE_DISCONNECTING:
> +               break;
> +       }
> +}
> +
>  static gboolean policy_connect_tg(gpointer user_data)
>  {
>         struct policy_data *data = user_data;
> @@ -615,6 +651,9 @@ static void service_cb(struct btd_service *service,
>                 controller_cb(service, old_state, new_state);
>         else if (g_str_equal(profile->remote_uuid, AVRCP_TARGET_UUID))
>                 target_cb(service, old_state, new_state);
> +       else if (g_str_equal(profile->remote_uuid, HFP_HS_UUID) ||
> +                       g_str_equal(profile->remote_uuid, HSP_HS_UUID))
> +               hs_cb(service, old_state, new_state);
>
>         /*
>          * Return if the reconnection feature is not enabled (all
> --
> 2.17.1

Applied.


-- 
Luiz Augusto von Dentz
