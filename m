Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jun 2014 13:49:37 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] SDP: Make sdp_set_access_protos() return void
Message-ID: <20140612104936.GC27592@aemeltch-MOBL1>
References: <1402315699-30381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1402315699-30381-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <31CD08C4-C776-4F0F-A0D6-2DD5CB854639@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <31CD08C4-C776-4F0F-A0D6-2DD5CB854639@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 09, 2014 at 02:10:24PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Function always returns 0, so there is sense to make it void function.
> > ---
> > lib/sdp.c     | 6 +-----
> > lib/sdp_lib.h | 2 +-
> > 2 files changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/sdp.c b/lib/sdp.c
> > index e5e4622..da26b78 100644
> > --- a/lib/sdp.c
> > +++ b/lib/sdp.c
> > @@ -2380,10 +2380,8 @@ static sdp_data_t *access_proto_to_dataseq(sdp_record_t *rec, sdp_list_t *proto)
> >  *
> >  * This function replaces the existing sdp_access_proto_t
> >  * structure (if any) with the new one specified.
> > - *
> > - * returns 0 if successful or -1 if there is a failure.
> >  */
> > -int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
> > +void sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
> 
> if this is libbluetooth API, then we can not do that. I am not planning to break that API.
> 

Is libbluetooth API internal API and only used in our code?

Best regards 
Andrei Emeltchenko
