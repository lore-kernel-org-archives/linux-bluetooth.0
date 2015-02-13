Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Feb 2015 13:33:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com,
	cpgs@samsung.com
Subject: Re: [PATCH] gatt-server: Fix mutlpile definition of same func
Message-ID: <20150213113347.GA11794@t440s.ger.corp.intel.com>
References: <1423226839-23935-1-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423226839-23935-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 06, 2015, Gowtham Anandha Babu wrote:
> --- a/src/shared/gatt-helpers.h
> +++ b/src/shared/gatt-helpers.h
> @@ -105,3 +105,5 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
>  					bt_gatt_discovery_callback_t callback,
>  					void *user_data,
>  					bt_gatt_destroy_func_t destroy);
> +
> +void put_uuid_le(const bt_uuid_t *src, void *dst);

gatt-helpers.h uses a namespace prefix of "bt_gatt" so you should at the
very least conform to that. The function name would then become e.g.
bt_gatt_put_uuid(). Besides that I don't have any objections to the
patch.

Johan
