Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:19:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/9] Register Health Thermometer Interface
Message-ID: <20111010071906.GC4094@fusion.localdomain>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317303988-26310-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Sep 29, 2011, Santiago Carot-Nemesio wrote:
> +struct thermometer {
> +	DBusConnection          *conn;		/* The connection to the bus */
> +	struct btd_device       *dev;		/* Device reference */
> +	struct att_range	*svc_range;	/* Thermometer range */
> +};

This struct has inconsistent indentation between the variable types and
their names. The first two ones use spaces whereas the third one uses a
tab.

> +static void destroy_thermometer(gpointer user_data)
> +{
> +	struct thermometer *t = user_data;
> +
> +	dbus_connection_unref(t->conn);
> +	btd_device_unref(t->dev);
> +	g_free(t->svc_range);
> +        g_free(t);

Incorrect indentation for the last line (just spaces).

> +	}
> +
> +	thermometers = g_slist_prepend(thermometers, t);
>  	return 0;

Minor nitpick: add an empty line before the return statement.

Johan
