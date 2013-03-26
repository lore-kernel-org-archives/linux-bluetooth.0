Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Mar 2013 18:39:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v1 01/11] core: Add btd_service to represent device services
Message-ID: <20130326163945.GA12535@x220.P-661HNU-F1>
References: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1364314434-9796-2-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364314434-9796-2-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Mar 26, 2013, Mikel Astiz wrote:
> +static const char *state2str(btd_service_state_t state)
> +{
> +	switch(state) {
> +	case BTD_SERVICE_STATE_UNAVAILABLE:
> +		return "BTD_SERVICE_STATE_UNAVAILABLE";
> +	case BTD_SERVICE_STATE_DISCONNECTED:
> +		return "BTD_SERVICE_STATE_DISCONNECTED";
> +	case BTD_SERVICE_STATE_CONNECTING:
> +		return "BTD_SERVICE_STATE_CONNECTING";
> +	case BTD_SERVICE_STATE_CONNECTED:
> +		return "BTD_SERVICE_STATE_CONNECTED";
> +	case BTD_SERVICE_STATE_DISCONNECTING:
> +		return "BTD_SERVICE_STATE_DISCONNECTING";
> +	}

Minor thing: Could you just make the strings "unavailable",
"disconnected", etc. The context is already evident from the rest of the
logs (especially the DBG ones) and having something shorter would make
them more readable.

Johan
