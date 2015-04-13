Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/4] core/advertising: Parse IncludeTXPower
Date: Mon, 13 Apr 2015 14:13:41 +0200
Message-ID: <2942014.61BU9RGTfW@leonov>
In-Reply-To: <1428692768-31941-3-git-send-email-jamuraa@chromium.org>
References: <1428692768-31941-1-git-send-email-jamuraa@chromium.org> <1428692768-31941-3-git-send-email-jamuraa@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Friday 10 of April 2015 12:06:06 Michael Janssen wrote:
> Parse the IncludeTXPower property of the advertisement object, and
> pass the appropriate flag to MGMT if it is set.
> 
> Uses MGMT Read Advertising Features Command to determine the maximum
> length allowed.
> ---
>  src/advertising.c | 79
> +++++++++++++++++++++++++++++++++++++++++++++++++++---- 1 file changed, 74
> insertions(+), 5 deletions(-)
> 
> diff --git a/src/advertising.c b/src/advertising.c
> index 2f8e539..8acd5b4 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -46,6 +46,7 @@ struct btd_advertising {
>  	struct queue *ads;
>  	struct mgmt *mgmt;
>  	uint16_t mgmt_index;
> +	uint8_t max_adv_len;
>  };
> 
>  #define AD_TYPE_BROADCAST 0
> @@ -59,6 +60,7 @@ struct advertisement {
>  	GDBusProxy *proxy;
>  	DBusMessage *reg;
>  	uint8_t type; /* Advertising type */
> +	bool include_tx_power;
>  	struct bt_ad *data;
>  	uint8_t instance;
>  };
> @@ -361,6 +363,22 @@ fail:
>  	return false;
>  }
> 
> +static bool parse_advertising_include_tx_power(GDBusProxy *proxy,
> +							bool *included)
> +{
> +	DBusMessageIter iter;
> +
> +	if (!g_dbus_proxy_get_property(proxy, "IncludeTXPower", &iter))
> +		return true;
> +
> +	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
> +		return false;
> +
> +	dbus_message_iter_get_basic(&iter, included);

Due to historical reasons dbus_bool_t is 4 bytes long (check dbus-types.h)
To be on a safe side I'd do:

dbus_bool_t b;

dbus_message_iter_get_basic(&iter, &b);

*included = b;


> +
> +	return true;
> +}
> +
>  static void add_advertising_callback(uint8_t status, uint16_t length,
>  					  const void *param, void *user_data)
>  {
> @@ -375,19 +393,44 @@ static void add_advertising_callback(uint8_t status,
> uint16_t length, ad->instance = rp->instance;
>  }
> 
> +static size_t calc_max_adv_len(struct advertisement *ad,
> +								uint32_t flags)

nitpick: this should fit in single line

> +{
> +	size_t max = ad->manager->max_adv_len;
> +
> +	if (flags & MGMT_ADV_FLAG_TX_POWER)
> +		max -= 3;

At least comment on where those 3/4 bytes came from.

> +
> +	if (flags & (MGMT_ADV_FLAG_DISCOV | MGMT_ADV_FLAG_LIMITED_DISCOV |
> +						MGMT_ADV_FLAG_MANAGED_FLAGS))
> +		max -= 3;
> +
> +	if (flags & MGMT_ADV_FLAG_APPEARANCE)
> +		max -= 4;
> +
> +	return max;
> +}
> +
>  static DBusMessage *refresh_advertisement(struct advertisement *ad)
>  {
>  	struct mgmt_cp_add_advertising *cp;
>  	uint8_t param_len;
>  	uint8_t *adv_data;
>  	size_t adv_data_len;
> +	uint32_t flags = 0;
> 
>  	DBG("Refreshing advertisement: %s", ad->path);
> 
> +	if (ad->type == AD_TYPE_PERIPHERAL)
> +		flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
> +
> +	if (ad->include_tx_power)
> +		flags |= MGMT_ADV_FLAG_TX_POWER;
> +
>  	adv_data = bt_ad_generate(ad->data, &adv_data_len);
> 
> -	if (!adv_data) {
> -		error("Advertising data couldn't be generated.");
> +	if (!adv_data || (adv_data_len > calc_max_adv_len(ad, flags))) {
> +		error("Advertising data too long or couldn't be generated.");
> 
>  		return g_dbus_create_error(ad->reg, ERROR_INTERFACE
>  						".InvalidLength",
> @@ -406,9 +449,7 @@ static DBusMessage *refresh_advertisement(struct
> advertisement *ad) return btd_error_failed(ad->reg, "Failed");
>  	}
> 
> -	if (ad->type == AD_TYPE_PERIPHERAL)
> -		cp->flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
> -
> +	cp->flags = flags;
>  	cp->instance = ad->instance;
>  	cp->adv_data_len = adv_data_len;
>  	memcpy(cp->data, adv_data, adv_data_len);
> @@ -457,6 +498,12 @@ static DBusMessage *parse_advertisement(struct
> advertisement *ad) goto fail;
>  	}
> 
> +	if (!parse_advertising_include_tx_power(ad->proxy,
> +						&ad->include_tx_power)) {
> +		error("Property \"IncludeTXPower\" failed to parse");
> +		goto fail;
> +	}
> +
>  	return refresh_advertisement(ad);
> 
>  fail:
> @@ -636,6 +683,20 @@ static void advertising_manager_destroy(void
> *user_data) free(manager);
>  }
> 
> +static void read_adv_features_callback(uint8_t status, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	struct btd_advertising *manager = user_data;
> +	const struct mgmt_rp_read_adv_features *feat = param;
> +
> +	if (status || !param) {
> +		error("Failed to read advertising features");

I'd print status error here as well.

> +		return;
> +	}

Usually we check if daemon got enough bytes in response before accessing it:

if (length < sizeof(*rp)) {
         error("Wrong size of read adv features response");
         return;
}

> +
> +	manager->max_adv_len = feat->max_adv_data_len;
> +}
> +
>  static struct btd_advertising *
>  advertising_manager_create(struct btd_adapter *adapter)
>  {
> @@ -657,6 +718,14 @@ advertising_manager_create(struct btd_adapter *adapter)
> 
>  	manager->mgmt_index = btd_adapter_get_index(adapter);
> 
> +	if (!mgmt_send(manager->mgmt, MGMT_OP_READ_ADV_FEATURES,
> +				manager->mgmt_index, 0, NULL,
> +				read_adv_features_callback, manager, NULL)) {
> +		error("Cannot read advertising features, MGMT version too low");

I'm not sure if you get unsupported failure here since that needs to come from 
kernel in response. So this error message doesn't seem right.


> +		advertising_manager_destroy(manager);
> +		return NULL;
> +	}
> +
>  	if (!g_dbus_register_interface(btd_get_dbus_connection(),
>  						adapter_get_path(adapter),
>  						LE_ADVERTISING_MGR_IFACE,

-- 
BR
Szymon Janc
