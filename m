Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 14:23:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC obexd v0 1/2] gdbus: Add helper function for error-handling
Message-ID: <20120503112304.GA9270@x220.ger.corp.intel.com>
References: <1336038275-19591-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1336038275-19591-2-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336038275-19591-2-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, May 03, 2012, Mikel Astiz wrote:
> +DBusMessage *g_dbus_steal_from_gerror(DBusMessage *message, const char *name,
> +								GError **err)
> +{
> +	DBusMessage *reply;
> +
> +	reply = g_dbus_create_error(message, name, "%s", (*err)->message);
> +	g_clear_error(err);
> +
> +	return reply;
> +}

Did you consider following the semantics of dbus_set_error_from_message?

The calling code could then look something like:

	if (g_dbus_steal_from_gerror(&gerr, "foo.bar.baz", &reply))
		return reply;

	do other stuff since there was no error...

One thing that bothers me a bit is that you're forcing the use of a
single generic D-Bus error code for what may be a multitude of various
GError codes/domains (the only inherited part being the error message).
It'd be nice if we could somehow provide a mapping table from GError
codes/domains to D-Bus errors and only in the no-match case fall back to
a generic "org.bluez.Error.Failed".

Johan
