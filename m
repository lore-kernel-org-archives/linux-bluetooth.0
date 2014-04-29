Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 11:11:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 21/36] android/gatt: Add support for ATT read by group
 type
Message-ID: <20140429081150.GF21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398734107-4793-23-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398734107-4793-23-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> +struct copy_att_list_data {
> +	int iterator;
> +	struct att_data_list *adl;
> +};
> +
> +static void copy_to_att_list(void *data, void *user_data)
> +{
> +	struct copy_att_list_data *l = user_data;
> +	struct gatt_db_group *group = data;
> +	uint8_t *value;
> +
> +	value = (void *)l->adl->data[l->iterator++];

Is this type-cast really needed? Looking at the definition of struct
att_data_list in attrib/att.h it seems it should not be needed. Anyway,
if it is needed there's a missing space again there.

Johan
