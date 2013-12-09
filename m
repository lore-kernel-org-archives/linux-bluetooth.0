Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix missing failure check in ipc_init
Date: Mon, 09 Dec 2013 09:55:30 +0100
Message-ID: <3479757.7T9GkbTkhq@uw000953>
In-Reply-To: <1386074528-8020-1-git-send-email-szymon.janc@tieto.com>
References: <1386074528-8020-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> If connecting command socket failed daemon should be terminated.
> ---
>  android/ipc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/ipc.c b/android/ipc.c
> index 1d369a8..6f940cd 100644
> --- a/android/ipc.c
> +++ b/android/ipc.c
> @@ -229,6 +229,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
>  void ipc_init(void)
>  {
>  	cmd_io = connect_hal(cmd_connect_cb);
> +	if (!cmd_io)
> +		raise(SIGTERM);
>  }
>  
>  void ipc_cleanup(void)
> 

ping
