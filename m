Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 16/17] android/hal-sco: Remove unneeded statement
Date: Tue, 17 Jun 2014 22:31:34 +0200
Message-ID: <1665966.txu3kZvU0U@athlon>
In-Reply-To: <1402905472-17643-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1402905472-17643-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 16 June 2014 10:57:51 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/hal-sco.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/android/hal-sco.c b/android/hal-sco.c
> index faed406..edff13e 100644
> --- a/android/hal-sco.c
> +++ b/android/hal-sco.c
> @@ -265,9 +265,6 @@ static int sco_ipc_cmd(uint8_t service_id, uint8_t
> opcode, uint16_t len, goto failed;
>  	}
> 
> -	if (rsp_len)
> -		*rsp_len = cmd.len;
> -
>  	return SCO_STATUS_SUCCESS;
> 
>  failed:

This is same as comment on similar patch for hal-audio.

-- 
Szymon K. Janc
szymon.janc@gmail.com
