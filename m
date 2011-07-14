Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 17:44:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 08/12] Drop GAttrib ref if callback list is empty
Message-ID: <20110714144444.GB26341@dell.ger.corp.intel.com>
References: <1309874168-32716-9-git-send-email-claudio.takahasi@openbossa.org>
 <1309987430-10111-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309987430-10111-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Jul 06, 2011, Claudio Takahasi wrote:
> If all ATT connection callbacks are unregistered, GAttrib reference
> can be dropped.
> ---
>  src/device.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Patches 1-7 have been applied, but this one looked strange:

> --- a/src/device.c
> +++ b/src/device.c
> @@ -2605,10 +2605,15 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
>  
>  	g_free(attio);
>  
> +	if (device->attios != NULL)
> +		return TRUE;
> +
>  	if (device->attioid) {
>  		g_source_remove(device->attioid);
>  		device->attioid = 0;
>  	}
>  
> +	g_attrib_unref(device->attrib);
> +
>  	return TRUE;
>  }

Looks like you're missing a device->attrib = NULL; after the unref.

Johan
