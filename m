Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Bharat Panda' <bharat.panda@samsung.com>
References: <1439210245-20442-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZK1FhvnZqDYcYjcvzxWuq8jeHjY3a+mHJ79H9+PypOmkA@mail.gmail.com>
In-reply-to: <CABBYNZK1FhvnZqDYcYjcvzxWuq8jeHjY3a+mHJ79H9+PypOmkA@mail.gmail.com>
Subject: RE: [PATCH] gatt-database: Return meaningful ecodes for ccc write
Date: Tue, 11 Aug 2015 14:15:25 +0530
Message-id: <003101d0d412$1df01ec0$59d05c40$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Tuesday, August 11, 2015 2:02 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda
> Subject: Re: [PATCH] gatt-database: Return meaningful ecodes for ccc write
> 
> Hi Gowtham,
> 
> On Mon, Aug 10, 2015 at 3:37 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Removed generic ATT protocol error codes and added Common Profile and
> > Service Error Codes.
> > ---
> >  src/gatt-database.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/src/gatt-database.c b/src/gatt-database.c index
> > 69a814d..defe329 100644
> > --- a/src/gatt-database.c
> > +++ b/src/gatt-database.c
> > @@ -1783,22 +1783,16 @@ static uint8_t ccc_write_cb(uint16_t value, void
> *user_data)
> >                 return 0;
> >         }
> >
> > -       /*
> > -        * TODO: All of the errors below should fall into the so called
> > -        * "Application Error" range. Since there is no well defined error for
> > -        * these, we return a generic ATT protocol error for now.
> > -        */
> > -
> >         if (chrc->ntfy_cnt == UINT_MAX) {
> >                 /* Maximum number of per-device CCC descriptors configured */
> > -               return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> > +               return BT_ERROR_OUT_OF_RANGE;
> 
> This one above Im not complete sure it is the proper error to return, I would
> consider BT_ATT_ERROR_INSUFFICIENT_RESOURCES more appropriated
> here.
> 
> >         }
> >
> >         /* Don't support undefined CCC values yet */
> >         if (value > 2 ||
> >                 (value == 1 && !(chrc->props & BT_GATT_CHRC_PROP_NOTIFY)) ||
> >                 (value == 2 && !(chrc->props &
> BT_GATT_CHRC_PROP_INDICATE)))
> > -               return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> > +               return BT_ERROR_CCC_IMPROPERLY_CONFIGURED;
> >
> >         /*
> >          * Always call StartNotify for an incoming enable and ignore
> > the return @@ -1807,7 +1801,7 @@ static uint8_t ccc_write_cb(uint16_t
> value, void *user_data)
> >         if (g_dbus_proxy_method_call(chrc->proxy,
> >                                                 "StartNotify", NULL, NULL,
> >                                                 NULL, NULL) == FALSE)
> > -               return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> > +               return BT_ERROR_ALREADY_IN_PROGRESS;
> 
> This one should probably return BT_ATT_ERROR_UNLIKELY instead,
> BT_ERROR_ALREADY_IN_PROGRESS shall only be used if there is a request
> ongoing which is not the case here.
> 

I have changed the error codes and sent v1 for the same. Please have a look at it.

> >         __sync_fetch_and_add(&chrc->ntfy_cnt, 1);
> >
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Gowtham Anandha Babu

