Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 16:42:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 08/13] heartrate: Add support to enable notifications
Message-ID: <20120921134200.GC16944@x220>
References: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1348139690-26985-9-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348139690-26985-9-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Sep 20, 2012, Andrzej Kaczmarek wrote:
> @@ -238,6 +249,18 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
>  
>  		if (uuid == GATT_CLIENT_CHARAC_CFG_UUID) {
>  			hr->measurement_ccc_handle = handle;
> +
> +			if (g_slist_length(hr->hradapter->watchers) > 0) {
> +				uint8_t value[2];
> +				char *msg;
> +
> +				att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT,
> +									value);
> +				msg = g_strdup("Enable measurement");
> +
> +				gatt_write_char(hr->attrib, handle, value,
> +					sizeof(value), char_write_cb, msg);
> +			}
>  			break;
>  		}

Seems like you could avoid the extra indentation above by inverting the
g_slist_length test:

	if (g_slist_length(hr->hradapter->watchers) == 0)
		break;

	...
	break;

>  	g_dbus_remove_watch(conn, watcher->id);
> +
> +
> +	if (g_slist_length(hradapter->watchers) == 0)

Two consecutive empty lines should never be needed. Please remove one.

Johan
