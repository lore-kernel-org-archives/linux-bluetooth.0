Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/ipc: Fix arguments order in DBG
Date: Mon, 13 Jan 2014 09:11:22 +0100
Message-ID: <1399573.9X4qKIHYRQ@uw000953>
In-Reply-To: <1389563085-9731-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389563085-9731-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Sunday 12 of January 2014 22:44:45 Andrzej Kaczmarek wrote:
> ---
>  android/ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/ipc.c b/android/ipc.c
> index 03bdc35..a31d315 100644
> --- a/android/ipc.c
> +++ b/android/ipc.c
> @@ -88,7 +88,7 @@ int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
>  	if ((handler->var_len && handler->data_len > msg->len) ||
>  			(!handler->var_len && handler->data_len != msg->len)) {
>  		DBG("invalid size for opcode 0x%x service 0x%x",
> -						msg->service_id, msg->opcode);
> +						msg->opcode, msg->service_id);
>  		return -EMSGSIZE;
>  	}
>  
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
