Return-Path: <cyrus@holtmann.org>
Message-ID: <1357780874.1806.65.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/2] unit: Fix intermitent failure of SDP tests
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 17:21:14 -0800
In-Reply-To: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

change the subject of the commit ;)

> While running tests, the D-Bus library was set to call _exit() when the
> client leaves the bus. This caused the second test to be interrupted
> without providing a PASS/FAIL result. This was confirmed by running
> test-sdp with DBUS_VERBOSE=1.
> 
> This commit disables this behavior, which does not exist on BlueZ
> because g_dbus_set_disconnect_function() implicitly does this.
> ---
>  unit/test-gdbus-client.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
> index 7c849f0..cfbe4e0 100644
> --- a/unit/test-gdbus-client.c
> +++ b/unit/test-gdbus-client.c
> @@ -68,6 +68,10 @@ static struct context *create_context(void)
>  		return NULL;
>  	}
>  
> +	/* Make sure D-Bus library will not call _exit() and interrupt the next
> +	 * tests. */

Can you make this a one-line comment like this or similar:

	/* Avoid D-Bus library calling _exit() before next test */
> +	dbus_connection_set_exit_on_disconnect(context->dbus_conn, FALSE);
> +
>  	return context;
>  }
>  

Regards

Marcel


