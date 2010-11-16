Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 16:30:15 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 2/7] Add DBus OOB plugin.
Message-ID: <20101116163015.GC3638@jh-x301>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com>
 <1289922247-20712-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289922247-20712-3-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 16, 2010, Szymon Janc wrote:
> +#define REQUEST_TIMEOUT	(10 * 1000)	/* 10 seconds */

Are you sure 10 seconds is enough. What if the provider does user
interaction? In that case I suppose 30 seconds or even a minute (which I
think we use elsewhere for user interaction) would be better.

> +static DBusMessage *register_provider(DBusConnection *conn, DBusMessage *msg,
> +								void *data)
> +{
> +	const char *path;
> +	const char *name;

Just combine these on the same line.

> +static DBusMessage *unregister_provider(DBusConnection *conn, DBusMessage *msg,
> +								void *data)
> +{
> +	const char *path;
> +	const char *name;

Same here.

> +	if (!provider || !g_str_equal(provider->path, path)
> +			|| !g_str_equal(provider->name, name))
> +		return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
> +				"No such OOB provider registered");

Same thing about line splitting and || as I mentioned in the other
email, i.e. line break comes after || and not before it.

Johan
