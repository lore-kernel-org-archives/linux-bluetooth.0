Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314373178-11337-3-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314373178-11337-3-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 29 Aug 2011 11:27:10 +0300
Message-ID: <CABBYNZLipeCND6JHGWJTaWntO2E=BkgTC0FBmYuQ5JAexZ9S8Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Fix asynchronously run request stream cb
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/26 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> ---
>  audio/gateway.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  audio/gateway.h |    2 +-
>  audio/unix.c    |    6 +---
>  3 files changed, 62 insertions(+), 14 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 59c91dd..8cbaeb4 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -60,6 +60,12 @@ struct hf_agent {
>        guint watch;    /* Disconnect watch */
>  };
>
> +struct connect_cb {
> +       unsigned int id;
> +       gateway_stream_cb_t cb;
> +       void *cb_data;
> +};
> +
>  struct gateway {
>        gateway_state_t state;
>        GIOChannel *rfcomm;
> @@ -67,6 +73,7 @@ struct gateway {
>        GIOChannel *incoming;
>        gateway_stream_cb_t sco_start_cb;
>        void *sco_start_cb_data;
> +       GSList *callbacks;
>        struct hf_agent *agent;
>        DBusMessage *msg;
>        int version;
> @@ -180,6 +187,41 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
>        return TRUE;
>  }
>
> +static unsigned int connect_cb_new(struct gateway *gw,
> +                                       gateway_stream_cb_t func,
> +                                       void *user_data)
> +{
> +       struct connect_cb *cb;
> +       static unsigned int free_cb_id = 1;
> +
> +       if (!func)
> +               return 0;
> +
> +       cb = g_new(struct connect_cb, 1);
> +
> +       cb->cb = func;
> +       cb->cb_data = user_data;
> +       cb->id = free_cb_id++;
> +
> +       gw->callbacks = g_slist_append(gw->callbacks, cb);
> +
> +       return cb->id;
> +}
> +
> +static void run_connect_cb(struct audio_device *dev, GError *err)
> +{
> +       struct gateway *gw = dev->gateway;
> +       GSList *l;
> +
> +       for (l = gw->callbacks; l != NULL; l = l->next) {
> +               struct connect_cb *cb = l->data;
> +               cb->cb(dev, err, cb->cb_data);
> +       }
> +
> +       g_slist_free_full(gw->callbacks, g_free);
> +       gw->callbacks = NULL;
> +}
> +
>  static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
>                        struct audio_device *dev)
>  {
> @@ -209,6 +251,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>        if (gw->sco_start_cb)
>                gw->sco_start_cb(dev, err, gw->sco_start_cb_data);
>
> +       run_connect_cb(dev, err);
> +
>        if (err) {
>                error("sco_connect_cb(): %s", err->message);
>                gateway_close(dev);
> @@ -759,22 +803,27 @@ void gateway_start_service(struct audio_device *dev)
>        }
>  }
>
> +static gboolean request_stream_cb(gpointer data)
> +{
> +       run_connect_cb(data, NULL);
> +       return FALSE;
> +}
> +
>  /* These are functions to be called from unix.c for audio system
>  * ifaces (alsa, gstreamer, etc.) */
> -gboolean gateway_request_stream(struct audio_device *dev,
> +unsigned int gateway_request_stream(struct audio_device *dev,
>                                gateway_stream_cb_t cb, void *user_data)
>  {
>        struct gateway *gw = dev->gateway;
> +       unsigned int id;
>        GError *err = NULL;
>        GIOChannel *io;
>
> +       id = connect_cb_new(gw, cb, user_data);
> +
>        if (!gw->rfcomm) {
> -               gw->sco_start_cb = cb;
> -               gw->sco_start_cb_data = user_data;
>                get_records(dev);
>        } else if (!gw->sco) {
> -               gw->sco_start_cb = cb;
> -               gw->sco_start_cb_data = user_data;

It seems after this changes sco_start_cb won't be necessary anymore,
but apparently you only remove it in another patch, IMO it would be
better to have merged so we know why it was removed.


-- 
Luiz Augusto von Dentz
