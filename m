Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:22:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/9] Add functions to manage attio callbacks
Message-ID: <20111010072259.GE4094@fusion.localdomain>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
 <1317303988-26310-4-git-send-email-sancane@gmail.com>
 <1317303988-26310-5-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317303988-26310-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Sep 29, 2011, Santiago Carot-Nemesio wrote:
> @@ -36,7 +37,9 @@
>  struct thermometer {
>  	DBusConnection          *conn;		/* The connection to the bus */
>  	struct btd_device       *dev;		/* Device reference */
> +	GAttrib			*attrib;	/* GATT connection */
>  	struct att_range	*svc_range;	/* Thermometer range */
> +	gint                    attioid;	/* Att watcher id */
>  };

Looking at the attio.h API, the attioid should be guint and not gint,
right? Also, this struct has the same inconsistency in indentation. Some
lines use spaces whereas other use tabs. Please fix this (though
potentially in a separate coding-style cleanup patch since the
inconsistency exists there already before this patch).

> +	if (t->attioid)
> +		btd_device_remove_attio_callback(t->dev, t->attioid);

Please use if (t->attioid > 0)

Johan
