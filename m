Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389435216-29040-1-git-send-email-luiz.dentz@gmail.com>
References: <1389435216-29040-1-git-send-email-luiz.dentz@gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Mon, 13 Jan 2014 00:58:26 +0100
Message-ID: <CAF3PWx0wD=TCNkwjH5LH5RjjjHt7LLb2UPZSL5A8xdwfmVHc5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] audio/A2DP: Add implemention of audio Open command
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11 January 2014 11:13, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  android/a2dp.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index b59c53d..28b7406 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -52,9 +52,23 @@
>
>  static GIOChannel *server = NULL;
>  static GSList *devices = NULL;
> +static GSList *endpoints = NULL;
>  static bdaddr_t adapter_addr;
>  static uint32_t record_id = 0;
>
> +struct a2dp_preset {
> +       void *data;
> +       int8_t len;
> +};
> +
> +struct a2dp_endpoint {
> +       uint8_t id;
> +       uint8_t codec;
> +       struct avdtp_local_sep *sep;
> +       struct a2dp_preset *caps;
> +       GSList *presets;
> +};
> +
>  struct a2dp_device {
>         bdaddr_t        dst;
>         uint8_t         state;
> @@ -70,6 +84,29 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
>         return bacmp(&dev->dst, dst);
>  }
>
> +static void preset_free(void *data)
> +{
> +       struct a2dp_preset *preset = data;
> +
> +       g_free(preset->data);
> +       g_free(preset);
> +}
> +
> +static void unregister_endpoint(void *data)
> +{
> +       struct a2dp_endpoint *endpoint = data;
> +
> +       if (endpoint->sep)
> +               avdtp_unregister_sep(endpoint->sep);
> +
> +       if (endpoint->caps)
> +               preset_free(endpoint->caps);
> +
> +       g_slist_free_full(endpoint->presets, preset_free);
> +
> +       g_free(endpoint);
> +}
> +
>  static void a2dp_device_free(struct a2dp_device *dev)
>  {
>         if (dev->session)
> @@ -354,10 +391,127 @@ static sdp_record_t *a2dp_record(void)
>         return record;
>  }
>
> +static gboolean sep_getcap_ind(struct avdtp *session,
> +                                       struct avdtp_local_sep *sep,
> +                                       GSList **caps, uint8_t *err,
> +                                       void *user_data)
> +{
> +       struct a2dp_endpoint *endpoint = user_data;
> +       struct a2dp_preset *cap = endpoint->presets->data;

endpoint->caps

> +       struct avdtp_service_capability *media_transport, *media_codec;
> +       struct avdtp_media_codec_capability *codec_caps;
> +
> +       *caps = NULL;
> +
> +       media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
> +                                                               NULL, 0);
> +
> +       *caps = g_slist_append(*caps, media_transport);
> +
> +       codec_caps = g_malloc0(sizeof(*codec_caps) + sizeof(cap));
> +       codec_caps->media_type = AVDTP_MEDIA_TYPE_AUDIO;
> +       codec_caps->media_codec_type = endpoint->codec;
> +       memcpy(codec_caps->data, cap->data, cap->len);
> +
> +       media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, codec_caps,
> +                                       sizeof(*codec_caps) + sizeof(cap));
> +
> +       *caps = g_slist_append(*caps, media_codec);
> +       g_free(codec_caps);
> +
> +       return TRUE;
> +}
> +
> +static struct avdtp_sep_ind sep_ind = {
> +       .get_capability         = sep_getcap_ind,
> +};
> +
> +static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
> +                                                       GSList *presets)
> +{
> +       struct a2dp_endpoint *endpoint;
> +
> +       /* FIXME: Add proper check for uuid */
> +
> +       endpoint = g_new0(struct a2dp_endpoint, 1);
> +       endpoint->id = g_slist_length(endpoints) + 1;
> +       endpoint->codec = codec;
> +       endpoint->sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE,
> +                                               AVDTP_MEDIA_TYPE_AUDIO,
> +                                               codec, FALSE, &sep_ind, NULL,
> +                                               endpoint);
> +       endpoint->caps = g_slist_nth_data(presets->data, 0);

g_slist_nth_data(presets, 0)


BR,
Andrzej
