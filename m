Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Apr 2010 18:30:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Francisco Alecrim <francisco.alecrim@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Report local services(UUIDs) through DBus
Message-ID: <20100407153000.GA27553@jh-x301>
References: <1270652663-23107-1-git-send-email-francisco.alecrim@openbossa.org>
 <1270652663-23107-2-git-send-email-francisco.alecrim@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1270652663-23107-2-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alecrim,

A few more minor correction suggestions:

On Wed, Apr 07, 2010, Francisco Alecrim wrote:
> +	emit_array_property_changed(connection, adapter->path,
> +			ADAPTER_INTERFACE, "UUIDs",
> +			DBUS_TYPE_STRING, &uuids);

The general rule for continuation line indenting is: indent as much as
possible as long as the total length doesn't go beyond 80. It looks like
these two lines could be indented a bit more. There are a few other
similar places too but I think you should be able to find them by
yourself.

> +	for (i = 0; uuids[i]; i++)
> +		g_free(uuids[i]);
> +	g_free(uuids);

These three lines could be replaced simply with g_strfreev(uuids);

> +	for (i = 0; uuids[i]; i++)
> +		g_free(uuids[i]);
> +	g_free(uuids);

And same here.

Johan
