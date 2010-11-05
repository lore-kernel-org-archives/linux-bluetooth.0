Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Nov 2010 11:30:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, suraj@atheros.com,
	joakim.xj.ceder@stericsson.com
Subject: Re: [PATCH 2/4] Sim Access Profile Manager
Message-ID: <20101105093032.GA32149@jh-x301>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1288791271-13857-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288791271-13857-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Nov 03, 2010, Waldemar Rymarkiewicz wrote:
> +++ b/sap/main.c
> @@ -0,0 +1,54 @@
> +/*
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>

As discussed off-list, this needs fixing.

> +++ b/sap/manager.c
> @@ -0,0 +1,94 @@
> +/*
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>

Same here.

> +static DBusConnection *connection = NULL;
> +
> +
> +static int sap_server_probe(struct btd_adapter *adapter)

There should never be the need to have two consecutive empty lines.
Please remove one.

> +	const gchar *path = adapter_get_path(adapter);

Please avoid using the glib specific types when standard C types can be
used. I.e. use just "char" here.

> +static void sap_server_remove(struct btd_adapter *adapter)
> +{
> +	const gchar *path = adapter_get_path(adapter);

Same here.

> +++ b/sap/manager.h
> @@ -0,0 +1,21 @@
> +/*
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>

Same copyright fix needed as previously discussed.

> +++ b/sap/server.h
> @@ -0,0 +1,25 @@
> +/*
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>

Same here.

Johan
