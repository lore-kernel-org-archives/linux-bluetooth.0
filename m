Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH BlueZ v2 6/9] Fix memory leak when loading keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 07 Jul 2011 10:35:41 +0200
In-Reply-To: <1309983041-23744-7-git-send-email-vinicius.gomes@openbossa.org>
References: <y>
	 <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1309983041-23744-7-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310027746.21109.56.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincius.

> Core bluetoothd doesn't need to have a reference to the link key list,
> so we pass a reference to the list and free it as soon as possible. If any
> user need to keep a copy of that list around, they need to copy it. This makes
> the memory management more consistent.
> ---
>  plugins/hciops.c |   14 +++++++++++++-
>  src/adapter.c    |    6 +++---
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/plugins/hciops.c b/plugins/hciops.c
> index 207e187..56daf0d 100644
> --- a/plugins/hciops.c
> +++ b/plugins/hciops.c
> @@ -3450,6 +3450,7 @@ static int hciops_restore_powered(int index)
>  static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
>  {
>  	struct dev_info *dev = &devs[index];
> +	GSList *l, *n, *new;
>  
>  	DBG("hci%d keys %d debug_keys %d", index, g_slist_length(keys),
>  								debug_keys);
> @@ -3457,7 +3458,18 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
>  	if (dev->keys != NULL)
>  		return -EEXIST;
>  
> -	dev->keys = keys;
> +	new = g_slist_copy(keys);
> +
> +	for (n = new, l = keys; l && n; l = l->next, n = n->next) {
> +		struct link_key_info *orig;
> +
> +		orig = l->data;
> +
> +		n->data = g_malloc0(sizeof(*orig) + orig->dlen);
> +		memcpy(n->data, orig, sizeof(*orig) + orig->dlen);

you don't need to add a memset via g_malloc0 here. And do we really not
wanna check the memory allocation here?

Regards

Marcel


