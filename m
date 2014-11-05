Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] android/hal-sco: Add support for new Android API
Date: Wed, 05 Nov 2014 12:26:41 +0100
Message-ID: <3463493.30NlPItQe3@uw000953>
In-Reply-To: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 05 of November 2014 10:41:16 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add new parameters to sco_open_input_stream() and
> sco_open_output_stream() for the new API.
> ---
>  android/hal-sco.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/android/hal-sco.c b/android/hal-sco.c
> index 91a3baf..d9c9a68 100644
> --- a/android/hal-sco.c
> +++ b/android/hal-sco.c
> @@ -612,12 +612,13 @@ static int out_remove_audio_effect(const struct audio_stream *stream,
>  	return -ENOSYS;
>  }
>  
> -static int sco_open_output_stream(struct audio_hw_device *dev,
> +static int sco_open_output_stream_real(struct audio_hw_device *dev,
>  					audio_io_handle_t handle,
>  					audio_devices_t devices,
>  					audio_output_flags_t flags,
>  					struct audio_config *config,
> -					struct audio_stream_out **stream_out)
> +					struct audio_stream_out **stream_out,
> +					const char *address)
>  {
>  	struct sco_dev *adev = (struct sco_dev *) dev;
>  	struct sco_stream_out *out;
> @@ -741,6 +742,31 @@ failed:
>  	return ret;
>  }
>  
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +static int sco_open_output_stream(struct audio_hw_device *dev,
> +					audio_io_handle_t handle,
> +					audio_devices_t devices,
> +					audio_output_flags_t flags,
> +					struct audio_config *config,
> +					struct audio_stream_out **stream_out,
> +					const char *address)
> +{
> +	return  sco_open_output_stream_real(dev, handle, devices, flags,
> +						config, stream_out, address);
> +}
> +#else
> +static int sco_open_output_stream(struct audio_hw_device *dev,
> +					audio_io_handle_t handle,
> +					audio_devices_t devices,
> +					audio_output_flags_t flags,
> +					struct audio_config *config,
> +					struct audio_stream_out **stream_out)
> +{
> +	return sco_open_output_stream_real(dev, handle, devices, flags,
> +						config, stream_out, NULL);
> +}
> +#endif
> +
>  static void sco_close_output_stream(struct audio_hw_device *dev,
>  					struct audio_stream_out *stream_out)
>  {
> @@ -1060,11 +1086,14 @@ static uint32_t in_get_input_frames_lost(struct audio_stream_in *stream)
>  	return -ENOSYS;
>  }
>  
> -static int sco_open_input_stream(struct audio_hw_device *dev,
> +static int sco_open_input_stream_real(struct audio_hw_device *dev,
>  					audio_io_handle_t handle,
>  					audio_devices_t devices,
>  					struct audio_config *config,
> -					struct audio_stream_in **stream_in)
> +					struct audio_stream_in **stream_in,
> +					audio_input_flags_t flags,
> +					const char *address,
> +					audio_source_t source)
>  {
>  	struct sco_dev *sco_dev = (struct sco_dev *) dev;
>  	struct sco_stream_in *in;
> @@ -1165,6 +1194,32 @@ failed2:
>  	return ret;
>  }
>  
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +static int sco_open_input_stream(struct audio_hw_device *dev,
> +					audio_io_handle_t handle,
> +					audio_devices_t devices,
> +					struct audio_config *config,
> +					struct audio_stream_in **stream_in,
> +					audio_input_flags_t flags,
> +					const char *address,
> +					audio_source_t source)
> +{
> +	return sco_open_input_stream_real(dev, handle, devices, config,
> +						stream_in, flags, address,
> +						source);
> +}
> +#else
> +static int sco_open_input_stream(struct audio_hw_device *dev,
> +					audio_io_handle_t handle,
> +					audio_devices_t devices,
> +					struct audio_config *config,
> +					struct audio_stream_in **stream_in)
> +{
> +	return sco_open_input_stream_real(dev, handle, devices, config,
> +						stream_in, 0, NULL, 0);
> +}
> +#endif
> +
>  static void sco_close_input_stream(struct audio_hw_device *dev,
>  					struct audio_stream_in *stream_in)
>  {

All patches in this set have been applied, thanks. 

-- 
Best regards, 
Szymon Janc
