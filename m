Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389779996-9749-3-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1389779996-9749-3-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Wed, 15 Jan 2014 12:47:37 +0200
Message-ID: <CABBYNZKVg7dJuZ6T2mqDLTpnKGPVvp0jNfEK+83vs8hGLLTO+Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] android/hal-audio: Add support to register audio endpoints
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Jan 15, 2014 at 11:59 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> This patch adds support to register audio enpoints via Audio IPC.
> Endpoints are registered based on predefined codecs table and for
> each defined codec one endpoint is registered. By default, only
> SBC will be supported.
> ---
>  android/hal-audio.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 354c3cf..84e7348 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -31,6 +31,11 @@
>  #include "audio-msg.h"
>  #include "hal-log.h"
>  #include "hal-msg.h"
> +#include "../profiles/audio/a2dp-codecs.h"
> +
> +static const uint8_t a2dp_src_uuid[] = {
> +               0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
> +               0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
>
>  static int listen_sk = -1;
>  static int audio_sk = -1;
> @@ -40,11 +45,118 @@ static pthread_t ipc_th = 0;
>  static pthread_mutex_t close_mutex = PTHREAD_MUTEX_INITIALIZER;
>  static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
>
> +struct audio_input_config {
> +       uint32_t rate;
> +       uint32_t channels;
> +       audio_format_t format;
> +};
> +
> +static int codec_sbc_get_presets(struct audio_preset *preset, size_t *len);
> +
> +struct audio_codec {
> +       uint8_t type;
> +
> +       int (*get_presets) (struct audio_preset *preset, size_t *len);
> +
> +       int (*init) (struct audio_preset *preset, void **codec_data);
> +       int (*cleanup) (void *codec_data);
> +       int (*get_config) (void *codec_data,
> +                                       struct audio_input_config *config);
> +       ssize_t (*write_data) (void *codec_data, const void *buffer,
> +                               size_t bytes);
> +};
> +
> +static const struct audio_codec audio_codecs[] = {
> +       {
> +               .type = A2DP_CODEC_SBC,
> +
> +               .get_presets = codec_sbc_get_presets,
> +       }
> +};
> +
> +#define NUM_CODECS (sizeof(audio_codecs) / sizeof(audio_codecs[0]))
> +
> +#define MAX_AUDIO_ENDPOINTS NUM_CODECS
> +
> +struct audio_endpoint {
> +       uint8_t id;
> +       const struct audio_codec *codec;
> +       void *codec_data;
> +       int fd;
> +};
> +
> +static struct audio_endpoint audio_endpoints[MAX_AUDIO_ENDPOINTS];
> +
>  struct a2dp_audio_dev {
>         struct audio_hw_device dev;
>         struct audio_stream_out *out;
>  };
>
> +static const a2dp_sbc_t codec_sbc_presets[] = {

Call it sbc_presets

> +       {
> +               .frequency = SBC_SAMPLING_FREQ_44100 | SBC_SAMPLING_FREQ_48000,
> +               .channel_mode = SBC_CHANNEL_MODE_MONO |
> +                               SBC_CHANNEL_MODE_DUAL_CHANNEL |
> +                               SBC_CHANNEL_MODE_STEREO |
> +                               SBC_CHANNEL_MODE_JOINT_STEREO,
> +               .subbands = SBC_SUBBANDS_4 | SBC_SUBBANDS_8,
> +               .allocation_method = SBC_ALLOCATION_SNR |
> +                                       SBC_ALLOCATION_LOUDNESS,
> +               .block_length = SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH_8 |
> +                               SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_16,
> +               .min_bitpool = MIN_BITPOOL,
> +               .max_bitpool = MAX_BITPOOL
> +       },
> +       {
> +               .frequency = SBC_SAMPLING_FREQ_44100,
> +               .channel_mode = SBC_CHANNEL_MODE_STEREO,
> +               .subbands = SBC_SUBBANDS_8,
> +               .allocation_method = SBC_ALLOCATION_LOUDNESS,
> +               .block_length = SBC_BLOCK_LENGTH_16,
> +               .min_bitpool = MIN_BITPOOL,
> +               .max_bitpool = MAX_BITPOOL
> +       },
> +       {
> +               .frequency = SBC_SAMPLING_FREQ_48000,
> +               .channel_mode = SBC_CHANNEL_MODE_STEREO,
> +               .subbands = SBC_SUBBANDS_8,
> +               .allocation_method = SBC_ALLOCATION_LOUDNESS,
> +               .block_length = SBC_BLOCK_LENGTH_16,
> +               .min_bitpool = MIN_BITPOOL,
> +               .max_bitpool = MAX_BITPOOL
> +       },
> +};

Perhaps we should add the recomended values from A2DP spec, iirc there
are at least 3 preset recommended there, high, medium, low quality.

> +static int codec_sbc_get_presets(struct audio_preset *preset, size_t *len)
> +{

Call this one sbc_get_presets

> +       int i;
> +       int count;
> +       size_t new_len = 0;
> +       uint8_t *ptr = (uint8_t *) preset;
> +       size_t preset_size = sizeof(*preset) + sizeof(a2dp_sbc_t);
> +
> +       DBG("");
> +
> +       count = sizeof(codec_sbc_presets) / sizeof(codec_sbc_presets[0]);
> +
> +       for (i = 0; i < count; i++) {
> +               preset = (struct audio_preset *) ptr;
> +
> +               if (new_len + preset_size > *len)
> +                       break;
> +
> +               preset->len = sizeof(a2dp_sbc_t);
> +               memcpy(preset->data, &codec_sbc_presets[i], preset->len);
> +
> +               new_len += preset_size;
> +               ptr += preset_size;
> +       }
> +
> +       *len = new_len;
> +
> +       return i;
> +}
> +
>  static void audio_ipc_cleanup(void)
>  {
>         if (audio_sk >= 0) {
> @@ -200,6 +312,54 @@ failed:
>         return AUDIO_STATUS_FAILED;
>  }
>
> +static int ipc_open_cmd(const struct audio_codec *codec)
> +{
> +       uint8_t buf[BLUEZ_AUDIO_MTU];
> +       struct audio_cmd_open *cmd = (struct audio_cmd_open *) buf;
> +       struct audio_rsp_open rsp;
> +       size_t cmd_len = sizeof(buf) - sizeof(*cmd);
> +       size_t rsp_len = sizeof(rsp);
> +       int result;
> +
> +       DBG("");
> +
> +       memcpy(cmd->uuid, a2dp_src_uuid, sizeof(a2dp_src_uuid));
> +
> +       cmd->codec = codec->type;
> +       cmd->presets = codec->get_presets(cmd->preset, &cmd_len);
> +
> +       cmd_len += sizeof(*cmd);
> +
> +       result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_OPEN, cmd_len, cmd,
> +                               &rsp_len, &rsp, NULL);
> +
> +       if (result != AUDIO_STATUS_SUCCESS)
> +               return 0;
> +
> +       return rsp.id;
> +}
> +
> +static int register_endpoints(void)
> +{
> +       struct audio_endpoint *ep = &audio_endpoints[0];
> +       size_t i;
> +
> +       for (i = 0; i < NUM_CODECS; i++) {
> +               const struct audio_codec *codec = &audio_codecs[i];
> +
> +               ep->id = ipc_open_cmd(codec);
> +
> +               if (!ep->id)
> +                       return AUDIO_STATUS_FAILED;
> +
> +               ep->codec = codec;
> +               ep->codec_data = NULL;
> +               ep->fd = -1;
> +       }

This seems to be overwriting ep if there is more than one codec
available, I guess you need to move ep within the loop as well then
you assign the correspondent codec index to the endpoint index.

-- 
Luiz Augusto von Dentz
