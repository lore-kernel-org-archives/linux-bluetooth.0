Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] health: Fix not setting error
Date: Tue, 17 Jun 2014 20:55:10 +0200
Message-ID: <2367616.CAGmRrXdpA@athlon>
In-Reply-To: <1403013181-8793-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403013181-8793-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 17 June 2014 16:53:01 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> When error is not set err->message may be accessed from the other code
> resulting in NULL dereference.
> ---
>  android/mcap-lib.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/mcap-lib.c b/android/mcap-lib.c
> index b04eaac..e0e1258 100644
> --- a/android/mcap-lib.c
> +++ b/android/mcap-lib.c
> @@ -1932,6 +1932,8 @@ gboolean mcap_create_mcl(struct mcap_instance *mi,
>  		}
>  		mcap_mcl_unref(con->mcl);
>  		g_free(con);
> +		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
> +							"MCP connect failed");
>  		return FALSE;
>  	}

Wouldn't error be already set by bt_io_connect() in that case?

-- 
Szymon K. Janc
szymon.janc@gmail.com
