Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Sep 2012 12:59:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH BlueZ v5 01/14] core: Control connections based on
 adapter state
Message-ID: <20120907095932.GA7057@x220>
References: <1346785482-13359-1-git-send-email-jprvita@openbossa.org>
 <1346785482-13359-2-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1346785482-13359-2-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 04, 2012, João Paulo Rechi Vita wrote:
> +static void set_auto_connect(gpointer data, gpointer user_data)
> +{
> +	struct btd_device *device = data;
> +	gboolean enable = GPOINTER_TO_INT(user_data);
> +
> +	device_set_auto_connect(device, enable);
> +}
> +
>  static void call_adapter_powered_callbacks(struct btd_adapter *adapter,
>  						gboolean powered)
>  {
> @@ -2125,7 +2133,10 @@ static void call_adapter_powered_callbacks(struct btd_adapter *adapter,
>  		btd_adapter_powered_cb cb = l->data;
>  
>  		cb(adapter, powered);
> -       }
> +	}
> +
> +	g_slist_foreach(adapter->devices, set_auto_connect,
> +						GINT_TO_POINTER(powered));

Instead of this GINT_TO_POINTER magic on a variable that isn't even a
gint couldn't you just pass &powered to g_slist_foreach and then in the
callback do:

	gboolean enable = *(gboolean *) user_data;

or

	gboolean *enable = user_data;

	device_set_auto_connect(device, *enable);

Johan
