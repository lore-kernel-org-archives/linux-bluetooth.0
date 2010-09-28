Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Sep 2010 10:47:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix headset disconnecting via device disconnect
Message-ID: <20100928074440.GA16571@jh-x301>
References: <1285237951-4271-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285237951-4271-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Sep 23, 2010, Radoslaw Jablonski wrote:
> Headsets for proper disconnecting need to disconnect profiles in specified
> order(by ex. disconnect a2dp, then sink and hfp at the end). Instead of
> adding separate callbacks for disconnecting each profile, now adding only
> one callback in audio/device.c for calling audio disconnect functions in
> correct order. New disconnect callback works similarly to dev_disconnect
> from audio/device.c
> ---
>  audio/device.c  |  138 +++++++++++++++++++++++++++++++++++++------------------
>  audio/headset.c |   19 --------
>  audio/sink.c    |   29 ------------
>  audio/source.c  |   33 -------------
>  4 files changed, 93 insertions(+), 126 deletions(-)

Thanks for the patch. It has been pushed upstream with a couple of minor
modifications (which we already discussed offline):

> +	}
> +	else if (new_state == AUDIO_STATE_CONNECTED) {
> +		priv->disconnecting = FALSE;
> +		priv->dc_id = device_add_disconnect_watch(dev->btd_dev,
> +						disconnect_cb, dev, NULL);
> +	}

First of all, coding style: the else if goes on the same line as the {

Secondly, I don't see how disconnecting could be TRUE when going to
CONNECTED state so I removed setting it explicitly to FALSE here.

> +	if (new_state == AUDIO_STATE_DISCONNECTED) {
> +		if (priv->dc_req) {
> +			reply = dbus_message_new_method_return(priv->dc_req);
> +			dbus_message_unref(priv->dc_req);
> +			priv->dc_req = NULL;
> +			g_dbus_send_message(dev->conn, reply);
> +		}
> +		else if (priv->disconnecting)
> +			priv->disconnecting = FALSE;

Again coding style with the else if, and setting the disconnecting flag
to FALSE can be unconditional here in my opinion.

Johan
