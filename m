Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/gatt: Fix not setting error properly for exec write
Date: Wed, 10 Dec 2014 14:19:34 +0100
Message-ID: <39396672.1P6CpeBUxl@leonov>
In-Reply-To: <1418215251-24018-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418215251-24018-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 10 of December 2014 13:40:49 Jakub Tyszkowski wrote:
> We were not properly propagating errors returned by applications.
> ---
>  android/gatt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index e24feb7..18a5092 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5544,6 +5544,7 @@ static void handle_server_send_response(const void
> *buf, uint16_t len) * gatt_db_attribute_write().
>  		 */
>  		req = queue_peek_head(conn->device->pending_requests);
> +		req->error = err_to_att(cmd->status);
>  		req->state = REQUEST_DONE;
> 
>  		/*

All patches applied (after fixing typo in last commit message), thanks.

-- 
BR
Szymon Janc
