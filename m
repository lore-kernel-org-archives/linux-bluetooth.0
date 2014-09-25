Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 01/15] android/tester: Fix condition check
Date: Thu, 25 Sep 2014 11:11:10 +0200
Message-ID: <8024219.b1VH3u4MZQ@uw000953>
In-Reply-To: <1411558680-26856-2-git-send-email-marcin.kraglak@tieto.com>
References: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com> <1411558680-26856-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 24 of September 2014 13:37:46 Marcin Kraglak wrote:
> It may cause NULL pointer dereference.
> ---
>  android/tester-gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 42f3733..f30d0eb 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -545,7 +545,7 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>  		}
>  		queue_pop_head(t_data->pdus);
>  		gatt_pdu = queue_pop_head(t_data->pdus);
> -		if (!gatt_pdu->data)
> +		if (!gatt_pdu)

Shouldn't this be:

if (!gatt_pdu || !gatt_pdu->data)

?


>  			break;
>  
>  		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
> 

-- 
Best regards, 
Szymon Janc
