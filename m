Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Sep 2011 16:44:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 3/8] MAP Tracker: Add support for DBus connection
Message-ID: <20110906134408.GA796@dell.ger.corp.intel.com>
References: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
 <1314953880-4663-3-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314953880-4663-3-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Fri, Sep 02, 2011, Bartosz Szatkowski wrote:
> ---
>  plugins/messages-tracker.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)

I think you might be breaking some record for "number of issues per
lines of code" with this patch. If you're not already doing internal
patch reviews you should probably consider starting this practice.

> +static DBusConnection *dbus_get_connection(DBusBusType type)
> +{
> +	DBusError err;
> +	DBusConnection *tmp;
> +
> +	dbus_error_init(&err);
> +
> +	tmp = dbus_bus_get(type, &err);
> +
> +	if (dbus_error_is_set(&err))
> +		error("Connection Error (%s)", err.message);
> +
> +	if (!tmp)
> +		error("Error when getting on bus");
> +
> +	dbus_error_free(&err);
> +
> +	return tmp;
> +}

- Just get rid of this helper function and call dbus_bus_get() directly
  in messages_init

- Avoid variables with generic names like tmp. Instead call it e.g.
  conn. I saw this elsewhere in your patches too -- please fix those.

- Your error handling is messed up. You should only call dbus_error_free
  when you know that dbus_error_is_set is true. Also, if you check for
  the DBusError you shouldn't need to check for NULL.

>  int messages_init(void)
>  {
> +	DBusError err;
> +	dbus_error_init(&err);

What's the purpose of err? All you do with it is call dbus_error_init.
It's not used anywhere later in this function.

In its simplest form all you would have needed is:

	if (session_bus == NULL)
		session_bus = dbus_but_get(DBUS_BUS_SESSION, NULL);

	if (session_bus == NULL) {
		error("Unable to connect to the session bus");
		return -1;
	}

Is it valid behavior for messages_init to be called multiple times? If
not then the first NULL-check isn't really needed (at most you could
have an assert there).

> +	if (session_connection == NULL)
> +		session_connection = dbus_get_connection(DBUS_BUS_SESSION);
> +
> +	if (!session_connection)
> +		return -1;
> +

Either check for NULL with == or with ! but don't mix them. I know we
have inconsistencies within the source tree but try to at least be
consistent within your own code.

Also, you're introducing a memory leak: you should call
dbus_connection_unref and set session_bus to NULL in the messages_exit
function.

Johan
