Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Fix server send response status value
Date: Thu, 11 Dec 2014 18:55:39 +0100
Message-ID: <2458956.8XeFMp2OEh@leonov>
In-Reply-To: <1418318213-23944-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418318213-23944-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 11 of December 2014 18:16:52 Jakub Tyszkowski wrote:
> Cast status to uint8_t, due to (byte) cast in java layer.
> ---
>  android/gatt.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 84fba64..64163f8 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5551,7 +5551,8 @@ static void handle_server_send_response(const void
> *buf, uint16_t len) * gatt_db_attribute_write().
>  		 */
>  		req = queue_peek_head(conn->device->pending_requests);
> -		req->error = err_to_att(cmd->status);
> +		/* Cast status to uint8_t, due to (byte) cast in java layer. */
> +		req->error = err_to_att((uint8_t)cmd->status);
>  		req->state = REQUEST_DONE;
> 
>  		/*
> @@ -5560,15 +5561,16 @@ static void handle_server_send_response(const void
> *buf, uint16_t len) */
>  	}
> 
> +	/* Cast status to uint8_t, due to (byte) cast in java layer. */
>  	if (transaction->opcode < ATT_OP_WRITE_REQ)
>  		gatt_db_attribute_read_result(transaction->attrib,
> -						transaction->serial_id,
> -						err_to_att(cmd->status),
> -						cmd->data, cmd->len);
> +					transaction->serial_id,
> +					err_to_att((uint8_t)cmd->status),
> +					cmd->data, cmd->len);
>  	else
>  		gatt_db_attribute_write_result(transaction->attrib,
> -						transaction->serial_id,
> -						err_to_att(cmd->status));
> +					transaction->serial_id,
> +					err_to_att((uint8_t)cmd->status));
> 
>  	send_dev_complete_response(conn->device, transaction->opcode);

Applied (after fixing some code style issues), thanks.

-- 
BR
Szymon Janc
