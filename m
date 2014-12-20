Return-Path: <cyrus@holtmann.org>
Date: Sat, 20 Dec 2014 10:16:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 09/17] core: gatt: Expose charac. extended
 properties.
Message-ID: <20141220081621.GA27857@t440s.P-661HNU-F1>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
 <1419024965-10375-10-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419024965-10375-10-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Dec 19, 2014, Arman Uguray wrote:
> @@ -521,12 +537,12 @@ static struct {
>  	{ BT_GATT_CHRC_PROP_INDICATE,		"indicate" },
>  	{ BT_GATT_CHRC_PROP_AUTH,		"authenticated-signed-writes" },
>  	{ BT_GATT_CHRC_PROP_EXT_PROP,		"extended-properties" },
> -	{ },
>  	/* Extended Properties */
>  	{ BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE,	"reliable-write" },
>  	{ BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX,	"writable-auxiliaries" },
>  	{ }
>  };
> +static const int ext_props_index = 8;
>  
>  static gboolean characteristic_property_get_flags(
>  					const GDBusPropertyTable *property,
> @@ -534,21 +550,18 @@ static gboolean characteristic_property_get_flags(
>  {
>  	struct characteristic *chrc = data;
>  	DBusMessageIter array;
> +	uint16_t props;
>  	int i;
>  
>  	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
>  
>  	for (i = 0; properties[i].str; i++) {
> -		if (chrc->props & properties[i].prop)
> +		props = i < ext_props_index ? chrc->props : chrc->ext_props;
> +		if (props & properties[i].prop)
>  			dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
>  							&properties[i].str);

This looks quite brittle to me with the hard-coded index and extra logic
in the for-loop. Couldn't you just put the extended properties in their
own array and have a separate for-loop for that?  Also, you could use
the NELEM() macro instead of checking for non-NULL string. You wouldn't
then need an empty element at the end of th array.

Johan
