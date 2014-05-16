Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] shared/gatt: Fix freeing uninitialized attributes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400234827-24438-1-git-send-email-marcin.kraglak@tieto.com>
Date: Fri, 16 May 2014 08:17:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9A0C0D87-616B-4D33-A61F-85E5F954B77A@holtmann.org>
References: <1400234827-24438-1-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> Don't free uninitialized attributes. It could cause NULL pointer
> dereference.
> ---
> src/shared/gatt-db.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index d9f63be..36316af 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -99,6 +99,10 @@ static void attribute_destroy(void *data)
> {
> 	struct gatt_db_attribute *attribute = data;
> 
> +	/* Attribute was not initialized by user */
> +	if (!attribute)
> +		return;
> +
> 	free(attribute->value);
> 	free(attribute);

I think the real question is why a function with void *data is called with a NULL pointer in the first place. That is the thing you should fix and not hack around this by doing a NULL check. So this is clearly a function that you gave to callback somehow, fix that part. I do not remember any of the code in src/shared/ that has the destroy callbacks requiring any of this. We are expecting that data is valid.

Regards

Marcel

