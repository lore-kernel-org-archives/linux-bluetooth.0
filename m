Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2014 19:41:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v5 07/16] gatt: Assign read callback for external
 services
Message-ID: <20140320174135.GA21300@t440s.P-661HNU-F1>
References: <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395174391-27251-8-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395174391-27251-8-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Mar 18, 2014, Claudio Takahasi wrote:
> This patch adds the callback for reading the external characteristic
> Value. Internally, GDBusProxy implementation tracks all properties Value
> changes consequently Value can be ready directly from the proxy without
> additional method calls.
> ---
>  src/gatt-dbus.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)

The first 6 patches have been applied. However:

> +static void proxy_read_cb(struct btd_attribute *attr,
> +				btd_attr_read_result_t result, void *user_data)
> +{
> +	DBusMessageIter iter, array;
> +	GDBusProxy *proxy;
> +	uint8_t *value;
> +	int len;
> +
> +	/*
> +	 * Remote device is trying to read the informed attribute,
> +	 * "Value" should be read from the proxy. GDBusProxy tracks
> +	 * properties changes automatically, it is not necessary to
> +	 * get the value directly from the GATT server.
> +	 */
> +	proxy = g_hash_table_lookup(proxy_hash, attr);
> +	if (proxy == NULL) {
> +		result(ENOENT, NULL, 0, user_data);
> +		return;
> +	}
> +
> +	if (!g_dbus_proxy_get_property(proxy, "Value", &iter)) {
> +		/* Unusual situation, read property will checked earlier */
> +		result(EPERM, NULL, 0, user_data);
> +		return;
> +	}
> +
> +	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
> +		DBG("External service inconsistent!");
> +		result(EPERM, NULL, 0, user_data);
> +		return;
> +	}

Whenever we have "int err" variables a negative value denotes an error.
Let's keep this convention consistent throughout the code base.

Johan
