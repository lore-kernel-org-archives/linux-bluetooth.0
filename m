Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 3/4] device: Add support for AddressType property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171213133638.25852-3-szymon.janc@codecoup.pl>
Date: Wed, 13 Dec 2017 14:40:57 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C20507C8-DFDD-4CEB-8CC9-BD32F9BE0285@holtmann.org>
References: <20171213133638.25852-1-szymon.janc@codecoup.pl>
 <20171213133638.25852-3-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> ---
> src/device.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
> 
> diff --git a/src/device.c b/src/device.c
> index 9f9c47807..8ed37a013 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -727,6 +727,22 @@ static gboolean dev_property_get_address(const GDBusPropertyTable *property,
> 	return TRUE;
> }
> 
> +static gboolean property_get_address_type(const GDBusPropertyTable *property,
> +					DBusMessageIter *iter, void *user_data)
> +{
> +	struct btd_device *device = user_data;
> +	const char *str;
> +
> +	if (device->le && device->bdaddr_type == BDADDR_LE_RANDOM)
> +		str = "random";
> +	else
> +		str = "public";
> +
> +	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
> +
> +	return TRUE;
> +}
> +
> static gboolean dev_property_get_name(const GDBusPropertyTable *property,
> 					DBusMessageIter *iter, void *data)
> {
> @@ -2607,6 +2623,7 @@ static const GDBusMethodTable device_methods[] = {
> 
> static const GDBusPropertyTable device_properties[] = {
> 	{ "Address", "s", dev_property_get_address },
> +	{ "AddressType", "s", property_get_address_type },
> 	{ "Name", "s", dev_property_get_name, NULL, dev_property_exists_name },
> 	{ "Alias", "s", dev_property_get_alias, dev_property_set_alias },
> 	{ "Class", "u", dev_property_get_class, NULL,
> @@ -3850,6 +3867,8 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
> 
> 	g_dbus_emit_property_changed(dbus_conn, device->path,
> 						DEVICE_INTERFACE, "Address");
> +	g_dbus_emit_property_changed(dbus_conn, device->path,
> +					DEVICE_INTERFACE, "LEAddressType”);

you need to change it here to AddressType as well.

Regards

Marcel

