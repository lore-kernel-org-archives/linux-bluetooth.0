Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Sep 2010 22:22:58 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Fix headset disconnecting via device disconnect
Message-ID: <20100922192258.GA20756@jh-x301>
References: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Wed, Sep 22, 2010, Radoslaw Jablonski wrote:
> +static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
> +				void *user_data)
> +{
> +	struct audio_device *dev = user_data;
> +	struct dev_priv *priv = dev->priv;
> +
> +	if (priv->state == AUDIO_STATE_DISCONNECTED)
> +		return;
> +
> +	if (priv->disconnecting)
> +		return;
> +
> +	priv->disconnecting = TRUE;
> +
> +	if (dev->control) {
> +		device_remove_control_timer(dev);
> +		avrcp_disconnect(dev);
> +	}
> +
> +	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
> +		sink_shutdown(dev->sink);
> +
> +	if (priv->hs_state != HEADSET_STATE_DISCONNECTED)
> +		headset_shutdown(dev);
> +
> +	priv->disconnecting = FALSE;
> +}

I'd prefer if you keep the behaviour of disconnect_cb roughly the same
as dev_disconnect. I.e. set the flag, disconnect either HFP or A2DP and
then let the state callbacks do the right thing. The way you're using
the new priv->disconnecting flag doesn't seem to make sense here. The
idea of having a flag would be to do the right thing in the asynchronous
state callbacks but you're setting it back to FALSE before returning
from the function which seems to defeat that purpose.

About the other patches, since the existing profile specific callbacks
could mess up the logic together with the new callback I'm fine with a
single patch which adds the new and removes the old callbacks.

Johan
