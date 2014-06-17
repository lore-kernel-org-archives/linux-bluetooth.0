Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 13/17] android/hal-audio: Remove dead code
Date: Tue, 17 Jun 2014 22:27:27 +0200
Message-ID: <2629037.sq5vVFIjgz@athlon>
In-Reply-To: <1402905472-17643-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1402905472-17643-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 16 June 2014 10:57:48 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> The code does not have effect.
> ---
>  android/hal-audio.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 6d2ef3a..36f1f3f 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -286,9 +286,6 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t
> opcode, uint16_t len, goto failed;
>  	}
> 
> -	if (rsp_len)
> -		*rsp_len = cmd.len;
> -
>  	return AUDIO_STATUS_SUCCESS;
> 
>  failed:

This is not correct. rsp_len is also output parameter for this function. If 
caller expects response it should verify it before accessing response.

(although since rsp_len was already dereferenced before null check is not 
really needed here)

-- 
Szymon K. Janc
szymon.janc@gmail.com
