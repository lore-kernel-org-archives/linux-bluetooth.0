Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/gatt: Fix freeing uninitialized attributes
Date: Fri, 16 May 2014 18:24:22 +0200
Message-ID: <1987880.BnWgK9kt0s@athlon>
In-Reply-To: <9A0C0D87-616B-4D33-A61F-85E5F954B77A@holtmann.org>
References: <1400234827-24438-1-git-send-email-marcin.kraglak@tieto.com> <9A0C0D87-616B-4D33-A61F-85E5F954B77A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Friday 16 May 2014 08:17:25 Marcel Holtmann wrote:
> Hi Marcin,
> 
> > Don't free uninitialized attributes. It could cause NULL pointer
> > dereference.
> > ---
> > src/shared/gatt-db.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> > 
> > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> > index d9f63be..36316af 100644
> > --- a/src/shared/gatt-db.c
> > +++ b/src/shared/gatt-db.c
> > @@ -99,6 +99,10 @@ static void attribute_destroy(void *data)
> > {
> > 
> > 	struct gatt_db_attribute *attribute = data;
> > 
> > +	/* Attribute was not initialized by user */
> > +	if (!attribute)
> > +		return;
> > +
> > 
> > 	free(attribute->value);
> > 	free(attribute);
> 
> I think the real question is why a function with void *data is called with a
> NULL pointer in the first place. That is the thing you should fix and not
> hack around this by doing a NULL check. So this is clearly a function that
> you gave to callback somehow, fix that part. I do not remember any of the
> code in src/shared/ that has the destroy callbacks requiring any of this.
> We are expecting that data is valid.

This is due to attributes[] in struct gatt_db_service might not be fully used 
by user (we preallocate handles). But since attribute_destroy() is used only 
from gatt_db_service_destroy() maybe it would be better to check if pointer is 
not NULL there since checking this inside gatt_db_service_destroy() would be 
easier to follow.

Something like this maybe: ?

-static void attribute_destroy(void *data)
+static void attribute_destroy(struct gatt_db_attribute *attribute)
 {
-       struct gatt_db_attribute *attribute = data;
-
-       /* Attribute was not initialized by user */
-       if (!attribute)
-               return;
-
        free(attribute->value);
        free(attribute);
 }
@@ -131,8 +125,13 @@ static void gatt_db_service_destroy(void *data)
        struct gatt_db_service *service = data;
        int i;
 
-       for (i = 0; i < service->num_handles; i++)
+       for (i = 0; i < service->num_handles; i++) {
+               /* Attribute was not initialized by user */
+               if (!service->attributes[i])
+                       continue;
+
                attribute_destroy(service->attributes[i]);
+       }




-- 
Szymon K. Janc
szymon.janc@gmail.com
