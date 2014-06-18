Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jun 2014 11:54:09 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/17] HDP: Fix checking always constant error code
Message-ID: <20140618085407.GF12463@aemeltch-MOBL1>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <2906473.dHrRjz8bhz@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2906473.dHrRjz8bhz@athlon>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jun 17, 2014 at 11:27:13PM +0200, Szymon Janc wrote:
> Hi Andrei,
> 
> On Monday 16 June 2014 10:57:36 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > sdp_set_access_protos() always returns 0, there is no sense to check for
> > error code. Fixes compile warnings.
> > ---
> >  profiles/health/hdp_util.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
> > index 58770b5..ff427a6 100644
> > --- a/profiles/health/hdp_util.c
> > +++ b/profiles/health/hdp_util.c
> > @@ -362,7 +362,7 @@ static gboolean set_sdp_services_uuid(sdp_record_t
> > *record, HdpRole role) static gboolean register_service_protocols(struct
> > hdp_adapter *adapter, sdp_record_t *sdp_record)
> >  {
> > -	gboolean ret;
> > +	gboolean ret = TRUE;
> >  	uuid_t l2cap_uuid, mcap_c_uuid;
> >  	sdp_list_t *l2cap_list, *proto_list = NULL, *mcap_list = NULL;
> >  	sdp_list_t *access_proto_list = NULL;
> > @@ -425,11 +425,7 @@ static gboolean register_service_protocols(struct
> > hdp_adapter *adapter, goto end;
> >  	}
> > 
> > -	if (sdp_set_access_protos(sdp_record, access_proto_list) < 0) {
> > -		ret = FALSE;
> > -		goto end;
> > -	}
> > -	ret = TRUE;
> > +	sdp_set_access_protos(sdp_record, access_proto_list);
> 
> I'd leave setting ret here instead of initializing it to TRUE. 
> 

OK

Best regards 
Andrei Emeltchenko 

