Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] android/gatt: Fix missing error response to find by type value request
Date: Thu, 11 Dec 2014 14:30:36 +0100
Message-ID: <1502650.D3eWmbCRKv@uw000953>
In-Reply-To: <1418222421-6049-1-git-send-email-mariusz.skamra@tieto.com>
References: <1418222421-6049-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 10 of December 2014 15:40:21 Mariusz Skamra wrote:
> This patch fixes Find By Type Value Request issue.
> When the attribute queue is empty, error response should be sent.
> ---
>  android/gatt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index b2ce9c1..58bc22d 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6189,6 +6189,17 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
>  
>  	gatt_db_find_by_type(gatt_db, start, end, &uuid, q);
>  
> +	if (queue_isempty(q)) {
> +		size_t mtu;
> +		uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
> +
> +		len = enc_error_resp(ATT_OP_FIND_BY_TYPE_REQ, start,
> +					ATT_ECODE_ATTR_NOT_FOUND, rsp, mtu);
> +		g_attrib_send(device->attrib, 0, rsp, len, NULL, NULL, NULL);
> +		queue_destroy(q, NULL);
> +		return 0;
> +	}
> +
>  	while (queue_peek_head(q)) {
>  		struct gatt_db_attribute *attrib = queue_pop_head(q);
>  		struct pending_request *data;
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
