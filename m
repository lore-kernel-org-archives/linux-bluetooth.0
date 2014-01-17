Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 4/9] android/hal-audio: Initialize SBC encoder
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389973213-30251-5-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Fri, 17 Jan 2014 10:24:21 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <D34DEF28-690B-4697-B88F-B224F7583782@holtmann.org>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com> <1389973213-30251-5-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> ---
> android/hal-audio.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 72 insertions(+)
> 
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index f53dba0..e5c646c 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -32,6 +32,7 @@
> #include "hal-log.h"
> #include "hal-msg.h"
> #include "../profiles/audio/a2dp-codecs.h"
> +#include <sbc/sbc.h>
> 
> static const uint8_t a2dp_src_uuid[] = {
> 		0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
> @@ -53,6 +54,8 @@ struct audio_input_config {
> 
> struct sbc_data {
> 	a2dp_sbc_t sbc;
> +
> +	sbc_t enc;
> };
> 
> static int sbc_get_presets(struct audio_preset *preset, size_t *len);
> @@ -184,6 +187,70 @@ static int sbc_get_presets(struct audio_preset *preset, size_t *len)
> 	return i;
> }
> 
> +static void sbc_init_encoder(struct sbc_data *sbc_data)
> +{
> +	a2dp_sbc_t *in = &sbc_data->sbc;
> +	sbc_t *out = &sbc_data->enc;
> +
> +	DBG("");
> +
> +	sbc_init(out, 0L);
> +
> +	switch (in->frequency) {
> +	case SBC_SAMPLING_FREQ_16000:
> +		out->frequency = SBC_FREQ_16000;
> +		break;
> +	case SBC_SAMPLING_FREQ_32000:
> +		out->frequency = SBC_FREQ_32000;
> +		break;
> +	case SBC_SAMPLING_FREQ_44100:
> +		out->frequency = SBC_FREQ_44100;
> +		break;
> +	case SBC_SAMPLING_FREQ_48000:
> +		out->frequency = SBC_FREQ_48000;
> +		break;
> +	}
> +
> +	out->subbands = in->subbands == SBC_SUBBANDS_4 ? SBC_SB_4 : SBC_SB_8;
> +
> +	switch (in->channel_mode) {
> +	case SBC_CHANNEL_MODE_MONO:
> +		out->mode = SBC_MODE_MONO;
> +		break;
> +	case SBC_CHANNEL_MODE_DUAL_CHANNEL:
> +		out->mode = SBC_MODE_DUAL_CHANNEL;
> +		break;
> +	case SBC_CHANNEL_MODE_JOINT_STEREO:
> +		out->mode = SBC_MODE_JOINT_STEREO;
> +		break;
> +	case SBC_CHANNEL_MODE_STEREO:
> +		out->mode = SBC_MODE_STEREO;
> +		break;
> +	}
> +
> +	out->endian = SBC_LE;
> +
> +	out->bitpool = in->max_bitpool;
> +
> +	out->allocation = in->allocation_method == SBC_ALLOCATION_SNR ?
> +				SBC_AM_SNR : SBC_AM_LOUDNESS;
> +
> +	switch (in->block_length) {
> +	case SBC_BLOCK_LENGTH_4:
> +		out->blocks = SBC_BLK_4;
> +		break;
> +	case SBC_BLOCK_LENGTH_8:
> +		out->blocks = SBC_BLK_8;
> +		break;
> +	case SBC_BLOCK_LENGTH_12:
> +		out->blocks = SBC_BLK_12;
> +		break;
> +	case SBC_BLOCK_LENGTH_16:
> +		out->blocks = SBC_BLK_16;
> +		break;
> +	}

aren’t the values all the same? This looks pretty complicated for something that should be dead simple. Does Android really had to duplicate every single definition with the same prefix?

> +}
> +
> static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
> {
> 	struct sbc_data *sbc_data;
> @@ -199,6 +266,8 @@ static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
> 
> 	memcpy(&sbc_data->sbc, preset->data, preset->len);
> 
> +	sbc_init_encoder(sbc_data);
> +
> 	*codec_data = sbc_data;
> 
> 	return AUDIO_STATUS_SUCCESS;
> @@ -206,8 +275,11 @@ static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
> 
> static int sbc_cleanup(void *codec_data)
> {
> +	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
> +
> 	DBG("");
> 
> +	sbc_finish(&sbc_data->enc);
> 	free(codec_data);
> 
> 	return AUDIO_STATUS_SUCCESS;

Regards

Marcel

