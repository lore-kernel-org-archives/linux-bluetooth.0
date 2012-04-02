Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Apr 2012 17:54:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7 1/6] att: add remote btd_device to ATT read/write
 callbacks
Message-ID: <20120402145415.GB31518@x220.P-661HNU-F1>
References: <1333365444-9029-1-git-send-email-arik@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333365444-9029-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Mon, Apr 02, 2012, Arik Nemtsov wrote:
> +	uint8_t (*read_cb)(struct attribute *a, struct btd_device *device,
> +			   gpointer user_data);
> +	uint8_t (*write_cb)(struct attribute *a, struct btd_device *device,
> +			    gpointer user_data);

Please don't mix tabs and spaces for indentation. We only use tabs.

> @@ -452,7 +457,8 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
>  								a->read_reqs);
>  
>  		if (status == 0x00 && a->read_cb)
> -			status = a->read_cb(a, a->cb_user_data);
> +			status = a->read_cb(a, channel->device,
> +					    a->cb_user_data);

Same here.

> @@ -541,7 +547,8 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
>  								a->read_reqs);
>  
>  		if (status == 0x00 && a->read_cb)
> -			status = a->read_cb(a, a->cb_user_data);
> +			status = a->read_cb(a, channel->device,
> +					    a->cb_user_data);

And here.

> @@ -833,7 +840,8 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
>  							value, vlen, NULL);
>  
>  		if (a->write_cb) {
> -			status = a->write_cb(a, a->cb_user_data);
> +			status = a->write_cb(a, channel->device,
> +					     a->cb_user_data);

And here.

Johan
