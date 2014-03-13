Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Mar 2014 10:30:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: Re: [PATCH BlueZ v1 01/15] gatt: Add function to create constant
 attributes
Message-ID: <20140313083055.GA8329@localhost.P-661HNU-F1>
References: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394641631-1534-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394641631-1534-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Mar 12, 2014, Claudio Takahasi wrote:
> +static inline void put_uuid(const bt_uuid_t *src, void *dst)
> +{
> +	if (src->type == BT_UUID16)
> +		put_unaligned(cpu_to_le16(src->value.u16), (uint16_t *) dst);

I thought you were going to add helpers like put_le16() to shared/util.h
first?

> +static struct btd_attribute *new_const_attribute(const bt_uuid_t *type,
> +							const uint8_t *value,
> +							uint16_t len)
> +{
> +	struct btd_attribute *attr = malloc0(sizeof(struct btd_attribute) +
> +									len);

First of all I think it'd be better (coding style consistency-wise) to
do the allocation separately from the declaration of the variable.
Secondly, malloc0 can return NULL (unlike g_malloc0) so you'd need to
check for that.

Johan
