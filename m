Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Sep 2012 15:59:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] gatt: Translate Characteristic names
Message-ID: <20120903125940.GA942@x220>
References: <1346671769-10072-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346671769-10072-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Mon, Sep 03, 2012, chen.ganir@ti.com wrote:
> +static const struct characteristic_info charInfo[] = {

Only lower-case symbol names please, i.e. char_info[].

> +static const char *get_char_name(const char *uuid)
> +{
> +	const struct characteristic_info *c;
> +
> +	for (c = charInfo; c->uuid; c++) {
> +		if (g_strcmp0(c->uuid, uuid) == 0)

Since these strings are in hexadecimal format you'd need to check both
lower and upper case characters. So probably strcasecmp is best (you
should anyway have a guarantee that both c->uuid and uuid are non-NULL).
You could also use bt_uuid_strcmp from lib/uuid.h which was recently
added to help g_slist_find_custom and similar situations.

> +	if (name != NULL)
> +		dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &name);

"if (name)" would be more consistent with the rest of the code, such as
the lines coming right after it:

>  	if (chr->desc)
>  		dict_append_entry(&dict, "Description", DBUS_TYPE_STRING,

Johan
