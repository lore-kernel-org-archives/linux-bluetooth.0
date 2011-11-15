Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Remove driver only if remote has no matching UUID
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Dmitriy Paliy <dmitriy.paliy@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Daniel Orstadius <daniel.orstadius@nokia.com>
Date: Tue, 15 Nov 2011 11:30:01 +0900
In-Reply-To: <20111114120323.GC10396@fusion.localdomain>
References: <1321208730-22957-1-git-send-email-dmitriy.paliy@nokia.com>
	 <1321208730-22957-2-git-send-email-dmitriy.paliy@nokia.com>
	 <20111114120323.GC10396@fusion.localdomain>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321324204.15441.477.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > Service discovery may generate a list of removed UUIDs. Previously
> > BlueZ promptly removed the btd_device_driver mapped to each
> > missing UUID.
> > 
> > With this patch it first checks if the remote has any remaining
> > UUID mapped to the driver, since each driver is used for several
> > UUIDs.
> > 
> > In case the driver is kept, the interface corresponding to the UUID
> > will not be removed (the patch deletes too little instead of too
> > much).
> > ---
> >  src/device.c |   63 ++++++++++++++++++++++++++++++++++++---------------------
> >  1 files changed, 40 insertions(+), 23 deletions(-)
> > 
> > diff --git a/src/device.c b/src/device.c
> > index d624b46..f7bff75 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -1187,29 +1187,6 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
> >  
> >  	records = read_records(&src, &device->bdaddr);
> >  
> > -	DBG("Removing drivers for %s", dstaddr);
> > -
> > -	for (list = device->drivers; list; list = next) {
> > -		struct btd_device_driver *driver = list->data;
> > -		const char **uuid;
> > -
> > -		next = list->next;
> > -
> > -		for (uuid = driver->uuids; *uuid; uuid++) {
> > -			if (!g_slist_find_custom(uuids, *uuid,
> > -						(GCompareFunc) strcasecmp))
> > -				continue;
> > -
> > -			DBG("UUID %s was removed from device %s",
> > -							*uuid, dstaddr);
> > -
> > -			driver->remove(device);
> > -			device->drivers = g_slist_remove(device->drivers,
> > -								driver);
> > -			break;
> > -		}
> > -	}
> > -
> >  	for (list = uuids; list; list = list->next) {
> >  		sdp_record_t *rec;
> >  
> > @@ -1228,6 +1205,46 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
> >  
> >  	if (records)
> >  		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
> > +
> > +	DBG("Checking if drivers need to be removed for %s", dstaddr);
> > +
> > +	for (list = device->drivers; list; list = next) {
> > +		struct btd_device_driver *driver = list->data;
> > +		const char **uuid;
> > +
> > +		next = list->next;
> > +
> > +		for (uuid = driver->uuids; *uuid; uuid++) {
> > +			const char **uuid2;
> > +			gboolean found = FALSE;
> > +
> > +			if (!g_slist_find_custom(uuids, *uuid,
> > +						(GCompareFunc) strcasecmp))
> > +				continue;
> > +
> > +			DBG("UUID %s was removed from device %s",
> > +							*uuid, dstaddr);
> > +
> > +			/* check if there is any uuid for the driver
> > +			on the remote */
> > +			for (uuid2 = driver->uuids; *uuid2; uuid2++) {
> > +				if (g_slist_find_custom(device->uuids, *uuid2,
> > +					       (GCompareFunc) strcasecmp)) {
> 
> Mixed tabs and spaces in the last line above.
> 
> > +					found = TRUE;
> > +					break;
> > +				}
> > +			}
> > +
> > +			if (!found) {
> > +				error("Removing driver for %s", *uuid);
> > +				driver->remove(device);
> > +				device->drivers = g_slist_remove(
> > +						device->drivers, driver);
> > +			}
> > +
> > +			break;
> > +		}
> > +	}
> 
> In general this code is really quite hard to follow. I had to read it
> through many times to be sure that it's doing the right thing. Since I
> don't want to go through all that work every time I have to come back to
> this code in the future I'd like to make it saner. I think one way to
> accomplish that is through reference counting instead of constantly
> iterating through the various lists and figuring out their
> relationships.
> 
> So, what I'd propose is to have each successfully probed UUID contribute
> a reference to the driver probed. This means that instead of a simple
> UUID string you'll need to have a string + list of drivers the UUID has
> been successfully probed for.  Also, the driver list for the device
> needs to be constructed out of (also new) structs consisting of a
> reference count and a pointer to the btd_device_driver. When a UUID gets
> removed the reference gets decremented and once it reaches 0 the
> driver->remove() callback can be called (which should be much easier to
> understand than your multiple nested for-loops and GSList lookups).
> 
> Another question that rises here is do we need some callback to the
> driver to let it know that a subset of its UUIDs have been removed.
> After all, we give the full set in when probing the driver so it will
> think that all UUIDs are there until remove() is called. In your case
> we're dealing with HSP which doesn't really affect much, but if AVRCP
> was removed (but all other profiles left intact) then the
> org.bluez.Control interface should be removed. With your patch this
> wouldn't happen.
> 
> My initial feeling is that we do want to let the driver know of a subset
> of UUIDs being removed. I.e. we let the driver do the UUID counting
> instead of the core daemon (and then you wont need the reference count
> stuff like I proposed above). The device driver API options then become:
> 
> 	int probe(struct btd_device *device, GSList *uuids);
> 	void remove(struct btd_device, *device, GSlist *uuids);
> 
> or:
> 
> 	int probe(struct btd_device *device, const char *uuid);
> 	void remove(struct btd_device, *device, const char *uuid);
> 
> From an implementation standpoint I think the later might end up
> producing simpler code. Thinking about this now I have a feeling that we
> might have considered both approaches when designing the API and for
> some reason opted against it. So I'd like to hear some extra opinions on
> this (especially from Marcel) before selecting a specific solution.

so our general approach is against any kind of GLib types for exported
functions to plugins/drivers. So the first approach is off the table.

For the second one, I do not remember. It might have been that we wanted
to keep the probe() functions simple. Maybe this needs to be revisited.

Regards

Marcel


