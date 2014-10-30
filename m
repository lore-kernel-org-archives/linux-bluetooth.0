Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] unit/hfp: Fix wrong check
Date: Thu, 30 Oct 2014 10:30:06 +0100
Message-ID: <1873008.UsSsUcLRsm@leonov>
In-Reply-To: <1414502688-17686-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1414502688-17686-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 28 of October 2014 15:24:48 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  unit/test-hfp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
> index 24ea402..c11a424 100644
> --- a/unit/test-hfp.c
> +++ b/unit/test-hfp.c
> @@ -154,8 +154,7 @@ static gboolean send_pdu(gpointer user_data)
>  	ssize_t len;
> 
>  	pdu = &context->data->pdu_list[context->pdu_offset++];
> -
> -	if (pdu && !pdu->valid)
> +	if (!pdu || !pdu->valid)
>  		return FALSE;
> 
>  	len = write(context->fd_server, pdu->data, pdu->size);

Patch applied after fixing commit prefix, thanks.

-- 
BR
Szymon Janc
