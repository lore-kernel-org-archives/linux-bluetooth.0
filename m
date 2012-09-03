Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Sep 2012 12:57:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 03/15] sdp: Use helper functions instead of
 bt_get_unaligned macro
Message-ID: <20120903095739.GA22824@x220>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
 <1346402185-9487-4-git-send-email-szymon.janc@tieto.com>
 <1346429676.23377.22.camel@aeonflux>
 <67335853.UVApWbuK0q@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <67335853.UVApWbuK0q@uw000953>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Sep 03, 2012, Szymon Janc wrote:
> > > This fix number of compilation errors on ARM similar to one below.
> > > 
> > > lib/sdp.c: In function 'sdp_uuid_extract':
> > > lib/sdp.c:1019:27: error: cast increases required alignment
> > > 	of target type [-Werror=cast-align]
> > > lib/sdp.c:1019:27: error: cast increases required alignment
> > > 	of target type [-Werror=cast-align]
> > > lib/sdp.c:1026:27: error: cast increases required alignment
> > > 	of target type [-Werror=cast-align]
> > > lib/sdp.c:1026:27: error: cast increases required alignment
> > > 	of target type [-Werror=cast-align]
> > > 
> > > Change-Id: I587fb99328d7e5b9053af81597bd48b3a4e610ad
> > > ---
> > >  lib/sdp.c |   56 ++++++++++++++++++++++++++++----------------------------
> > >  1 file changed, 28 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/lib/sdp.c b/lib/sdp.c
> > > index 36b4d08..d40500f 100644
> > > --- a/lib/sdp.c
> > > +++ b/lib/sdp.c
> > > @@ -376,27 +376,27 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
> > >  		d->unitSize += sizeof(int8_t);
> > >  		break;
> > >  	case SDP_UINT16:
> > > -		d->val.uint16 = bt_get_unaligned((uint16_t *) value);
> > > +		d->val.uint16 = bt_get_16(value);
> > >  		d->unitSize += sizeof(uint16_t);
> > >  		break;
> > 
> > I do not like this. Either we use be16 here and store it in the native
> > endian converted from the protocol endian or we leave it as it is.
> > 
> > I want clear get_le16 and get_be16 and not another get_16. That just
> > makes the code hard to read.
> 
> This data is already in protocol order, so bt_get_le/be can't be used here.
> If you don't like those non-converting helpers functions other option is to
> use memcpy.

I think the main point is that only PDU buffers used for writing/reading
to/from the connection should contain protocol data order, and anything
else (internal data structures and variables) should be in the host
order. However, since this is a library interface (one which hopefully
will be removed/replaced in the future though) such fixes might not
always be possible, making e.g. your memcpy proposal the best we can do.

Johan
