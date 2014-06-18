Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jun 2014 11:52:10 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 15/17] HDP: Fix possible memory leak
Message-ID: <20140618085208.GE12463@aemeltch-MOBL1>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1402905472-17643-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <15088061.dzPvxLDqYO@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15088061.dzPvxLDqYO@athlon>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jun 17, 2014 at 10:51:39PM +0200, Szymon Janc wrote:
> Hi Andrei,
> 
> On Monday 16 June 2014 10:57:50 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > ---
> >  profiles/health/hdp_util.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
> > index 7185805..876a105 100644
> > --- a/profiles/health/hdp_util.c
> > +++ b/profiles/health/hdp_util.c
> > @@ -597,6 +597,13 @@ fail:
> >  	return NULL;
> >  }
> > 
> > +static void free_hdp_list(void *list)
> > +{
> > +	sdp_list_t *hdp_list = list;
> > +
> > +	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
> > +}
> > +
> >  static gboolean register_features(struct hdp_application *app,
> >  						sdp_list_t **sup_features)
> >  {
> > @@ -619,16 +626,11 @@ static gboolean register_features(struct
> > hdp_application *app, fail:
> >  	if (hdp_feature != NULL)
> >  		sdp_list_free(hdp_feature, (sdp_free_func_t)sdp_data_free);
> > +	if (sup_features != NULL)
> > +		sdp_list_free(*sup_features, free_hdp_list);
> 
> I have a feeling that this should be fixed in caller code ie 
> register_service_sup_features.

The problem is that it gets allocated here and we return FALSE if
allocation fails for example, so it does make sense to free structure when
FALSE is returned.

> 
> Also sup_features was already dereferences few lines above so this check is 
> not needed (or should it be *sup_features != NULL ?). 

Right, will fix this.

Best regards 
Andrei Emeltchenko 
