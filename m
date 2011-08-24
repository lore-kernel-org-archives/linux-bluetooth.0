Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314027047-5476-4-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314027047-5476-4-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 24 Aug 2011 13:53:04 +0300
Message-ID: <CABBYNZJ30nJjdsZ6KtO93pERNhLOj1ihiBGi7dLsPNYLp=sTJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] Use state change callback from media interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/22 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> When a HFPHS endpoint is created, media will start to watch for
> HandsfreeGateway state changes. media call SetConfiguration upon
> connection and ClearConfiguration upon disconnection.
> ---
>  audio/media.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index 2076d04..ae2b471 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -43,6 +43,7 @@
>  #include "transport.h"
>  #include "a2dp.h"
>  #include "headset.h"
> +#include "gateway.h"
>  #include "manager.h"
>
>  #ifndef DBUS_TYPE_UNIX_FD
> @@ -78,6 +79,7 @@ struct media_endpoint {
>        uint8_t                 *capabilities;  /* Endpoint property capabilities */
>        size_t                  size;           /* Endpoint capabilities size */
>        guint                   hs_watch;
> +       guint                   ag_watch;
>        guint                   watch;
>        struct endpoint_request *request;
>        struct media_transport  *transport;
> @@ -118,6 +120,9 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
>        if (endpoint->hs_watch)
>                headset_remove_state_cb(endpoint->hs_watch);
>
> +       if (endpoint->ag_watch)
> +               gateway_remove_state_cb(endpoint->ag_watch);
> +
>        if (endpoint->request)
>                media_endpoint_cancel(endpoint);
>
> @@ -553,6 +558,46 @@ static void a2dp_destroy_endpoint(void *user_data)
>        release_endpoint(endpoint);
>  }
>
> +static void gateway_setconf_cb(struct media_endpoint *endpoint, void *ret,
> +                                               int size, void *user_data)
> +{
> +       struct audio_device *dev = user_data;
> +
> +       if (ret != NULL)
> +               return;
> +
> +       gateway_set_state(dev, GATEWAY_STATE_DISCONNECTED);
> +}
> +
> +static void gateway_state_changed(struct audio_device *dev,
> +                                       gateway_state_t old_state,
> +                                       gateway_state_t new_state,
> +                                       void *user_data)
> +{
> +       struct media_endpoint *endpoint = user_data;
> +
> +       DBG("");
> +
> +       switch (new_state) {
> +       case GATEWAY_STATE_DISCONNECTED:
> +               if (endpoint->transport &&
> +                       media_transport_get_dev(endpoint->transport) == dev) {
> +
> +                       DBG("Clear endpoint %p", endpoint);
> +                       clear_configuration(endpoint);
> +               }
> +               break;
> +       case GATEWAY_STATE_CONNECTING:
> +               set_configuration(endpoint, dev, NULL, 0,
> +                                       gateway_setconf_cb, dev, NULL);
> +               break;
> +       case GATEWAY_STATE_CONNECTED:
> +               break;
> +       case GATEWAY_STATE_PLAYING:
> +               break;
> +       }
> +}
> +
>  static struct media_endpoint *media_endpoint_create(struct media_adapter *adapter,
>                                                const char *sender,
>                                                const char *path,
> @@ -604,6 +649,17 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
>                if (dev)
>                        set_configuration(endpoint, dev, NULL, 0,
>                                                headset_setconf_cb, dev, NULL);
> +       } else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
> +                                       strcasecmp(uuid, HSP_HS_UUID) == 0) {
> +               struct audio_device *dev;
> +
> +               endpoint->ag_watch = gateway_add_state_cb(gateway_state_changed,
> +                                                               endpoint);
> +               dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
> +                                               AUDIO_GATEWAY_INTERFACE, TRUE);
> +               if (dev)
> +                       set_configuration(endpoint, dev, NULL, 0,
> +                                               gateway_setconf_cb, dev, NULL);
>        } else {
>                if (err)
>                        *err = -EINVAL;
> --
> 1.7.1
>

Ack

-- 
Luiz Augusto von Dentz
