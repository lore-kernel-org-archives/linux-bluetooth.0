Return-Path: <cyrus@holtmann.org>
Message-ID: <20110916103553.15662dyub01c99wk@mail.hendrik-sattler.de>
Date: Fri, 16 Sep 2011 10:35:53 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH BlueZ] Fix allocation of attribute values
References: <1316113131-10944-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1316113131-10944-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Anderson Lizardo <anderson.lizardo@openbossa.org>:

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
>
> Now that pointers to attribute are passed as reference to functions
> we cannot have they change during run time, what g_try_realloc()
> could do.
> ---
>  attrib/att.h        |    2 +-
>  src/attrib-server.c |   33 ++++++++++++++++++++++++---------
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/attrib/att.h b/attrib/att.h
> index 3b8c098..9db8065 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -130,7 +130,7 @@ struct attribute {
>  	uint8_t (*write_cb)(struct attribute *a, gpointer user_data);
>  	gpointer cb_user_data;
>  	int len;
> -	uint8_t data[0];
> +	uint8_t *data;
>  };
>
>  struct att_data_list {
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 0bda1e3..5c86085 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -270,7 +270,9 @@ static struct attribute  
> *client_cfg_attribute(struct gatt_channel *channel,
>
>  		/* Create a private copy of the Client Characteristic
>  		 * Configuration attribute */
> -		a = g_malloc0(sizeof(*a) + vlen);
> +		a = g_new0(struct attribute, 1);
> +		a->data = g_malloc0(vlen);

Here you assign the pointer...

> +
>  		memcpy(a, orig_attr, sizeof(*a));

...and here your overwrite it.
Hint: if that is written as
    *a = *orig_attr;
you get a compile-time type check for free.

>  		memcpy(a->data, value, vlen);

And here you do...hmm...hard to tell since the pointer now shows to...where?
Even if that pointer is valid and is assigned the right size memory,  
you just leaked memory.

> @@ -1242,7 +1252,9 @@ struct attribute *attrib_db_add(uint16_t  
> handle, bt_uuid_t *uuid, int read_reqs,
>  	if (g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp))
>  		return NULL;
>
> -	a = g_malloc0(sizeof(struct attribute) + len);
> +	a = g_new0(struct attribute, 1);
> +	a->data = g_malloc0(len);
> +
>  	a->handle = handle;
>  	memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));

This could also use assignement-instead-of-memcpy but that's  
out-of-scope of this patch?

>  	a->read_reqs = read_reqs;
> @@ -1268,21 +1280,23 @@ int attrib_db_update(uint16_t handle,  
> bt_uuid_t *uuid, const uint8_t *value,
>  	if (!l)
>  		return -ENOENT;
>
> -	a = g_try_realloc(l->data, sizeof(struct attribute) + len);
> -	if (a == NULL)
> +	a = l->data;
> +
> +	a->data = g_try_realloc(a->data, len);
> +	if (a->data == NULL)
>  		return -ENOMEM;
>
> -	l->data = a;
> -	if (uuid != NULL)
> -		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
>  	a->len = len;
>  	memcpy(a->data, value, len);
>
> -	attrib_notify_clients(a);
> +	if (uuid != NULL)
> +		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));

But here you could write: a->uuid = *uuid;

HS


