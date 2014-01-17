Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 5/9] android/hal-audio: Calculate SBC stream parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389973213-30251-6-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Fri, 17 Jan 2014 10:25:19 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <816CDF1A-CF41-445B-9CAF-CE5A1E06C940@holtmann.org>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com> <1389973213-30251-6-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This patch adds necessary calculations for SBC stream parameters.
> 
> Both input and output buffers are expected to have exact amount of
> data to fill single media packet (based on transport channel MTU).
> 
> Frame duration will be used to synchronize input and output streams.
> ---
> android/hal-audio.c | 50 ++++++++++++++++++++++++++++++-----
> android/rtp.h       | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 120 insertions(+), 6 deletions(-)
> create mode 100644 android/rtp.h
> 
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index e5c646c..3f53295 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -33,6 +33,7 @@
> #include "hal-msg.h"
> #include "../profiles/audio/a2dp-codecs.h"
> #include <sbc/sbc.h>
> +#include "rtp.h"
> 
> static const uint8_t a2dp_src_uuid[] = {
> 		0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
> @@ -46,6 +47,12 @@ static pthread_t ipc_th = 0;
> static pthread_mutex_t close_mutex = PTHREAD_MUTEX_INITIALIZER;
> static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
> 
> +struct media_packet {
> +	struct rtp_header hdr;
> +	struct rtp_payload payload;
> +	uint8_t data[0];
> +};
> +
> struct audio_input_config {
> 	uint32_t rate;
> 	uint32_t channels;
> @@ -56,10 +63,19 @@ struct sbc_data {
> 	a2dp_sbc_t sbc;
> 
> 	sbc_t enc;
> +
> +	size_t in_frame_len;
> +	size_t in_buf_size;
> +
> +	size_t out_buf_size;
> +	uint8_t *out_buf;
> +
> +	unsigned frame_duration;
> };
> 
> static int sbc_get_presets(struct audio_preset *preset, size_t *len);
> -static int sbc_codec_init(struct audio_preset *preset, void **codec_data);
> +static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
> +				void **codec_data);
> static int sbc_cleanup(void *codec_data);
> static int sbc_get_config(void *codec_data,
> 					struct audio_input_config *config);
> @@ -69,7 +85,8 @@ struct audio_codec {
> 
> 	int (*get_presets) (struct audio_preset *preset, size_t *len);
> 
> -	int (*init) (struct audio_preset *preset, void **codec_data);
> +	int (*init) (struct audio_preset *preset, uint16_t mtu,
> +				void **codec_data);
> 	int (*cleanup) (void *codec_data);
> 	int (*get_config) (void *codec_data,
> 					struct audio_input_config *config);
> @@ -251,9 +268,14 @@ static void sbc_init_encoder(struct sbc_data *sbc_data)
> 	}
> }
> 
> -static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
> +static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
> +				void **codec_data)
> {
> 	struct sbc_data *sbc_data;
> +	size_t hdr_len = sizeof(struct media_packet);
> +	size_t in_frame_len;
> +	size_t out_frame_len;
> +	size_t num_frames;
> 
> 	DBG("");
> 
> @@ -268,6 +290,18 @@ static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
> 
> 	sbc_init_encoder(sbc_data);
> 
> +	in_frame_len = sbc_get_codesize(&sbc_data->enc);
> +	out_frame_len = sbc_get_frame_length(&sbc_data->enc);
> +	num_frames = (mtu - hdr_len) / out_frame_len;
> +
> +	sbc_data->in_frame_len = in_frame_len;
> +	sbc_data->in_buf_size = num_frames * in_frame_len;
> +
> +	sbc_data->out_buf_size = hdr_len + num_frames * out_frame_len;
> +	sbc_data->out_buf = calloc(1, sbc_data->out_buf_size);
> +
> +	sbc_data->frame_duration = sbc_get_frame_duration(&sbc_data->enc);
> +
> 	*codec_data = sbc_data;
> 
> 	return AUDIO_STATUS_SUCCESS;
> @@ -280,6 +314,7 @@ static int sbc_cleanup(void *codec_data)
> 	DBG("");
> 
> 	sbc_finish(&sbc_data->enc);
> +	free(sbc_data->out_buf);
> 	free(codec_data);
> 
> 	return AUDIO_STATUS_SUCCESS;
> @@ -511,7 +546,7 @@ static int ipc_close_cmd(uint8_t endpoint_id)
> 	return result;
> }
> 
> -static int ipc_open_stream_cmd(uint8_t endpoint_id,
> +static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu,
> 					struct audio_preset **caps)
> {
> 	char buf[BLUEZ_AUDIO_MTU];
> @@ -534,6 +569,7 @@ static int ipc_open_stream_cmd(uint8_t endpoint_id,
> 	if (result == AUDIO_STATUS_SUCCESS) {
> 		size_t buf_len = sizeof(struct audio_preset) +
> 					rsp->preset[0].len;
> +		*mtu = rsp->mtu;
> 		*caps = malloc(buf_len);
> 		memcpy(*caps, &rsp->preset, buf_len);
> 	} else {
> @@ -919,6 +955,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
> 	struct a2dp_stream_out *out;
> 	struct audio_preset *preset;
> 	const struct audio_codec *codec;
> +	uint16_t mtu;
> 
> 	out = calloc(1, sizeof(struct a2dp_stream_out));
> 	if (!out)
> @@ -946,7 +983,8 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
> 	/* TODO: for now we always use endpoint 0 */
> 	out->ep = &audio_endpoints[0];
> 
> -	if (ipc_open_stream_cmd(out->ep->id, &preset) != AUDIO_STATUS_SUCCESS)
> +	if (ipc_open_stream_cmd(out->ep->id, &mtu, &preset) !=
> +			AUDIO_STATUS_SUCCESS)
> 		goto fail;
> 
> 	if (!preset)
> @@ -954,7 +992,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
> 
> 	codec = out->ep->codec;
> 
> -	codec->init(preset, &out->ep->codec_data);
> +	codec->init(preset, mtu, &out->ep->codec_data);
> 	codec->get_config(out->ep->codec_data, &out->cfg);
> 
> 	DBG("rate=%d channels=%d format=%d", out->cfg.rate,
> diff --git a/android/rtp.h b/android/rtp.h
> new file mode 100644
> index 0000000..45fddcf
> --- /dev/null
> +++ b/android/rtp.h
> @@ -0,0 +1,76 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */

where is this file coming from? Why do we need a copy of it?

Regards

Marcel

