Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313502238-7581-6-git-send-email-prasadbhat22@gmail.com>
References: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
	<1313502238-7581-6-git-send-email-prasadbhat22@gmail.com>
Date: Thu, 18 Aug 2011 10:31:10 +0300
Message-ID: <CABBYNZL90QXFj=8ge_O=pzob35JLNjRpMWWehyF68_xN3CqtFw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 6/6] This adds video_sink and video_source to audio_device.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prasad Bhat <prasadbhat22@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 16, 2011 at 4:43 PM, Prasad Bhat <prasadbhat22@gmail.com> wrote:
> ---
>  audio/device.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/audio/device.h b/audio/device.h
> index 5117fca..661f112 100644
> --- a/audio/device.h
> +++ b/audio/device.h
> @@ -38,6 +38,11 @@
>  #define AVRCP_REMOTE_UUID      "0000110e-0000-1000-8000-00805f9b34fb"
>  #define AVRCP_TARGET_UUID      "0000110c-0000-1000-8000-00805f9b34fb"
>
> +#define VIDEO_DISTRIBUTION_UUID "00001305-0000-1000-8000-00805f9b34fb"
> +
> +#define VDP_SOURCE_UUID        "00001303-0000-1000-8000-00805f9b34fb"
> +#define VDP_SINK_UUID          "00001304-0000-1000-8000-00805f9b34fb"
> +
>  struct source;
>  struct control;
>  struct target;
> @@ -62,6 +67,8 @@ struct audio_device {
>        struct source *source;
>        struct control *control;
>        struct target *target;
> +       struct video_sink *video_sink;
> +       struct video_source *video_source;

This looks wrong, you should merge those changes where they are necessary.

-- 
Luiz Augusto von Dentz
