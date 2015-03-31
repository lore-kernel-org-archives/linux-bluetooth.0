Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-sco: Fix divide by zero
Date: Tue, 31 Mar 2015 20:08:09 +0200
Message-ID: <1449857.uyI4ObloS9@leonov>
In-Reply-To: <1427814210-27752-1-git-send-email-szymon.janc@tieto.com>
References: <1427814210-27752-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 31 of March 2015 17:03:30 Szymon Janc wrote:
> audio_stream_in_frame_size or audio_stream_frame_size can return 0 so
> this needs to be checked before divide.
> ---
>  android/hal-sco.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/android/hal-sco.c b/android/hal-sco.c
> index 380b2a8..2c95866 100644
> --- a/android/hal-sco.c
> +++ b/android/hal-sco.c
> @@ -1054,17 +1054,23 @@ static ssize_t in_read(struct audio_stream_in
> *stream, void *buffer, size_t bytes)
>  {
>  	struct sco_stream_in *in = (struct sco_stream_in *) stream;
> -#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> -	size_t frame_size = audio_stream_in_frame_size(&in->stream);
> -#else
> -	size_t frame_size = audio_stream_frame_size(&stream->common);
> -#endif
> -	size_t frame_num = bytes / frame_size;
> -	size_t input_frame_num = frame_num;
> +	size_t frame_size, frame_num, input_frame_num;
>  	void *read_buf = buffer;
>  	size_t total = bytes;
>  	int ret;
> 
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +	frame_size = audio_stream_in_frame_size(&in->stream);
> +#else
> +	frame_size = audio_stream_frame_size(&stream->common);
> +#endif
> +
> +	if (!frame_size)
> +		return -1;
> +
> +	frame_num = bytes / frame_size;
> +	input_frame_num = frame_num;
> +
>  	DBG("Read from fd %d bytes %zu", sco_fd, bytes);
> 
>  	if (ipc_get_sco_fd(&in->bd_addr) != SCO_STATUS_SUCCESS)

Applied.

-- 
BR
Szymon Janc
