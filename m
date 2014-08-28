Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/avdtp: Move PSM definition to AVDTP header
Date: Thu, 28 Aug 2014 20:27:02 +0200
Message-ID: <2398138.ZifKGGsSqL@athlon>
In-Reply-To: <1409141460-8976-1-git-send-email-szymon.janc@tieto.com>
References: <1409141460-8976-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 27 August 2014 14:11:00 Szymon Janc wrote:
> ---
>  android/a2dp.c  | 5 ++---
>  android/avdtp.c | 2 --
>  android/avdtp.h | 2 ++
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/android/a2dp.c b/android/a2dp.c
> index dd8bcb8..10f5523 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -49,7 +49,6 @@
>  #include "avrcp.h"
>  #include "audio-msg.h"
> 
> -#define L2CAP_PSM_AVDTP 0x19
>  #define SVC_HINT_CAPTURING 0x08
>  #define IDLE_TIMEOUT 1
>  #define AUDIO_RETRY_TIMEOUT 2
> @@ -201,7 +200,7 @@ static bool a2dp_device_connect(struct a2dp_device *dev,
> BtIOConnect cb) dev->io = bt_io_connect(cb, dev, NULL, &err,
>  					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
>  					BT_IO_OPT_DEST_BDADDR, &dev->dst,
> -					BT_IO_OPT_PSM, L2CAP_PSM_AVDTP,
> +					BT_IO_OPT_PSM, AVDTP_PSM,
>  					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>  					BT_IO_OPT_INVALID);
>  	if (err) {
> @@ -1694,7 +1693,7 @@ bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t
> *addr, uint8_t mode)
> 
>  	server = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
>  				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
> -				BT_IO_OPT_PSM, L2CAP_PSM_AVDTP,
> +				BT_IO_OPT_PSM, AVDTP_PSM,
>  				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>  				BT_IO_OPT_MASTER, true,
>  				BT_IO_OPT_INVALID);
> diff --git a/android/avdtp.c b/android/avdtp.c
> index 3985fb3..6471424 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -44,8 +44,6 @@
>  #include "avdtp.h"
>  #include "../profiles/audio/a2dp-codecs.h"
> 
> -#define AVDTP_PSM 25
> -
>  #define MAX_SEID 0x3E
> 
>  #ifndef MAX
> diff --git a/android/avdtp.h b/android/avdtp.h
> index 9d683c4..28895ea 100644
> --- a/android/avdtp.h
> +++ b/android/avdtp.h
> @@ -34,6 +34,8 @@ struct avdtp_error {
>  	} err;
>  };
> 
> +#define AVDTP_PSM 25
> +
>  /* SEP capability categories */
>  #define AVDTP_MEDIA_TRANSPORT			0x01
>  #define AVDTP_REPORTING				0x02

Pushed.

-- 
Szymon K. Janc
szymon.janc@gmail.com
