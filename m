Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389435216-29040-3-git-send-email-luiz.dentz@gmail.com>
References: <1389435216-29040-1-git-send-email-luiz.dentz@gmail.com> <1389435216-29040-3-git-send-email-luiz.dentz@gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Mon, 13 Jan 2014 01:02:28 +0100
Message-ID: <CAF3PWx2CnwjPe3oS--7jg4bsoyYth_kHY2_1WFFSPMJ3b4rnnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/6] audio/A2DP: Add implemention of audio Open
 Stream command
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11 January 2014 11:13, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  android/a2dp.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 197 insertions(+), 2 deletions(-)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index 8649cf3..479cb71 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -37,6 +37,7 @@
>  #include "lib/bluetooth.h"
>  #include "lib/sdp.h"
>  #include "lib/sdp_lib.h"
> +#include "profiles/audio/a2dp-codecs.h"
>  #include "log.h"
>  #include "a2dp.h"
>  #include "hal-msg.h"
> @@ -53,6 +54,7 @@
>  static GIOChannel *server = NULL;
>  static GSList *devices = NULL;
>  static GSList *endpoints = NULL;
> +static GSList *setups = NULL;
>  static bdaddr_t adapter_addr;
>  static uint32_t record_id = 0;
>
> @@ -67,6 +69,7 @@ struct a2dp_endpoint {
>         struct avdtp_local_sep *sep;
>         struct a2dp_preset *caps;
>         GSList *presets;
> +       struct a2dp_config *config;
>  };
>
>  struct a2dp_device {
> @@ -76,6 +79,13 @@ struct a2dp_device {
>         struct avdtp    *session;
>  };
>
> +struct a2dp_setup {
> +       struct a2dp_device *dev;
> +       struct a2dp_endpoint *endpoint;
> +       struct a2dp_preset *preset;
> +       struct avdtp_stream *stream;
> +};
> +
>  static int device_cmp(gconstpointer s, gconstpointer user_data)
>  {
>         const struct a2dp_device *dev = s;
> @@ -422,8 +432,160 @@ static gboolean sep_getcap_ind(struct avdtp *session,
>         return TRUE;
>  }
>
> +static int sbc_check_config(struct a2dp_endpoint *endpoint,
> +                                               struct a2dp_preset *conf)
> +{
> +       a2dp_sbc_t *caps, *config;
> +
> +       if (conf->len != sizeof(a2dp_sbc_t)) {
> +               error("SBC: Invalid configuration size (%u)", conf->len);
> +               return -EINVAL;
> +       }
> +
> +       caps = endpoint->caps->data;
> +       config = conf->data;
> +
> +       if (!(caps->frequency & config->frequency)) {
> +               error("SBC: Unsupported frequency (%u) by endpoint",
> +                                                       config->frequency);
> +               return -EINVAL;
> +       }
> +
> +       if (!(caps->channel_mode & config->channel_mode)) {
> +               error("SBC: Unsupported channel mode (%u) by endpoint",
> +                                                       config->channel_mode);
> +               return -EINVAL;
> +       }
> +
> +       if (!(caps->block_length & config->block_length)) {
> +               error("SBC: Unsupported block length (%u) by endpoint",
> +                                                       config->block_length);
> +               return -EINVAL;
> +       }
> +
> +       if (!(caps->allocation_method & config->allocation_method)) {
> +               error("SBC: Unsupported allocation method (%u) by endpoint",
> +                                                       config->block_length);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int check_config(struct a2dp_endpoint *endpoint,
> +                                               struct a2dp_preset *config)
> +{
> +       GSList *l;
> +
> +       for (l = endpoint->presets; l; l = g_slist_next(l)) {
> +               struct a2dp_preset *preset = l->data;
> +
> +               if (preset->len != config->len)
> +                       continue;
> +
> +               if (memcmp(preset->data, config->data, preset->len) == 0)
> +                       return 0;
> +       }
> +
> +       /* Codec specific */
> +       switch (endpoint->codec) {
> +       case A2DP_CODEC_SBC:
> +               return sbc_check_config(endpoint, config);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static struct a2dp_device *find_device_by_session(struct avdtp *session)
> +{
> +       GSList *l;
> +
> +       for (l = devices; l; l = g_slist_next(l)) {
> +               struct a2dp_device *dev = l->data;
> +
> +               if (dev->session == session)
> +                       return dev;
> +       }
> +
> +       return NULL;
> +}
> +
> +static void setup_free(void *data)
> +{
> +       struct a2dp_setup *setup = data;
> +
> +       preset_free(setup->preset);
> +       g_free(setup);
> +}
> +
> +static void setup_add(struct a2dp_device *dev, struct a2dp_endpoint *endpoint,
> +                       struct a2dp_preset *preset, struct avdtp_stream *stream)
> +{
> +       struct a2dp_setup *setup;
> +
> +       setup = g_new0(struct a2dp_setup, 1);
> +       setup->dev = dev;
> +       setup->endpoint = endpoint;
> +       setup->preset = preset;
> +       setup->stream = stream;
> +       setups = g_slist_append(setups, setup);
> +}
> +
> +static gboolean sep_setconf_ind(struct avdtp *session,
> +                                               struct avdtp_local_sep *sep,
> +                                               struct avdtp_stream *stream,
> +                                               GSList *caps,
> +                                               avdtp_set_configuration_cb cb,
> +                                               void *user_data)
> +{
> +       struct a2dp_endpoint *endpoint = user_data;
> +       struct a2dp_device *dev;
> +       struct a2dp_preset *preset = NULL;
> +
> +       DBG("");
> +
> +       dev = find_device_by_session(session);
> +       if (!dev) {
> +               error("Unable to find device for session %p", session);
> +               return FALSE;
> +       }
> +
> +       for (; caps != NULL; caps = g_slist_next(caps)) {
> +               struct avdtp_service_capability *cap = caps->data;
> +               struct avdtp_media_codec_capability *codec;
> +
> +               if (cap->category == AVDTP_DELAY_REPORTING)
> +                       return FALSE;
> +
> +               if (cap->category != AVDTP_MEDIA_CODEC)
> +                       continue;
> +
> +               codec = (struct avdtp_media_codec_capability *) cap->data;
> +
> +               if (codec->media_codec_type != endpoint->codec)
> +                       return FALSE;
> +
> +               preset = g_new0(struct a2dp_preset, 1);
> +               preset->len = cap->length - sizeof(*codec);
> +               preset->data = g_memdup(codec->data, preset->len);
> +
> +               if (check_config(endpoint, preset) < 0) {
> +                       preset_free(preset);
> +                       return FALSE;
> +               }
> +       }
> +
> +       if (!preset)
> +               return FALSE;
> +
> +       setup_add(dev, endpoint, preset, stream);
> +
> +       return TRUE;

I guess there should be call to avdtp_set_configuration_cb somewhere
in this function?


BR,
Andrzej
