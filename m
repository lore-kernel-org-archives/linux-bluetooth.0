Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 May 2011 02:24:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove unneeded list when removing a device driver
Message-ID: <20110514232454.GF28969@dell.ger.corp.intel.com>
References: <1304627636-22358-1-git-send-email-claudio.takahasi@openbossa.org>
 <1304627636-22358-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304627636-22358-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, May 05, 2011, Claudio Takahasi wrote:
> ---
>  src/device.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index b0a6542..694a3df 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1168,7 +1168,7 @@ add_uuids:
>  static void device_remove_drivers(struct btd_device *device, GSList *uuids)
>  {
>  	struct btd_adapter *adapter = device_get_adapter(device);
> -	GSList *list, *next;
> +	GSList *list;
>  	char srcaddr[18], dstaddr[18];
>  	bdaddr_t src;
>  	sdp_list_t *records;
> @@ -1181,12 +1181,10 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
>  
>  	DBG("Removing drivers for %s", dstaddr);
>  
> -	for (list = device->drivers; list; list = next) {
> +	for (list = device->drivers; list; list = list->next) {
>  		struct btd_device_driver *driver = list->data;
>  		const char **uuid;
>  
> -		next = list->next;
> -
>  		for (uuid = driver->uuids; *uuid; uuid++) {
>  			if (!g_slist_find_custom(uuids, *uuid,
>  						(GCompareFunc) strcasecmp))

I don't think this change is necessarily safe. Since the loop is making
a callback to code that it doesn't control there's a risk that the
callback could end up freeing the current pointer.

Johan
