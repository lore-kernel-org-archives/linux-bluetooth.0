Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Jul 2009 10:37:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] add support for multiple serial proxies configuration
Message-ID: <20090724073753.GA18981@jh-x301>
References: <1248405500-3197-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248405500-3197-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Fri, Jul 24, 2009, Forrest Zhao wrote:
> ---
>  serial/Makefile.am |    2 +
>  serial/proxy.c     |  230 +++++++++++++++++++++++++++++++++++++++-------------
>  serial/serial.conf |   10 +++
>  3 files changed, 184 insertions(+), 58 deletions(-)
>  create mode 100644 serial/serial.conf

I finally pushed this upstream but still had to make quite a lot of
changes.

> +		return g_dbus_create_error(msg, ERROR_INTERFACE "Failed",
> +				"Proxy enable failed (%s)",  strerror(-err));

Two spaces before strerror.

>  	g_dbus_emit_signal(adapter->conn,
>  			adapter_get_path(adapter->btd_adapter),
>  			SERIAL_MANAGER_INTERFACE, "ProxyCreated",
> -			DBUS_TYPE_STRING, &ppath,
> +			DBUS_TYPE_STRING, &path,
>  			DBUS_TYPE_INVALID);

These could be indented at least with one more tab.

> +static DBusMessage *create_proxy(DBusConnection *conn,
> +				DBusMessage *msg, void *data)
> +{
> +	struct serial_adapter *adapter = data;
> +	char path[MAX_PATH_LENGTH + 1];
> +	const char *pattern, *address;
> +	char *uuid_str, *ppath = path;
> +	uuid_t uuid;

The uuid variable is never used in this function except for getting set
once by the following:

> +	bt_string2uuid(&uuid, uuid_str);

> +static void serial_proxy_init(struct serial_adapter *adapter)
> +{
> +	GKeyFile *config;
> +	GError *gerr = NULL;
> +	const char *file = CONFIGDIR "/serial.conf";
> +	char **group_list;
> +	int i;
> +
> +	config = g_key_file_new();
> +
> +	if (!g_key_file_load_from_file(config, file, 0, &gerr)) {
> +		error("Parsing %s failed: %s", file, gerr->message);
> +		g_error_free(gerr);
> +		g_key_file_free(config);
> +		return;
> +	}
> +
> +	group_list = g_key_file_get_groups(config, NULL);
> +
> +	for (i = 0; group_list[i] != NULL; i++) {
> +		char *group_str = group_list[i], *uuid_str, *address;
> +		uuid_t uuid;

Same with this uuid variable.

> +		/* string length of "Proxy" is 5 */
> +		if (strlen(group_str) < 5 || strncmp(group_str, "Proxy", 5))
> +			continue;

Hmm, I actually forgot to change this one, but isn't just the strncmp call
enough here (i.e. no need for strlen)?

> +		uuid_str = g_key_file_get_string(config, group_str, "UUID",
> +							&gerr);
> +		if (gerr) {
> +			debug("%s: %s", file, gerr->message);
> +			g_error_free(gerr);
> +			g_key_file_free(config);
> +			return;
> +		}
> +		address = g_key_file_get_string(config, group_str, "Address",
> +							&gerr);
> +		if (gerr) {

There should be an empty line before address = ...

> +				if (err < 0)
> +					error("Proxy enable failed (%s)",
> +							 strerror(-err));

Mixing tabs and spaces for indentation.

> +	g_strfreev(group_list);
> +	g_key_file_free(config);
> +	return;
> +}

Redundant return statement at the end of void function.

> diff --git a/serial/serial.conf b/serial/serial.conf
> new file mode 100644
> index 0000000..982dcdd
> --- /dev/null
> +++ b/serial/serial.conf
> @@ -0,0 +1,10 @@
> +# Configuration file for serial
> +
> +# There could be multiple proxy sections, the format is [Proxy <user chosen name>]
> +[Proxy DUN]
> +
> +# UUID for DUN proxy service
> +#UUID=00001103-0000-1000-8000-00805F9B34FB
> +
> +# Address for device node
> +#Address=/dev/ttyx

I think the [Proxy DUN] should also be commented out along with the other
lines.

Even after these changes there are still the following issues that need
fixing:

1. After creating a proxy through serial.conf the first time bluetoothd
stores some info about it in /var/lib/bluetooth/.../proxy. The next time
bluetoothd starts it fails to register (or at least I don't see the local
service record anymore)

2. The UUID in the service record should be reduced to 16 or 32 bit format
if it is derived from the Bluetooth base UUID.

3. The Name attribute for the records should (if we are going to keep them
generic) "Serial Proxy" instead of the current (imho confusing) "Port
Proxy Entity".

Johan
