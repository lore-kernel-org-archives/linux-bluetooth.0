Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 12:58:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/4] device: Appearance characteristic from GAP
 service
Message-ID: <20120328095841.GA30867@x220>
References: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
 <1332854978-26072-4-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332854978-26072-4-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Tue, Mar 27, 2012, Bruna Moreira wrote:
> @@ -363,15 +367,19 @@ static DBusMessage *get_properties(DBusConnection *conn,
>  
>  	/* Class */
>  	if (read_remote_class(&src, &device->bdaddr, &class) == 0) {
> -		const char *icon = class_to_icon(class);
> +		icon = class_to_icon(class);
>  
>  		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
> +	} else if (read_remote_appearance(&src, &device->bdaddr, &app) == 0) {
> +		/* Appearance */
> +		icon = gap_appearance_to_icon(app);
> +		class = 0;
>  
> -		if (icon)
> -			dict_append_entry(&dict, "Icon",
> -						DBUS_TYPE_STRING, &icon);
> +		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
>  	}

If we don't have a proper remote class value wouldn't it be simpler to
just leave it out from the properties list instead of including a 0
value?

Johan
