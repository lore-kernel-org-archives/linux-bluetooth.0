Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] androd/client: Extend history line size and depth
Date: Fri, 05 Sep 2014 15:29:46 +0200
Message-ID: <1571863.mA3dO0Y7oz@uw000953>
In-Reply-To: <1409921307-31445-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1409921307-31445-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 05 of September 2014 14:48:26 Grzegorz Kolodziejczyk wrote:
> For some commands current history line size isn't enough to store it
> complete. For complex/long run, extended history depth can be helpful.
> ---
>  android/client/history.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/client/history.c b/android/client/history.c
> index 3dae27a..ca4664c 100644
> --- a/android/client/history.c
> +++ b/android/client/history.c
> @@ -24,8 +24,8 @@
>  
>  /* Very simple history storage for easy usage of tool */
>  
> -#define HISTORY_DEPTH 20
> -#define LINE_SIZE 100
> +#define HISTORY_DEPTH 40
> +#define LINE_SIZE 200
>  static char lines[HISTORY_DEPTH][LINE_SIZE];
>  static int last_line = 0;
>  static int history_size = 0;
> 

This patch is now applied. Thanks.

-- 
Best regards, 
Szymon Janc
