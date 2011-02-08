Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Feb 2011 15:00:58 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add UUID property to GATT service object
Message-ID: <20110208225958.GA17287@jh-x301>
References: <1296828067-20496-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296828067-20496-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Fri, Feb 04, 2011, Elvis Pf??tzenreuter wrote:
> @@ -962,6 +963,10 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
>  
>  	dict_append_array(&dict, "Characteristics", DBUS_TYPE_OBJECT_PATH,
>  								&chars, i);
> +	uuid = g_strdup(prim->att->uuid);
> +	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
> +
> +	g_free(uuid);
>  	g_free(chars);
>  
>  	dbus_message_iter_close_container(&iter, &dict);

I'd rather avoid the unnecessary memory allocation here. The following
should be enough:

const char *uuid;
...
uuid = prim->att->uuid;
dict_append_entry(..., DBUS_TYPE_STRING, &uuid);

Johan
