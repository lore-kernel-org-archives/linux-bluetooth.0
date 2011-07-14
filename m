Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 20:12:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 10/12] Manage GAttrib refs based on registered
 callbacks
Message-ID: <20110714171213.GA30789@dell.ger.corp.intel.com>
References: <1309874168-32716-11-git-send-email-claudio.takahasi@openbossa.org>
 <1309987448-10183-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309987448-10183-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Jul 06, 2011, Claudio Takahasi wrote:
> Connection should not be dropped if there is at least one ATT connection
> callback registered.
> ---
>  src/device.c |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)

Patches 8 and 9 have now been pushed, but there's some reference
counting weirdness going on here again:

> --- a/src/device.c
> +++ b/src/device.c
> @@ -1664,6 +1664,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
>  done:
>  	device->browse = NULL;
>  	browse_request_free(req, shutdown);
> +	g_attrib_unref(device->attrib);
>  }

Where's the device->attrib = NULL?

> @@ -2568,18 +2569,22 @@ guint btd_device_add_attio_callback(struct btd_device *device,
>  	attio->dcfunc = dcfunc;
>  	attio->user_data = user_data;
>  
> -	device->attios = g_slist_append(device->attios, attio);
> -
> -	if (device->attrib && cfunc)
> -		cfunc(device->attrib, user_data);
> +	if (device->attrib) {
> +		/* First element */
> +		if (device->attios == NULL)
> +			device->attrib = g_attrib_ref(device->attrib);

Eh? It looks like attio is supposed to own this reference created by
g_attrib_ref() so you should really be assigning the return value to
attio->attrib. Or is it so that device->attrib is actually there only
for any elements in the device->attios list? If that's the case then
it's fine to have just create device->attrib when you add the first
element to the list and unref + set to NULL when you remove the last
element from the list.

Johan
