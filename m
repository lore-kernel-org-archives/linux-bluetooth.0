Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Mar 2014 10:58:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v7 02/10] gatt: Add write callback to
 btd_gatt_add_char helper
Message-ID: <20140324085808.GA26197@t440s.lan>
References: <1395413930-18292-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395429403-493-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395429403-493-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Mar 21, 2014, Claudio Takahasi wrote:
> This patch adds a function callback for write operations. When a remote
> device writes to a given attribute, the core calls the specified write
> callback informing the attribute server the new characteristic value.
> ---
>  src/gatt-dbus.c |  2 +-
>  src/gatt.c      |  7 ++++---
>  src/gatt.h      | 13 ++++++++++++-
>  3 files changed, 17 insertions(+), 5 deletions(-)

I've applied the first patch but your change to the header file in this
patch is strange:

> +/*
> + * Callbacks from this type are called once the value from the attribute was
> + * written.
> + * @err:	error in -errno format.
> + * @user_data:	user_data passed in btd_attr_write_t callback
> + */
> +typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
> +					const uint8_t *value, size_t len);

There's neither an err parameter nor a user_data parameter in this
callback, so I'm wondering what your code comment refers to? :)

Johan
