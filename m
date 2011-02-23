Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 00:26:08 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/5] Initial Client Characteristic Configuration
 implementation
Message-ID: <20110223032608.GE16014@jh-x301>
References: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
 <1298408491-11154-2-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298408491-11154-2-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Feb 22, 2011, Anderson Lizardo wrote:
> +static uint8_t client_set_notifications(struct attribute *attr,
> +							gpointer user_data)
> +{
> +	struct gatt_channel *channel = user_data;
> +	struct attribute *a, *last_chr_val = NULL;
> +	uint16_t handle, cfg_val;
> +	uuid_t uuid;
> +	GSList *l;
> +
> +	cfg_val = att_get_u16(attr->data);
> +
> +	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
> +	for (l = database, handle = 0; l != NULL; l = l->next) {
> +		a = l->data;

The variable "a" is only used inside the for-loop so it should be
declared inside it as well. I think you can move handle inside the loop
as well as long as you declare it static (so it only gets initialized to
0 on the first iteration).

Johan
