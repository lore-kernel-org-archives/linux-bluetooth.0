Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313153788.2254.3.camel@THOR>
References: <1313153788.2254.3.camel@THOR>
Date: Fri, 12 Aug 2011 16:30:37 +0300
Message-ID: <CABBYNZLPmMAkUFriwTgUS2MXpWrOyFeHV8ZVZ_wJH=FDkGeLUQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Increase timeout before initiating AVDTP connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Aug 12, 2011 at 3:56 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> AVDTP_CONNECT_TIMEOUT controls the delay between HSP/HFP
> connection establishment and AVDTP signal channel establishment.
> The original value of 1 sec. is too short to avoid racing for AVDTP
> connection establishment (eg., if the device continues to configure
> the HFP service level connection with add'l AT cmds).
>
> Some devices have broken AVDTP implementations that just cannot
> handle the race conditions that arise if both devices are attempting
> stream establishment at the same time. However, these conditions arise
> only when the remote device is the ACL initiator (and in practice, the
> RFCOMM initiator as well).  This fix bumps out the timeout value only
> when the headset has initiated the link.
> ---
>  audio/device.c  |    9 ++++++++-
>  audio/headset.c |   16 ++++++++++++++++
>  audio/headset.h |    3 +++
>  audio/manager.c |    1 +
>  4 files changed, 28 insertions(+), 1 deletions(-)
>
> diff --git a/audio/device.c b/audio/device.c
> index 18e873e..0bd1443 100644
> --- a/audio/device.c
> +++ b/audio/device.c
> @@ -61,6 +61,7 @@
>
>  #define CONTROL_CONNECT_TIMEOUT 2
>  #define AVDTP_CONNECT_TIMEOUT 1
> +#define AVDTP_CONNECT_TIMEOUT_BOOST 1
>  #define HEADSET_CONNECT_TIMEOUT 1
>
>  typedef enum {
> @@ -305,6 +306,7 @@ static gboolean avdtp_connect_timeout(gpointer user_data)
>  static gboolean device_set_avdtp_timer(struct audio_device *dev)
>  {
>        struct dev_priv *priv = dev->priv;
> +       guint timeout = AVDTP_CONNECT_TIMEOUT;
>
>        if (!dev->sink)
>                return FALSE;
> @@ -312,7 +314,12 @@ static gboolean device_set_avdtp_timer(struct audio_device *dev)
>        if (priv->avdtp_timer)
>                return FALSE;
>
> -       priv->avdtp_timer = g_timeout_add_seconds(AVDTP_CONNECT_TIMEOUT,
> +       /* if the headset is the HSP/HFP RFCOMM initiator, give the headset
> +          time to initiate AVDTP signalling (and avoid further racing) */
> +       if (dev->headset && get_rfcomm_initiator(dev))
> +               timeout += AVDTP_CONNECT_TIMEOUT_BOOST;
> +
> +       priv->avdtp_timer = g_timeout_add_seconds(timeout,
>                                                        avdtp_connect_timeout,
>                                                        dev);
>
> diff --git a/audio/headset.c b/audio/headset.c
> index 8e63afc..66a28f2 100644
> --- a/audio/headset.c
> +++ b/audio/headset.c
> @@ -167,6 +167,7 @@ struct headset {
>
>        gboolean hfp_active;
>        gboolean search_hfp;
> +       gboolean rfcomm_initiator;
>
>        headset_state_t state;
>        struct pending_connect *pending;
> @@ -1633,6 +1634,7 @@ static int rfcomm_connect(struct audio_device *dev, headset_stream_cb_t cb,
>        }
>
>        hs->hfp_active = hs->hfp_handle != 0 ? TRUE : FALSE;
> +       hs->rfcomm_initiator = FALSE;
>
>        headset_set_state(dev, HEADSET_STATE_CONNECTING);
>
> @@ -2442,6 +2444,20 @@ void set_hfp_active(struct audio_device *dev, gboolean active)
>        hs->hfp_active = active;
>  }
>
> +gboolean get_rfcomm_initiator(struct audio_device *dev)
> +{
> +       struct headset *hs = dev->headset;
> +
> +       return hs->rfcomm_initiator;
> +}
> +
> +void set_rfcomm_initiator(struct audio_device *dev, gboolean initiator)
> +{
> +       struct headset *hs = dev->headset;
> +
> +       hs->rfcomm_initiator = initiator;
> +}
> +

I would suggest you to follow the name convention e.g.
headset_get_rfcomm_initiator...

>  GIOChannel *headset_get_rfcomm(struct audio_device *dev)
>  {
>        struct headset *hs = dev->headset;
> diff --git a/audio/headset.h b/audio/headset.h
> index 7ce88c8..f275e03 100644
> --- a/audio/headset.h
> +++ b/audio/headset.h
> @@ -82,6 +82,9 @@ gboolean headset_cancel_stream(struct audio_device *dev, unsigned int id);
>  gboolean get_hfp_active(struct audio_device *dev);
>  void set_hfp_active(struct audio_device *dev, gboolean active);
>
> +gboolean get_rfcomm_initiator(struct audio_device *dev);
> +void set_rfcomm_initiator(struct audio_device *dev, gboolean initiator);
> +

Here too.

-- 
Luiz Augusto von Dentz
