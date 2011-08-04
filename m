Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Aug 2011 15:58:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add watch for RFCOMM disconnect to HFP HF role
Message-ID: <20110804125810.GA24323@dell>
References: <1312462310-16965-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1312462310-16965-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Aug 04, 2011, Frédéric Dalleau wrote:
> ---
>  audio/gateway.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/gateway.c b/audio/gateway.c
> index ec0ec5d..200930f 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -188,9 +188,29 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  				(GIOFunc) sco_io_cb, dev);
>  }
>  
> +static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
> +			struct audio_device *dev)
> +{
> +	struct gateway *gw = dev->gateway;
> +
> +	if (cond & G_IO_NVAL)
> +		return FALSE;
> +
> +	if (cond & (G_IO_ERR | G_IO_HUP)) {

Since this function is only called for NVAL, ERR and HUP, do you even
need to have this check here. Maybe you could just get rid of this
second if-statement.

Johan
