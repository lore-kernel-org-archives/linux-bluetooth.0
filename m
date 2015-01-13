Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/11] android/gatt: Fix not handling service change ccc write execute
Date: Tue, 13 Jan 2015 14:48:52 +0100
Message-ID: <2404014.dfCGdSWY2H@uw000953>
In-Reply-To: <1420708669-32600-7-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com> <1420708669-32600-7-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 08 of January 2015 10:17:45 Jakub Tyszkowski wrote:
> This adds prepare and execute write handling on Service Change CCC
> descriptor.
> ---
>  android/gatt.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index b749705..c00eb9e 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -171,6 +171,8 @@ struct gatt_device {
>  	struct queue *autoconnect_apps;
>  
>  	struct queue *pending_requests;
> +	bool wait_svc_change_execute_write;
> +	uint16_t svc_change_ccc;
>  };
>  
>  struct app_connection {
> @@ -6599,6 +6601,28 @@ static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
>  	uint8_t value;
>  	struct pending_request *data;
>  
> +	/* handle embeded ccc */
> +	if (dev->wait_svc_change_execute_write) {
> +		uint8_t flags;
> +
> +		dec_exec_write_req(cmd, cmd_len, &flags);

This could fail so we should check it, otherwise we might use garbage flags.

> +		dev->wait_svc_change_execute_write = false;
> +
> +		if (!!flags)

This !! is not needed here.

> +			bt_store_gatt_ccc(&dev->bdaddr, dev->svc_change_ccc);
> +
> +		if (!pending_execute_write()) {
> +			size_t mtu;
> +			uint16_t len = 0;

This initialization is not needed.

> +			uint8_t *rsp = g_attrib_get_buffer(dev->attrib, &mtu);
> +
> +			len = enc_exec_write_resp(rsp);
> +			g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL,
> +									NULL);
> +			return 0;
> +		}
> +	}
> +
>  	/*
>  	 * Check if there was any write prep before.
>  	 * TODO: Try to find better error code if possible
> @@ -7012,8 +7036,16 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
>  		return;
>  	}
>  
> -	/* Set services changed indication value */
> -	bt_store_gatt_ccc(bdaddr, get_le16(value));
> +	switch (opcode) {
> +	case ATT_OP_PREP_WRITE_REQ:
> +		dev->wait_svc_change_execute_write = true;
> +		dev->svc_change_ccc = get_le16(value);
> +		break;
> +	default:
> +		/* Set services changed indication value */
> +		bt_store_gatt_ccc(bdaddr, get_le16(value));
> +		break;
> +	}
>  
>  	gatt_db_attribute_write_result(attrib, id, 0);
>  }
> 

-- 
Best regards, 
Szymon Janc
