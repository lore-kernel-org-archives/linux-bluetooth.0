Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313162877-14945-4-git-send-email-frederic.dalleau@linux.intel.com>
References: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1313162877-14945-4-git-send-email-frederic.dalleau@linux.intel.com>
Date: Sun, 14 Aug 2011 19:48:03 +0300
Message-ID: <CABBYNZJihKWjQFHoo1+ig=dxkoEDvccgA6S87SMsY6bS=TurTw@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add state change callback to HandsfreeGateway
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/12 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> ---
>  audio/gateway.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  audio/gateway.h |    7 ++++++
>  2 files changed, 68 insertions(+), 0 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index e9485d0..805b8cb 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -72,6 +72,14 @@ struct gateway {
>        int version;
>  };
>
> +struct gateway_state_callback {
> +       gateway_state_cb cb;
> +       void *user_data;
> +       unsigned int id;
> +};
> +
> +static GSList *gateway_callbacks = NULL;
> +
>  int gateway_close(struct audio_device *device);
>
>  static const char *state2str(gateway_state_t state)
> @@ -104,16 +112,37 @@ static void change_state(struct audio_device *dev, gateway_state_t new_state)
>  {
>        struct gateway *gw = dev->gateway;
>        const char *val;
> +       GSList *l;
> +       gateway_state_t old_state;
>
>        if (gw->state == new_state)
>                return;
>
>        val = state2str(new_state);
> +       old_state = gw->state;
>        gw->state = new_state;
>
>        emit_property_changed(dev->conn, dev->path,
>                        AUDIO_GATEWAY_INTERFACE, "State",
>                        DBUS_TYPE_STRING, &val);
> +
> +       for (l = gateway_callbacks; l != NULL; l = l->next) {
> +               struct gateway_state_callback *cb = l->data;
> +               cb->cb(dev, old_state, new_state, cb->user_data);
> +       }
> +}
> +
> +void gateway_set_state(struct audio_device *dev, gateway_state_t new_state)
> +{
> +       switch (new_state) {
> +       case GATEWAY_STATE_DISCONNECTED:
> +               gateway_close(dev);
> +               break;
> +       case GATEWAY_STATE_CONNECTING:
> +       case GATEWAY_STATE_CONNECTED:
> +       case GATEWAY_STATE_PLAYING:
> +               break;
> +       }
>  }
>
>  static void agent_disconnect(struct audio_device *dev, struct hf_agent *agent)
> @@ -810,3 +839,35 @@ void gateway_suspend_stream(struct audio_device *dev)
>        gw->sco_start_cb_data = NULL;
>        change_state(dev, GATEWAY_STATE_CONNECTED);
>  }
> +
> +unsigned int gateway_add_state_cb(gateway_state_cb cb, void *user_data)
> +{
> +       struct gateway_state_callback *state_cb;
> +       static unsigned int id = 0;
> +
> +       state_cb = g_new(struct gateway_state_callback, 1);
> +       state_cb->cb = cb;
> +       state_cb->user_data = user_data;
> +       state_cb->id = ++id;
> +
> +       gateway_callbacks = g_slist_append(gateway_callbacks, state_cb);
> +
> +       return state_cb->id;
> +}
> +
> +gboolean gateway_remove_state_cb(unsigned int id)
> +{
> +       GSList *l;
> +
> +       for (l = gateway_callbacks; l != NULL; l = l->next) {
> +               struct gateway_state_callback *cb = l->data;
> +               if (cb && cb->id == id) {
> +                       gateway_callbacks = g_slist_remove(gateway_callbacks,
> +                                                                       cb);
> +                       g_free(cb);
> +                       return TRUE;
> +               }
> +       }
> +
> +       return FALSE;
> +}
> diff --git a/audio/gateway.h b/audio/gateway.h
> index a45ef82..32b5d6d 100644
> --- a/audio/gateway.h
> +++ b/audio/gateway.h
> @@ -33,9 +33,14 @@ typedef enum {
>        GATEWAY_STATE_PLAYING,
>  } gateway_state_t;
>
> +typedef void (*gateway_state_cb) (struct audio_device *dev,
> +                                       gateway_state_t old_state,
> +                                       gateway_state_t new_state,
> +                                       void *user_data);
>  typedef void (*gateway_stream_cb_t) (struct audio_device *dev, GError *err,
>                void *user_data);
>
> +void gateway_set_state(struct audio_device *dev, gateway_state_t new_state);
>  void gateway_unregister(struct audio_device *dev);
>  struct gateway *gateway_init(struct audio_device *device);
>  gboolean gateway_is_connected(struct audio_device *dev);
> @@ -49,3 +54,5 @@ int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
>  gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id);
>  int gateway_get_sco_fd(struct audio_device *dev);
>  void gateway_suspend_stream(struct audio_device *dev);
> +unsigned int gateway_add_state_cb(gateway_state_cb cb, void *user_data);
> +gboolean gateway_remove_state_cb(unsigned int id);
> --
> 1.7.1
>

Looks good, so the callbacks are not per-device like we have done for headset.

-- 
Luiz Augusto von Dentz
