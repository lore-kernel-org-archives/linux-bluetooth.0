Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 11:12:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: Re: [PATCH 22/36] android/gatt: Add support for ATT read by type
Message-ID: <20140429081228.GG21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398734107-4793-24-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398734107-4793-24-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> +static void copy_to_att_list_type(void *data, void *user_data)
> +{
> +	struct copy_att_list_data *l = user_data;
> +	struct gatt_db_handle_value *hdl_val = data;
> +	uint8_t *value;
> +
> +	value = (void *)l->adl->data[l->iterator++];

Same thing here with the type cast.

Johan
