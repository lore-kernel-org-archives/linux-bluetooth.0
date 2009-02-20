Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/4] add the basic framework support for HFP Audio
 gateway --  take 2 -- resend
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <ac8af0be0902200542r354d57fbp8a285162c7675d00@mail.gmail.com>
References: <ac8af0be0902200542r354d57fbp8a285162c7675d00@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 Feb 2009 21:19:51 +0100
Message-Id: <1235161191.24255.23.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> +struct gateway {
> +	GIOChannel* rfcomm;
> +	guint rfcomm_watch_id;
> +	GIOChannel* sco;
> +	GIOChannel* sco_server;
> +	gateway_stream_cb_t sco_start_cb;
> +	void* sco_start_cb_data;
> +	DBusMessage* connect_message;
> +	guint ag_features;
> +	guint hold_multiparty_features;
> +	GSList* indies;
> +	gboolean is_dialing;
> +};

it is GIOChannel<space>*rfcomm. And that applies to all other
occurrences, too. Sorry, but coding style fixes first before we do
actual review of the code.

Regards

Marcel


