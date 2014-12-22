Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Dec 2014 15:30:57 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/scpp: Fix using freed memory
Message-ID: <20141222133056.GD25294@aemeltch-MOBL1>
References: <1419248953-31147-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <3155639.Ajs76qMxjk@leonov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3155639.Ajs76qMxjk@leonov>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 22, 2014 at 02:13:53PM +0100, Szymon Janc wrote:
> Hi Andrei,
> 
> On Monday 22 of December 2014 13:49:13 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Fixes use after free memory bug.
> > req is assigned to user_data and then freed with destroy_gatt_req(req)
> > ---
> >  android/scpp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/android/scpp.c b/android/scpp.c
> > index 77f48cd..9f60c9f 100644
> > --- a/android/scpp.c
> > +++ b/android/scpp.c
> > @@ -301,8 +301,6 @@ static void refresh_discovered_cb(uint8_t status, GSList
> > *chars, uint16_t start, end;
> >  	bt_uuid_t uuid;
> > 
> > -	destroy_gatt_req(req);
> > -
> >  	if (status) {
> >  		error("Scan Refresh %s", att_ecode2str(status));
> >  		return;
> > @@ -329,6 +327,8 @@ static void refresh_discovered_cb(uint8_t status, GSList
> > *chars,
> > 
> >  	discover_desc(scan, scan->attrib, start, end, &uuid,
> >  					discover_descriptor_cb, user_data);
> > +
> > +	destroy_gatt_req(req);
> >  }
> > 
> >  static void iwin_discovered_cb(uint8_t status, GSList *chars, void
> > *user_data)
> 
> This patch doesn't fix the bug (actually it introduces some memleaks).
> 
> From what I see in code gatt_request is packing userdata passed to 
> discover_desc() so I think fix should be like:
> 
> --- a/android/scpp.c
> +++ b/android/scpp.c
> @@ -328,7 +328,7 @@ static void refresh_discovered_cb(uint8_t status, GSList 
> *chars,
>         bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
>  
>         discover_desc(scan, scan->attrib, start, end, &uuid,
> -                                       discover_descriptor_cb, user_data);
> +                                       discover_descriptor_cb, scan);

This would access wrong memory since scan = req->user_data and req is
freed as I mentioned in the patch above.

Best regards 
Andrei Emeltchenko 

