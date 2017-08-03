Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/5] advertising: Add SupportedFeatures
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170803133252.30700-1-luiz.dentz@gmail.com>
Date: Thu, 3 Aug 2017 17:15:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <21F29442-D1F0-4008-BA46-0FBC26E47F17@holtmann.org>
References: <20170803133252.30700-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds SupportedFeatures so application can detect what features
> are supported by the system.
> ---
> doc/advertising-api.txt |  8 ++++++++
> src/advertising.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 50 insertions(+)
> 
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index 7a29b7095..78c1c04e3 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -116,3 +116,11 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
> Properties	byte AdvertisementInstaces
> 
> 			Number of available advertisement instances.
> +
> +		array{string} SupportedFeatures
> +
> +			List of supported features.
> +
> +			Possible values: "Tx Power"
> +					 "Appearance"
> +					 "Local Name”

we never did this. They should be lowercase and no spaces. So tx-power, appearance, local-name etc.

> diff --git a/src/advertising.c b/src/advertising.c
> index c2af3acb4..195ed9fc1 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -48,6 +48,7 @@ struct btd_adv_manager {
> 	uint16_t mgmt_index;
> 	uint8_t max_adv_len;
> 	uint8_t max_ads;
> +	uint32_t supported_flags;
> 	unsigned int instance_bitmap;
> };
> 
> @@ -738,8 +739,48 @@ static gboolean get_instances(const GDBusPropertyTable *property,
> 	return TRUE;
> }
> 
> +static struct adv_feat {
> +	uint8_t flag;
> +	const char *name;
> +} feats[] = {
> +	{ MGMT_ADV_FLAG_TX_POWER, "Tx Power" },
> +	{ MGMT_ADV_FLAG_APPEARANCE, "Appearance" },
> +	{ MGMT_ADV_FLAG_LOCAL_NAME, "Local Name" },
> +	{ },
> +};
> +
> +static void append_features(struct btd_adv_manager *manager,
> +						DBusMessageIter *iter)
> +{
> +	struct adv_feat *feat;
> +
> +	for (feat = feats; feat && feat->name; feat++) {
> +		if (manager->supported_flags & feat->flag)
> +			dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
> +								&feat->name);
> +	}
> +}
> +
> +static gboolean get_supported_features(const GDBusPropertyTable *property,
> +					DBusMessageIter *iter, void *data)
> +{
> +	struct btd_adv_manager *manager = data;
> +	DBusMessageIter entry;
> +
> +	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +					DBUS_TYPE_STRING_AS_STRING, &entry);
> +
> +	append_features(manager, &entry);
> +
> +	dbus_message_iter_close_container(iter, &entry);
> +
> +	return TRUE;
> +}
> +
> static const GDBusPropertyTable properties[] = {
> 	{ "AdvertisementInstances", "y", get_instances },

Wouldn’t this be AdvertisingInstances?

> +	{ "SupportedFeatures", "as", get_supported_features },
> +	{ }
> };
> 
> static const GDBusMethodTable methods[] = {
> @@ -784,6 +825,7 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
> 
> 	manager->max_adv_len = feat->max_adv_data_len;
> 	manager->max_ads = feat->max_instances;
> +	manager->supported_flags = feat->supported_flags;

Regards

Marcel

