Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-avrcp-ctrl: Fill register module command with max clients
Date: Mon, 01 Dec 2014 14:07:15 +0100
Message-ID: <1444475.KsF6FrX5pQ@uw000953>
In-Reply-To: <1417001888-3126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417001888-3126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday 26 of November 2014 12:38:08 Grzegorz Kolodziejczyk wrote:
> Register module command must have declared max clients value before
> registering module. Initial value is set to 1.
> 
> ==2175== Syscall param sendmsg(msg.msg_iov[1]) points to uninitialised byte(s)
> ==2175==    at 0x534AD5D: ??? (in /usr/lib64/libpthread-2.18.so)
> ==2175==    by 0x6B47F8C: hal_ipc_cmd (hal-ipc.c:369)
> ==2175==    by 0x6B42D42: init (hal-avrcp-ctrl.c:85)
> ==2175==    by 0x404ACF: init_p (if-rc-ctrl.c:56)
> ==2175==    by 0x401975: main (haltest.c:428)
> ==2175==  Address 0xffefffcd2 is on thread 1's stack
> ---
>  android/hal-avrcp-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/hal-avrcp-ctrl.c b/android/hal-avrcp-ctrl.c
> index e289fcd..9ae4631 100644
> --- a/android/hal-avrcp-ctrl.c
> +++ b/android/hal-avrcp-ctrl.c
> @@ -81,6 +81,7 @@ static bt_status_t init(btrc_ctrl_callbacks_t *callbacks)
>  
>  	cmd.service_id = HAL_SERVICE_ID_AVRCP_CTRL;
>  	cmd.mode = HAL_MODE_DEFAULT;
> +	cmd.max_clients = 1;
>  
>  	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
>  					sizeof(cmd), &cmd, NULL, NULL, NULL);
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
