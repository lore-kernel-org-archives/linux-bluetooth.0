Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] android/handsfree: trivial: Correct comment style
Date: Thu, 17 Apr 2014 15:26:46 +0200
Message-ID: <1401501.1zNi0hi367@uw000953>
In-Reply-To: <1397737431-6101-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1397737431-6101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1397737431-6101-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 17 of April 2014 15:23:51 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/handsfree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 55e151a..51dddb3 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -2204,10 +2204,10 @@ static const struct ipc_handler cmd_handlers[] = {
>  	/* HAL_OP_HANDSFREE_DISCONNECT */
>  	{ handle_disconnect, false,
>  		sizeof(struct hal_cmd_handsfree_disconnect) },
> -	/*HAL_OP_HANDSFREE_CONNECT_AUDIO*/
> +	/* HAL_OP_HANDSFREE_CONNECT_AUDIO */
>  	{ handle_connect_audio, false,
>  		sizeof(struct hal_cmd_handsfree_connect_audio) },
> -	/*HAL_OP_HANDSFREE_DISCONNECT_AUDIO*/
> +	/* HAL_OP_HANDSFREE_DISCONNECT_AUDIO */
>  	{ handle_disconnect_audio, false,
>  		sizeof(struct hal_cmd_handsfree_disconnect_audio) },
>  	/* define HAL_OP_HANDSFREE_START_VR */
> 

This one is now pushed, thanks.

-- 
Best regards, 
Szymon Janc
