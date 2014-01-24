Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-audio: Workaround AudioFlinger issues
Date: Fri, 24 Jan 2014 11:09:10 +0100
Message-ID: <16961016.o1IkuPxWZ2@uw000953>
In-Reply-To: <1390490712-25124-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390490712-25124-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thursday 23 of January 2014 16:25:12 Andrzej Kaczmarek wrote:
> Audio HAL code calculates accurate input stream buffer size which
> allows to fill media packets with as much data as possible. However,
> in most cases calculated buffer size does not work well with Android
> audio code which causes glitches when playing simultaneously to
> different audio output (like notification) or crashes mediaserver
> when disconnecting with headset.
> 
> This patch changes input buffer size to fixed magic value 20*512 which
> is used in Bluedroid Audio HAL. Such change requires that we need to
> drop assumption that each input buffer can be used to fill exactly one
> media packet and need to use it to fill multiple media packets. To
> avoid buffering in Audio HAL, we allow that last media packet can be
> filled in non-optimal way, i.e. has less data that can fit.
> ---
>  android/hal-audio.c | 86 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 30 deletions(-)
> 
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 4326ccd..f4a4ee1 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -413,6 +413,42 @@ static void sbc_resume(void *codec_data)
>  	sbc_data->frames_sent = 0;
>  }
>  
> +static void write_media_packet(int fd, struct sbc_data *sbc_data,
> +				struct media_packet *mp, size_t data_len)
> +{
> +	struct timespec cur;
> +	struct timespec diff;
> +	unsigned expected_frames;
> +	int ret;
> +
> +	ret = write(fd, mp, sizeof(*mp) + data_len);
> +	if (ret < 0) {
> +		int err = errno;
> +		DBG("error writing data: %d (%s)", err,
> +						strerror(err));
> +	}
> +
> +	sbc_data->frames_sent += mp->payload.frame_count;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &cur);
> +	timespec_diff(&cur, &sbc_data->start, &diff);
> +	expected_frames = (diff.tv_sec * 1000000 + diff.tv_nsec / 1000) /
> +						sbc_data->frame_duration;
> +
> +	/* AudioFlinger does not seem to provide any *working*
> +	 * API to provide data in some interval and will just
> +	 * send another buffer as soon as we process current
> +	 * one. To prevent overflowing L2CAP socket, we need to
> +	 * introduce some artificial delay here base on how many
> +	 * audio frames were sent so far, i.e. if we're not
> +	 * lagging behind audio stream, we can sleep for
> +	 * duration of single media packet.
> +	 */
> +	if (sbc_data->frames_sent >= expected_frames)
> +		usleep(sbc_data->frame_duration *
> +				mp->payload.frame_count);
> +}
> +
>  static ssize_t sbc_write_data(void *codec_data, const void *buffer,
>  				size_t bytes, int fd)
>  {
> @@ -421,9 +457,6 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
>  	size_t encoded = 0;
>  	struct media_packet *mp = (struct media_packet *) sbc_data->out_buf;
>  	size_t free_space = sbc_data->out_buf_size - sizeof(*mp);
> -	struct timespec cur;
> -	struct timespec diff;
> -	unsigned expected_frames;
>  	int ret;
>  
>  	mp->hdr.v = 2;
> @@ -450,39 +483,28 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
>  		consumed += ret;
>  		encoded += written;
>  		free_space -= written;
> -	}
>  
> -	ret = write(fd, mp, sizeof(*mp) + encoded);
> -	if (ret < 0) {
> -		int err = errno;
> -		DBG("error writing data: %d (%s)", err, strerror(err));
> +		/* write data if we either filled media packed or encoded all
> +		 * input data
> +		 */
> +		if (mp->payload.frame_count == sbc_data->frames_per_packet ||
> +				bytes == consumed) {
> +			write_media_packet(fd, sbc_data, mp, encoded);
> +
> +			encoded = 0;
> +			free_space = sbc_data->out_buf_size - sizeof(*mp);
> +			mp->payload.frame_count = 0;
> +		}
>  	}
>  
> -	if (consumed != bytes || free_space != 0) {
> -		/* we should encode all input data and fill output buffer
> +	if (consumed != bytes) {
> +		/* we should encode all input data
>  		 * if we did not, something went wrong but we can't really
>  		 * handle this so this is just sanity check
>  		 */
>  		DBG("some data were not encoded");
>  	}
>  
> -	sbc_data->frames_sent += mp->payload.frame_count;
> -
> -	clock_gettime(CLOCK_MONOTONIC, &cur);
> -	timespec_diff(&cur, &sbc_data->start, &diff);
> -	expected_frames = (diff.tv_sec * 1000000 + diff.tv_nsec / 1000) /
> -				sbc_data->frame_duration;
> -
> -	/* AudioFlinger does not seem to provide any *working* API to provide
> -	 * data in some interval and will just send another buffer as soon as
> -	 * we process current one. To prevent overflowing L2CAP socket, we need
> -	 * to introduce some artificial delay here base on how many audio frames
> -	 * were sent so far, i.e. if we're not lagging behind audio stream, we
> -	 * can sleep for duration of single media packet.
> -	 */
> -	if (sbc_data->frames_sent >= expected_frames)
> -		usleep(sbc_data->frame_duration * mp->payload.frame_count);
> -
>  	/* we always assume that all data was processed and sent */
>  	return bytes;
>  }
> @@ -853,11 +875,15 @@ static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
>  
>  static size_t out_get_buffer_size(const struct audio_stream *stream)
>  {
> -	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
> -
>  	DBG("");
>  
> -	return out->ep->codec->get_buffer_size(out->ep->codec_data);
> +	/* We should return proper buffer size calculated by codec (so each
> +	 * input buffer is encoded into single media packed) but this does not
> +	 * work well with AudioFlinger and causes problems. For this reason we
> +	 * use magic value here and out_write code takes care of splitting
> +	 * input buffer into multiple media packets.
> +	 */
> +	return 20 * 512;
>  }
>  
>  static uint32_t out_get_channels(const struct audio_stream *stream)
> 

Pushed, thanks.

-- 
Best regards, 
Szymon Janc
