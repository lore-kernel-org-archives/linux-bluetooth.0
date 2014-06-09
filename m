Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jun 2014 15:22:17 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] HDP: Fix checking always constant error code
Message-ID: <20140609122215.GA17420@aemeltch-MOBL1>
References: <1402315699-30381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <DAB243FF-0783-4067-BABB-A7AF93F3E71A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DAB243FF-0783-4067-BABB-A7AF93F3E71A@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 09, 2014 at 02:11:14PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > sdp_set_access_protos() always returns 0, there is no sense to check for
> > error code. Fixes compile warnings.
> > ---
> > profiles/health/hdp_util.c | 8 ++------
> > 1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
> > index 58770b5..ff427a6 100644
> > --- a/profiles/health/hdp_util.c
> > +++ b/profiles/health/hdp_util.c
> > @@ -362,7 +362,7 @@ static gboolean set_sdp_services_uuid(sdp_record_t *record, HdpRole role)
> > static gboolean register_service_protocols(struct hdp_adapter *adapter,
> > 						sdp_record_t *sdp_record)
> > {
> > -	gboolean ret;
> > +	gboolean ret = TRUE;
> > 	uuid_t l2cap_uuid, mcap_c_uuid;
> > 	sdp_list_t *l2cap_list, *proto_list = NULL, *mcap_list = NULL;
> > 	sdp_list_t *access_proto_list = NULL;
> > @@ -425,11 +425,7 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
> > 		goto end;
> > 	}
> > 
> > -	if (sdp_set_access_protos(sdp_record, access_proto_list) < 0) {
> > -		ret = FALSE;
> > -		goto end;
> > -	}
> > -	ret = TRUE;
> 
> might better just a comment here explaining that the call always returns success.
> 

This function is used 51 times throughout the code without any check and
comment, I think we might need to add comments there as well.

Best regards 
Andrei Emeltchenko 
