Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] android/hal-audio: Add open/close_endpoint helpers
Date: Tue, 04 Mar 2014 10:27:12 +0100
Message-ID: <1902690.WlBXYdsyBj@uw000953>
In-Reply-To: <1393837002-29703-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393837002-29703-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Monday 03 of March 2014 09:56:38 Andrzej Kaczmarek wrote:
> ---
>  android/hal-audio.c | 117 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 66 insertions(+), 51 deletions(-)
> 
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 79a74b8..f6bc998 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -914,6 +914,70 @@ static void unregister_endpoints(void)
>  	}
>  }
>  
> +static int set_blocking(int fd)
> +{
> +	int flags;
> +
> +	flags = fcntl(fd, F_GETFL, 0);
> +	if (flags < 0) {
> +		int err = -errno;
> +		error("fcntl(F_GETFL): %s (%d)", strerror(-err), -err);
> +		return err;
> +	}
> +
> +	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
> +		int err = -errno;
> +		error("fcntl(F_SETFL): %s (%d)", strerror(-err), -err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool open_endpoint(struct audio_endpoint *ep,
> +						struct audio_input_config *cfg)
> +{
> +	struct audio_preset *preset;
> +	const struct audio_codec *codec;
> +	uint16_t mtu;
> +	int fd;
> +
> +	if (ipc_open_stream_cmd(ep->id, &mtu, &fd, &preset) !=
> +							AUDIO_STATUS_SUCCESS)
> +		return false;
> +
> +	if (set_blocking(fd) < 0)
> +		goto failed;
> +
> +	ep->fd = fd;
> +
> +	codec = ep->codec;
> +	codec->init(preset, mtu, &ep->codec_data);
> +	codec->get_config(ep->codec_data, cfg);
> +
> +	free(preset);
> +
> +	return true;
> +
> +failed:
> +	close(fd);
> +	free(preset);
> +
> +	return false;
> +}
> +
> +static void close_endpoint(struct audio_endpoint *ep)
> +{
> +	ipc_close_stream_cmd(ep->id);
> +	if (ep->fd >= 0) {
> +		close(ep->fd);
> +		ep->fd = -1;
> +	}
> +
> +	ep->codec->cleanup(ep->codec_data);
> +	ep->codec_data = NULL;
> +}
> +
>  static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
>  								size_t bytes)
>  {
> @@ -1260,26 +1324,6 @@ static int in_remove_audio_effect(const struct audio_stream *stream,
>  	return -ENOSYS;
>  }
>  
> -static int set_blocking(int fd)
> -{
> -	int flags;
> -
> -	flags = fcntl(fd, F_GETFL, 0);
> -	if (flags < 0) {
> -		int err = -errno;
> -		error("fcntl(F_GETFL): %s (%d)", strerror(-err), -err);
> -		return err;
> -	}
> -
> -	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
> -		int err = -errno;
> -		error("fcntl(F_SETFL): %s (%d)", strerror(-err), -err);
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -
>  static int audio_open_output_stream(struct audio_hw_device *dev,
>  					audio_io_handle_t handle,
>  					audio_devices_t devices,
> @@ -1290,10 +1334,6 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
>  {
>  	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
>  	struct a2dp_stream_out *out;
> -	struct audio_preset *preset;
> -	const struct audio_codec *codec;
> -	uint16_t mtu;
> -	int fd;
>  
>  	out = calloc(1, sizeof(struct a2dp_stream_out));
>  	if (!out)
> @@ -1321,29 +1361,12 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
>  	/* TODO: for now we always use endpoint 0 */
>  	out->ep = &audio_endpoints[0];
>  
> -	if (ipc_open_stream_cmd(out->ep->id, &mtu, &fd, &preset) !=
> -							AUDIO_STATUS_SUCCESS)
> -		goto fail;
> -
> -	if (!preset || fd < 0)
> -		goto fail;
> -
> -	if (set_blocking(fd) < 0) {
> -		free(preset);
> +	if (!open_endpoint(out->ep, &out->cfg))
>  		goto fail;
> -	}
> -
> -	out->ep->fd = fd;
> -	codec = out->ep->codec;
> -
> -	codec->init(preset, mtu, &out->ep->codec_data);
> -	codec->get_config(out->ep->codec_data, &out->cfg);
>  
>  	DBG("rate=%d channels=%d format=%d", out->cfg.rate,
>  					out->cfg.channels, out->cfg.format);
>  
> -	free(preset);
> -
>  	if (out->cfg.channels == AUDIO_CHANNEL_OUT_MONO) {
>  		out->downmix_buf = malloc(FIXED_BUFFER_SIZE / 2);
>  		if (!out->downmix_buf)
> @@ -1369,18 +1392,10 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
>  {
>  	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
>  	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
> -	struct audio_endpoint *ep = a2dp_dev->out->ep;
>  
>  	DBG("");
>  
> -	ipc_close_stream_cmd(ep->id);
> -	if (ep->fd >= 0) {
> -		close(ep->fd);
> -		ep->fd = -1;
> -	}
> -
> -	ep->codec->cleanup(ep->codec_data);
> -	ep->codec_data = NULL;
> +	close_endpoint(a2dp_dev->out->ep);
>  
>  	free(out->downmix_buf);
>  

All patches in this set are now upstream, thanks.

-- 
Best regards, 
Szymon Janc
