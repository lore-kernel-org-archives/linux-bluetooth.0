Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/11] android/unit: Fix checking for expected termination
Date: Tue, 04 Feb 2014 21:37:33 +0100
Message-ID: <4257402.zuGhVzPUGX@athlon>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 04 February 2014 15:38:59 Jakub Tyszkowski wrote:
> This fix makes sure that when signalled termination is expected,
> it actually happens. If IPC termination is expected no response will be
> sent, so cmd_watch will never be executed. But if it is executed when
> expecting termination, its a failure.
> ---
>  android/test-ipc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/test-ipc.c b/android/test-ipc.c
> index 8af5739..d0f3f6b 100644
> --- a/android/test-ipc.c
> +++ b/android/test-ipc.c
> @@ -82,6 +82,8 @@ static gboolean cmd_watch(GIOChannel *io, GIOCondition
> cond, uint8_t buf[128];
>  	int sk;
> 
> +	g_assert(test_data->expected_signal == 0);
> +
>  	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
>  		g_assert(FALSE);
>  		return FALSE;

All patches are now upstream, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
